# From https://github.com/JDevlieghere/dotfiles

import os
from os import path as p
import fnmatch
import logging
import ycm_core
import re

C_BASE_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-Wsign-compare',
    '-DNDEBUG',
    '-std=c99',
    '-fwrapv',
    '-I/usr/lib/',
    '-I/usr/include/',
    '-I/home/wja/.pyenv/versions/3.6.8/include/python3.6m',
]

CPP_BASE_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-ferror-limit=10000',
    '-DNDEBUG',
    '-std=c++1z',
    '-xc++',
    '-I/usr/lib/',
    '-I/usr/include/',
    '-I/home/wja/.pyenv/versions/3.6.8/include/python3.6m',
]

C_SOURCE_EXTENSIONS = [
    '.c'
]

CPP_SOURCE_EXTENSIONS = [
    '.cpp',
    '.cxx',
    '.cc',
    '.m',
    '.mm'
]

SOURCE_DIRECTORIES = [
    'src',
    'lib'
]

HEADER_EXTENSIONS = [
    '.h',
    '.hxx',
    '.hpp',
    '.hh'
]

HEADER_DIRECTORIES = [
    'include'
]

BUILD_DIRECTORY = 'build'


def IsSourceFile(filename):
    extension = p.splitext(filename)[1]
    return extension in C_SOURCE_EXTENSIONS + CPP_SOURCE_EXTENSIONS


def IsHeaderFile(filename):
    extension = p.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS


def GetCompilationInfoForFile(database, filename):
    if IsHeaderFile(filename):
        basename = p.splitext(filename)[0]
        for extension in C_SOURCE_EXTENSIONS + CPP_SOURCE_EXTENSIONS:
            # Get info from the source files by replacing the extension.
            replacement_file = basename + extension
            if p.exists(replacement_file):
                compilation_info = database.GetCompilationInfoForFile(replacement_file)
                if compilation_info.compiler_flags_:
                    return compilation_info
            # If that wasn't successful, try replacing possible header directory with possible source directories.
            for header_dir in HEADER_DIRECTORIES:
                for source_dir in SOURCE_DIRECTORIES:
                    src_file = replacement_file.replace(header_dir, source_dir)
                    if p.exists(src_file):
                        compilation_info = database.GetCompilationInfoForFile(src_file)
                        if compilation_info.compiler_flags_:
                            return compilation_info
        return None
    return database.GetCompilationInfoForFile(filename)


def FindNearest(path, target, build_folder=None):
    candidate = p.join(path, target)
    if(p.isfile(candidate) or p.isdir(candidate)):
        logging.info("Found nearest " + target + " at " + candidate)
        return candidate;

    parent = p.dirname(p.abspath(path));
    if(parent == path):
        raise RuntimeError("Could not find " + target);

    if(build_folder):
        candidate = p.join(parent, build_folder, target)
        if(p.isfile(candidate) or p.isdir(candidate)):
            logging.info("Found nearest " + target + " in build folder at " + candidate)
            return candidate;

    return FindNearest(parent, target, build_folder)


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = p.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[ len(path_flag): ]
                new_flag = path_flag + p.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags


def FlagsForClangComplete(root):
    try:
        clang_complete_path = FindNearest(root, '.clang_complete')
        clang_complete_flags = open(clang_complete_path, 'r').read().splitlines()
        return clang_complete_flags
    except:
        return None


def FlagsForInclude(root):
    try:
        include_path = FindNearest(root, 'include')
        flags = []
        for dirroot, dirnames, filenames in os.walk(include_path):
            for dir_path in dirnames:
                real_path = p.join(dirroot, dir_path)
                flags = flags + ["-I" + real_path]
        return flags
    except:
        return None


def FlagsForCompilationDatabase(root, filename):
    try:
        # Last argument of next function is the name of the build folder for
        # out of source projects
        compilation_db_path = FindNearest(root, 'compile_commands.json', BUILD_DIRECTORY)
        compilation_db_dir = p.dirname(compilation_db_path)
        logging.info("Set compilation database directory to " + compilation_db_dir)
        compilation_db =  ycm_core.CompilationDatabase(compilation_db_dir)
        if not compilation_db:
            logging.info("Compilation database file found but unable to load")
            return None
        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            logging.info("No compilation info for " + filename + " in compilation database")
            return None
        return MakeRelativePathsInFlagsAbsolute(
                compilation_info.compiler_flags_,
                compilation_info.compiler_working_dir_)
    except:
        return None


def FlagsForFile(filename):
    root = p.realpath(filename);
    compilation_db_flags = FlagsForCompilationDatabase(root, filename)
    if compilation_db_flags:
        final_flags = compilation_db_flags
    else:
        if IsSourceFile(filename):
            extension = p.splitext(filename)[1]
            if extension in C_SOURCE_EXTENSIONS:
                final_flags = C_BASE_FLAGS
            else:
                final_flags = CPP_BASE_FLAGS

        clang_flags = FlagsForClangComplete(root)
        if clang_flags:
            final_flags = final_flags + clang_flags
        include_flags = FlagsForInclude(root)
        if include_flags:
            final_flags = final_flags + include_flags
    return {
        'flags': final_flags,
        'do_cache': True
    }
