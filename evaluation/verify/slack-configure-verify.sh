#!/usr/bin/env bash
# Execution VERIFY: PASS when slack.settings has the requested webhook URL, channel #slack-task,
# bot username TaskBot, and message queueing enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("slack.settings");
  $url = (string) $c->get("slack_webhook_url");
  $channel = (string) $c->get("slack_channel");
  $user = (string) $c->get("slack_username");
  $queue = $c->get("slack_queue_messages");
  $queue_on = ($queue === TRUE || $queue === 1 || $queue === "1");
  $url_ok = (strpos($url, "hooks.slack.com/services/") !== FALSE);
  $ok = ($url_ok && $channel === "#slack-task" && $user === "TaskBot" && $queue_on);
  print ($ok ? "PASS" : "FAIL") . " webhook_set=" . ($url_ok ? "1" : "0") . " channel=" . var_export($channel, TRUE) . " username=" . var_export($user, TRUE) . " queue=" . var_export($queue, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
