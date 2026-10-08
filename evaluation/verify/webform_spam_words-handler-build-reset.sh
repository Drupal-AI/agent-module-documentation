#!/usr/bin/env bash
# Execution RESET: ensure webform wsw_test exists with a single 'message' textarea element
# and NO webform_spam_words handler attached (verify FAILS until the agent adds one).
# Never touches the shipped 'contact' webform. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $elements = "message:\n  \x27#type\x27: textarea\n  \x27#title\x27: Message\n";
  $w = Webform::load("wsw_test");
  if (!$w) { $w = Webform::create(["id" => "wsw_test", "title" => "WSW Test"]); }
  $w->set("elements", $elements);
  $w->set("handlers", []);
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform wsw_test present with message element, no handlers"
