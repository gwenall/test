#!/bin/bash

# Author: Gwenall Pansier
# Purpose: To extract the content of a release note and only thanks contributors of bugs or features
# Comment: it's a silly topic, but it is to show how to manipulate some text

grep -E "<li>#.*(feature|bug)"  release-notes-litecoin.md | \
  sed "s,[^ ]* \(.*\),\1,;s,<[^>]*>,,g;
  s/Don't/not/;
  s/-help-//;
  s/\([A-Za-z]*\) \(.*\)(\([A-Za-z0-9]*\))/Thanks to \3 for \1ing \2/g"