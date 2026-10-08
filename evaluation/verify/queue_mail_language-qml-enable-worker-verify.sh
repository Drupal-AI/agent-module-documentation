#!/usr/bin/env bash
# Execution VERIFY: PASS when the queue_mail queue worker class is the language-aware worker
# from queue_mail_language (i.e. the submodule is enabled and its alter took effect).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $def = \Drupal::service("plugin.manager.queue_worker")->getDefinition("queue_mail");
  $class = $def["class"] ?? "";
  $ok = ($class === "Drupal\\queue_mail_language\\Plugin\\QueueWorker\\LanguageAwareSendMailQueueWorker");
  print ($ok ? "PASS" : "FAIL") . " class=" . $class . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
