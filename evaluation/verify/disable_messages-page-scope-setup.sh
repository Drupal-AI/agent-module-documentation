#!/usr/bin/env bash
# MEDIUM setup: scope message filtering to specific pages only (mode 2 = "apply only on the
# listed pages") with a known path, so the agent must read live config to report the scope.
# Backs up the whole config object to state first; cleanup restores it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("disable_messages.settings");
  if (!\Drupal::state()->get("disable_messages_eval_backup_page")) {
    \Drupal::state()->set("disable_messages_eval_backup_page", $cfg->getRawData());
  }
  $cfg->set("disable_messages_enable", "1")
      ->set("disable_messages_filter_by_page", 2)
      ->set("disable_messages_page_filter_paths", "/checkout\n/checkout/*")
      ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: disable_messages filtering scoped to only /checkout and /checkout/* (mode 2)"
