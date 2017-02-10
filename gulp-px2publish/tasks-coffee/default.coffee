config       = require '../config'
paths        = config.paths
# ext          = config.ext
# options       = config.options
border        = config.border
gulp        = require 'gulp'

default_tasks = []

# default_tasks.push('stylus')

# default_tasks.push('pug', 'sprite', 'watch')
default_tasks.push('watch')

console.log("- task -" + border)
console.log(default_tasks)
console.log(border)

gulp.task 'default', default_tasks

# gulp.task "sprite"
# gulp.task "imagemin"