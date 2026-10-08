#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one saved Message entity of template mn_send exists.
# The email notifier's default 'save on success' saves the message after a successful send,
# so a persisted mn_send message is evidence the notification was sent. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("message")->getQuery()
    ->accessCheck(FALSE)->condition("template", "mn_send")->execute();
  $n = count($ids);
  print (($n > 0) ? "PASS" : "FAIL") . " mn_send_messages=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
