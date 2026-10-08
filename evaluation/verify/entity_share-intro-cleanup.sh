#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection CLEANUP: remove the known eval_intro_* Entity Share config entities, restoring
# baseline. Idempotent: no-op if already gone. Only touches eval_intro_* entities. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($c = \Drupal::entityTypeManager()->getStorage("channel")->load("eval_intro_channel")) { $c->delete(); }
  if ($r = \Drupal::entityTypeManager()->getStorage("remote")->load("eval_intro_remote")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eval_intro_channel + eval_intro_remote removed"
