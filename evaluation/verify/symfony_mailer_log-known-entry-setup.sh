#!/usr/bin/env bash
# Introspection SETUP: create a known symfony_mailer_log entry so an agent can inspect the mail
# log and read back its subject. Idempotent (skips if the marker subject already exists). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("symfony_mailer_log");
  $existing = $storage->getQuery()->accessCheck(FALSE)
    ->condition("subject", "SMLOG Known Subject 7F3")->execute();
  if (empty($existing)) {
    $storage->create([
      "type" => "test",
      "sub_type" => "known",
      "subject" => "SMLOG Known Subject 7F3",
      "to" => ["known@example.com"],
      "text_body" => "eval fixture",
      "created" => \Drupal::time()->getRequestTime(),
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: symfony_mailer_log entry with subject 'SMLOG Known Subject 7F3'"
