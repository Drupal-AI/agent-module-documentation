#!/usr/bin/env bash
# Execution RESET: ensure text format ckq_new does NOT exist, so verify FAILS until the agent
# creates it with the Quote button. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckq_new")) { $e->delete(); }
  if ($f = FilterFormat::load("ckq_new")) { $f->delete(); }
' >/dev/null 2>&1
echo "reset: ckq_new absent"
