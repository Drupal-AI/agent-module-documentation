#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for the "client remote pointing at a server URL" task. Ensures the
# client submodule is enabled, then deletes any eval_remote so verify FAILs on empty state. The
# agent must then CREATE a `remote` config entity eval_remote with url
# https://source.eval.example.com. Only touches the eval_remote id; never real remotes. Exits 0.
set -uo pipefail
cd /var/www/html
drush en entity_share_client -y >/dev/null 2>&1
drush php:eval '
  if ($r = \Drupal::entityTypeManager()->getStorage("remote")->load("eval_remote")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_share eval_remote removed"
