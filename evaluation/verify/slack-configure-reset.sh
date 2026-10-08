#!/usr/bin/env bash
# Execution RESET: force slack.settings back to shipped defaults (empty webhook/channel/
# username, queue off) so verify FAILS until the agent configures it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("slack.settings")
    ->set("slack_webhook_url", "")
    ->set("slack_channel", "")
    ->set("slack_username", "")
    ->set("slack_icon_type", "none")
    ->set("slack_icon_emoji", "")
    ->set("slack_icon_url", "")
    ->set("slack_queue_messages", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: slack.settings at defaults"
