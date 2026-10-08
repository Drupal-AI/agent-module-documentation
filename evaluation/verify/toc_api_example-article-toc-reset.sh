#!/usr/bin/env bash
# Execution RESET: ensure toc_api_example is enabled, the default toc_type is at its shipped
# 'responsive' template, and no leftover eval Article exists. So verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush en toc_api_example -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("toc_api.toc_type.default")->set("options.template", "responsive")->save();
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "TOC Api Example Article"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: toc_api_example enabled; no 'TOC Api Example Article' node"
