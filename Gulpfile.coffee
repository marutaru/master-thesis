gulp = require 'gulp'
exec = require 'gulp-exec'

repOptions =
  err:true
  stderr:true
  stdout:true

gulp.task 'compile', ->
  gulp.src "main.tex"
  .pipe exec 'platex  -kanji=utf8 main'
  .pipe exec.reporter(repOptions)
  .pipe exec 'pbibtex -kanji=utf8 main'
  .pipe exec.reporter(repOptions)
  .pipe exec 'platex  -kanji=utf8 main'
  .pipe exec.reporter(repOptions)
  .pipe exec 'platex  -kanji=utf8 main'
  .pipe exec.reporter(repOptions)
  .pipe exec 'dvipdfmx -p a4 main'
  .pipe exec.reporter(repOptions)

gulp.task 'clean', ->
  list = '*~ *.log *.dvi *.blg *.aux *.out *.bbl *.lot *.toc *.lof *.pdf'
  gulp.src 'main.pdf'
  .pipe exec "rm -f #{list}"
  .pipe exec.reporter(repOptions)

gulp.task 'default', ['compile'], ->
  gulp.src 'main.tex'
  .pipe exec.reporter(repOptions)
  .pipe exec 'evince main.pdf'
  .pipe exec.reporter(repOptions)
  gulp.watch './**/*.tex', ['compile']
