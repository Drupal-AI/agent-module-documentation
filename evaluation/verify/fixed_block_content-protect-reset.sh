#!/usr/bin/env bash
# Execution RESET: ensure fixed_block_content fbc_ptask exists with protected = FALSE, so verify
# FAILS until the agent marks it protected. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("fixed_block_content");
  $e = $s->load("fbc_ptask") ?: $s->create(["id"=>"fbc_ptask","title"=>"Protect Task Block","block_content_bundle"=>"basic","auto_export"=>0]);
  $e->setProtected(FALSE);
  $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fbc_ptask present with protected=FALSE"
