#!/usr/bin/env bash
# HARD verify: the `content_editor` role must be able to use its own moderation dashboard,
# i.e. it holds the `use moderation dashboard` permission.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html

val=$(drush php:eval '
  $role = \Drupal::entityTypeManager()->getStorage("user_role")->load("content_editor");
  $ok = $role && in_array("use moderation dashboard", $role->getPermissions(), TRUE);
  print "MDPERM:" . ($ok ? "yes" : "no");
' 2>/dev/null | grep -oE 'MDPERM:(yes|no)')

if [ "$val" = "MDPERM:yes" ]; then
  echo "PASS content_editor has 'use moderation dashboard'"
  exit 0
else
  echo "FAIL content_editor is missing 'use moderation dashboard' ($val)"
  exit 1
fi
