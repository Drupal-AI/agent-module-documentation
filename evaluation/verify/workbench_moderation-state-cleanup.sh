#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\workbench_moderation\Entity\ModerationState; if ($s = ModerationState::load("wbm_eval_legal")) { $s->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: moderation_state wbm_eval_legal removed"
