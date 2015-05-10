/* jshint node: true */
"use strict";

var gulp = require("gulp");
var plumber = require("gulp-plumber");
var purescript = require("gulp-purescript");

var sources = [
  "src/**/*.purs",
  "bower_components/purescript-*/src/**/*.purs"
];

var foreigns = [
  "bower_components/purescript-*/src/**/*.js"
];

gulp.task("make", function() {
  return gulp.src(sources)
    .pipe(plumber())
    .pipe(purescript.pscMake({ ffi: foreigns }));
});

gulp.task("docs", function () {
  return gulp.src(sources)
    .pipe(plumber())
    .pipe(purescript.pscDocs({
      docgen: {
        "Control.Biapplicative": "docs/Control.Biapplicative.md",
        "Control.Biapply": "docs/Control.Biapply.md",
        "Data.Bifunctor": "docs/Data.Bifunctor.md",
        "Data.Bifunctor.Clown": "docs/Data.Bifunctor.Clown.md",
        "Data.Bifunctor.Flip": "docs/Data.Bifunctor.Flip.md",
        "Data.Bifunctor.Join": "docs/Data.Bifunctor.Join.md",
        "Data.Bifunctor.Joker": "docs/Data.Bifunctor.Joker.md",
        "Data.Bifunctor.Product": "docs/Data.Bifunctor.Product.md",
        "Data.Bifunctor.Wrap": "docs/Data.Bifunctor.Wrap.md"
      }
    }));
});

gulp.task("dotpsci", function () {
  return gulp.src(sources)
    .pipe(plumber())
    .pipe(purescript.dotPsci());
});

gulp.task("default", ["make", "docs", "dotpsci"]);
