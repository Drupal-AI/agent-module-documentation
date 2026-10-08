#!/usr/bin/env bash
# MEDIUM setup: create a KNOWN role that holds a moderation_dashboard permission, so the
# agent must inspect live role config to answer which role can view other users' dashboards.
# Creates role `md_reviewer` and grants it `view any moderation dashboard`
# (plus `use moderation dashboard`).
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush role:create md_reviewer 'MD Reviewer' >/dev/null 2>&1 || true
drush role:perm:add md_reviewer 'use moderation dashboard' >/dev/null 2>&1 || true
drush role:perm:add md_reviewer 'view any moderation dashboard' >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "setup: role md_reviewer created with 'use moderation dashboard' + 'view any moderation dashboard'"
