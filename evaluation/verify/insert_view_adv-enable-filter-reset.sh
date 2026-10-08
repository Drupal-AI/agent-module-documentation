#!/usr/bin/env bash
# Execution RESET: (re)create a text format "iva_eval_hard" WITHOUT the Advanced Insert View
# filter so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("filter_format");
  if ($f = $s->load("iva_eval_hard")) { $f->delete(); }
  $s->create([
    "format" => "iva_eval_hard",
    "name" => "IVA Eval Hard",
    "weight" => 21,
    "filters" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: text format iva_eval_hard exists without insert_view_adv"
