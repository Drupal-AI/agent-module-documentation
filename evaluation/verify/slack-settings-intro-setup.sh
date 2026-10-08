#!/usr/bin/env bash
# Introspection SETUP: set slack.settings to a known default channel + bot username (with a
# placeholder webhook that is never actually called) so an agent can read the live config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("slack.settings")
    ->set("slack_webhook_url", "https://hooks.slack.com/services/T00INTRO/B00INTRO/introplaceholder")
    ->set("slack_channel", "#ops-intro")
    ->set("slack_username", "IntroBot")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: slack.settings channel=#ops-intro username=IntroBot"
