/* global exports */
"use strict";

// module Util.DOM
exports.querySelectorImpl = function(r, f, s) {
 return function() {
  var result = document.querySelector(s);
  return result ? f(result) : r;
 };
}

exports.setText = function(text) {
 return function(node) {
  return function() {
   node.textContent = text;
   return node;
  };
 };
}

exports.setSrc = function(url) {
 return function(node) {
  return function() {
   node.src = url;
   return node;
  };
 };
}

exports.blob2url = function(blob) {
  return function() {
    var urlCreator = window.URL || window.webkitURL;
    var imageUrl = urlCreator.createObjectURL( blob );
    return imageUrl;
 };
}
