'use strict';

gulp = require 'gulp'
$ = require('gulp-load-plugins')()

# svg を圧縮する
gulp.task 'svg-min', ->
  gulp.src ['./app/icons/*.svg']
    .pipe $.svgmin()
    .pipe gulp.dest './app/icons'

# アイコンフォント生成
gulp.task 'fonts', ['svg-min'], ->
  gulp.src ['./app/fonts']
    .pipe $.clean()

  gulp.src ['./app/icons/*.svg']
    .pipe $.plumber $.util.log

    # scss ファイルを生成
    .pipe $.iconfontCss
      fontName: 'icon-font'
      path: './app/styles/templates/_icons.scss' # _icon.scss のテンプレート
      targetPath: '../styles/global/_icons.scss' # _icon.scss を生成
      fontPath: "../fonts/" # _icon.scss で使うフォントのパス

    # icon font を生成
    .pipe $.iconfont
      fontName: 'icon-font'
      appendCodepoints: false

    .pipe gulp.dest './app/fonts'
