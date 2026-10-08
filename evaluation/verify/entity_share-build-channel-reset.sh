#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for the "server channel for Article nodes" task. Ensures the server
# submodule is enabled, then deletes any eval_channel so verify FAILs on empty state. The agent
# must then CREATE a `channel` config entity `eval_channel` binding node/article. Only touches
# the eval_channel id; never real channels. Exits 0.
set -uo pipefail
cd /var/www/html
drush en entity_share_server -y >/dev/null 2>&1
drush php:eval '
  if ($c = \Drupal::entityTypeManager()->getStorage("channel")->load("eval_channel")) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_share eval_channel removed"
