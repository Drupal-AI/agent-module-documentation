#!/usr/bin/env bash
# Execution RESET: ensure a text format noopener_hard_fmt exists WITHOUT the noopener filter
# enabled (so verify FAILS until the agent enables filter_noopener on it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("noopener_hard_fmt")) {
    $filters = $f->get("filters");
    unset($filters["filter_noopener"]);
    $f->set("filters", $filters)->save();
  }
  else {
    FilterFormat::create(["format"=>"noopener_hard_fmt","name"=>"Noopener Hard Format","filters"=>[]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format noopener_hard_fmt present WITHOUT filter_noopener"
