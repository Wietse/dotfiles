# import snake
#
#
# INDENT = 4
#
#
# @snake.visual_key_map('<leader>x')
# def try_except(sel):
#     indent = 0
#     while sel[indent] == ' ':
#         indent += 1
#     new_lines = ['{}try:'.format(indent)]
#     new_lines.extend('{}{}'.format(INDENT, line) for line in sel.split('\n'))
#     new_lines.append('{}except Exception as err:'.format(indent))
#     new_lines.append('{}{}import pudb; pudb.set_trace()  # BREAKPOINT'.format(indent, INDENT))
#     new_lines.append('{}{}pass'.format(indent, INDENT))
#     return '\n'.join(new_lines)
