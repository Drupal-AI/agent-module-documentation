#!/usr/bin/env bash
# MEDIUM cleanup: restore disable_messages.settings to the baseline captured by setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $backup = \Drupal::state()->get("disable_messages_eval_backup_patterns");
  if (is_array($backup)) {
    \Drupal::configFactory()->getEditable("disable_messages.settings")->setData($backup)->save();
    \Drupal::state()->delete("disable_messages_eval_backup_patterns");
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: disable_messages.settings restored to baseline"
