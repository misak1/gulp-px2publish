path     = require 'path'
minimist = require 'minimist' # gulpの引数処理
basename = path.basename(__filename, '.coffee')
title = basename.split('-')[1...].join('-')
if title?
  #titleが取れない場合はフォルダ名をタイトルとする
  title = path.resolve('.').split(path.sep).pop()

DEST =    "./publish"
SRC =     "./dist"

# ファイルタイプごとに(監視|無視)するファイルを設定
paths =
    DEST:[
      "#{DEST}"
    ]
    SRC:     "#{SRC}"

M      = require 'm-require'      # gulp require time
_      = M.require 'underscore'
rename = M.require 'gulp-rename'
notify = M.require 'gulp-notify'
repeat = M.require 'repeat-string'
util   = M.require 'gulp-util'
border = repeat('-', 40)
global.baseDir = path.join(__dirname,'../', paths.SRC)
console.log('global.hook_path', global.hook_path) 

console.log("- DEST -" + border)
console.log(paths.DEST)
console.log("- SRC -" + border)
console.log(paths.SRC)

module.exports =
  title: title
  paths: paths
  border: border

  # Common function
  handleErrors: (err) ->
    notify.onError(
      title: 'Gulp'
      subtitle: 'Failure!'
      message: 'Error: <%= error.message %>'
      sound: 'Glass') err
    @emit 'end'
  _expand   : (ext)     -> rename (path) -> _.tap path, (p) -> p.extname = ".#{ext}"; #                       util.log(p)
  _dirname  : (dirname)-> rename (path) -> _.tap path, (p) -> p.dirname = "#{dirname}"; #                     util.log(p)
  _rename   : (basename)-> rename (path) -> _.tap path, (p) -> p.basename = "#{basename}"; #                  util.log(p)
  _rename_f : (basename)-> rename (path) -> _.tap path, (p) -> p.dirname = "."; p.basename = "#{basename}"; # util.log(p)
  _print    : (filename)-> console.log(filename)
  _path     : ->
    require('event-stream').map (file, done) ->
      util.log('_path' ,util.colors.yellow(file.path))
      done()
      return
