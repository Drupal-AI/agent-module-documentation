#!/usr/bin/env bash
# HARD reset: ensure the `content_editor` role does NOT yet hold the dashboard permissions,
# so the task "let content editors use the moderation dashboard" starts from a clean state.
# Strips `use moderation dashboard` and `view any moderation dashboard` from content_editor.
# Safe to run repeatedly.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush role:perm:remove content_editor 'use moderation dashboard' >/dev/null 2>&1 || true
drush role:perm:remove content_editor 'view any moderation dashboard' >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: content_editor stripped of moderation dashboard permissions"
