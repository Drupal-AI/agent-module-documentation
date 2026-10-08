#!/usr/bin/env bash
# MEDIUM setup: load a KNOWN set of suppression patterns into disable_messages.settings so
# the agent must inspect live config to say which messages this site currently hides.
# Backs up the whole config object to state first; cleanup restores it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("disable_messages.settings");
  if (!\Drupal::state()->get("disable_messages_eval_backup_patterns")) {
    \Drupal::state()->set("disable_messages_eval_backup_patterns", $cfg->getRawData());
  }
  $lines = ["The item has been deleted.", "Article .* has been created."];
  $regex = [];
  foreach ($lines as $l) { $regex[] = "/^" . trim($l) . "\$/i"; }
  $cfg->set("disable_messages_enable", "1")
      ->set("disable_messages_ignore_case", "1")
      ->set("disable_messages_ignore_patterns", implode("\n", $lines))
      ->set("disable_messages_ignore_regex", $regex)
      ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: disable_messages suppresses \"The item has been deleted.\" and \"Article .* has been created.\""
