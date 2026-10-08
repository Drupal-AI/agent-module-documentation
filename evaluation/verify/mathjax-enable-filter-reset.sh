#!/usr/bin/env bash
# Execution RESET: create the text format mathjax_task_format WITHOUT the MathJax filter (and
# explicitly disable filter_mathjax on it) so verify FAILS until the agent enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("mathjax_task_format");
  if (!$f) {
    $f = FilterFormat::create(["format" => "mathjax_task_format", "name" => "MathJax Task Format", "weight" => 60, "filters" => []]);
  }
  $f->setFilterConfig("filter_autop", ["status" => TRUE, "weight" => 0, "settings" => []]);
  $f->setFilterConfig("filter_mathjax", ["status" => FALSE, "weight" => 0, "settings" => []]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mathjax_task_format exists with filter_mathjax disabled"
