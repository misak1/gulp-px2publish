###*
# $ coffee -w -o gulp-px2publish/tasks gulp-px2publish/tasks gulp-px2publish/tasks-coffee/*.coffee
# $ gulp --gulpfile gulpfile-px2publish.coffee
###
gulp = require('gulp')
"use strict"

requireDir = require 'require-dir'
requireDir 'gulp-px2publish/tasks', { recurse: true }
