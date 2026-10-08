#!/usr/bin/env bash
# Introspection SETUP: create two throwaway text formats - mathjax_eval_on (with the MathJax
# filter filter_mathjax ENABLED and weighted last) and mathjax_eval_off (without it) - so the
# agent must inspect live filter configuration to say which format renders LaTeX.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  foreach (["mathjax_eval_on" => "MathJax Eval On", "mathjax_eval_off" => "MathJax Eval Off"] as $id => $label) {
    $f = FilterFormat::load($id);
    if (!$f) {
      $f = FilterFormat::create(["format" => $id, "name" => $label, "weight" => 50, "filters" => []]);
    }
    $f->setFilterConfig("filter_autop", ["status" => TRUE, "weight" => 0, "settings" => []]);
    if ($id === "mathjax_eval_on") {
      $f->setFilterConfig("filter_mathjax", ["status" => TRUE, "weight" => 100, "settings" => []]);
    }
    else {
      $f->setFilterConfig("filter_mathjax", ["status" => FALSE, "weight" => 100, "settings" => []]);
    }
    $f->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mathjax_eval_on has filter_mathjax enabled, mathjax_eval_off does not"
