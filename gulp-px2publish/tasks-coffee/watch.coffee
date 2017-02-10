config    = require '../config'
paths     = config.paths

M         = require 'm-require'                    # gulp require time
gulp      = M.require 'gulp'
util      = M.require 'gulp-util'
watch     = M.require 'gulp-watch'
path      = M.require 'path'

###
# 変更を検知したファイルパス（相対パス）
###
watch_hook = (epath)->
  util.log(config.border);
  util.log('PATH_',util.colors.yellow(epath))
  relativePath = path.relative(global.baseDir, path.dirname(epath))
  global.hook_path = path.sep + relativePath + path.sep + path.basename(epath)
  util.log('global.hook_path -> ',util.colors.yellow(global.hook_path))

gulp.task 'watch', ->
  watch ["!" + paths.SRC + '/caches/**/*', "!" + paths.SRC + '/px-files/**/*', "!" + paths.SRC + '**/guieditor.ignore/data.json', paths.SRC + '/**/*']  ,   (e) -> watch_hook(e.path); gulp.start(["px2publish"])
  