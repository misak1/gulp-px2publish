config       = require '../config'
paths        = config.paths
_expand      = config._expand
_rename_f    = config._rename_f
_path        = config._path
handleErrors = config.handleErrors

M         = require 'm-require'                   # gulp require time
_         = M.require 'underscore'
gulp      = M.require 'gulp'
util      = M.require 'gulp-util'
fs = M.require　'fs'
exec = require('child_process').exec;

global.paths_region = []
# 設定ファイル読み込み
px2publish = require(process.cwd() + '/.px2publish.js')
path = M.require('path')
global.Px2dir = path.dirname(px2publish.config.px_execute_path) + '/'
global.phpbin = px2publish.config.php_bin

gulp.task "px2publish", ->
  target = undefined
  path      = M.require 'path'
  if typeof global.hook_path != "undefined"
    target =  path.normalize(global.hook_path) # // になるのを正規化

  # util.log('distDir'    ,util.colors.green(distDir))
  util.log('px2publish target' ,util.colors.green(target))
  if (target != null && !/^\/px-files*/gm.test(target) && !/^\/caches*/gm.test(target))

    # 配列を結合してパラメーターを作成
    fnCreateParam = (aryPath) ->
      aryUniq = undefined
      aryUniq = aryPath.filter((x, i, self) ->
        self.indexOf(x) == i
      )
      aryParam = []
      aryUniq.forEach ((element) ->
        aryParam.push '&paths_region[]=' + element
        return
      ), this
      aryParam.join ''

    # applock.txtの存在チェック
    path = global.Px2dir + '/px-files/_sys/ram/publish/applock.txt'
    fnCheck = (err) ->
      global.paths_region.push(target)
      if !err
        # applock.txt existss
        util.log(util.colors.red('publish is now locked.'))
      else
        # px2publish
        fnPublish = () ->
          cmd = global.phpbin + ' ' + global.Px2dir + '.px_execute.php "/nothing/to/publish/?PX=publish.run'+fnCreateParam(global.paths_region)+'"'
          util.log('px2publish cmd $ ' ,util.colors.green(cmd))
          exec(cmd, (err, stdout, stderr) ->
            if (err) 
              console.log(err) 
            console.log(stdout)
          )
        # applock.txtが確実に作られていているだろうであろう時間を待つ
        setTimeout(fnPublish, 3000);
    fs.access path, fnCheck

    