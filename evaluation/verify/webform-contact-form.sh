#!/usr/bin/env bash
# Live-state verification for the "build the eval_contact contact webform" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the webform eval_contact exists AND has three required elements —
# a name (textfield), an email (email type) and a message (textarea), all #required —
# AND has at least one handler of plugin type 'email'.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $wf = \Drupal::entityTypeManager()->getStorage("webform")->load("eval_contact");
  if (!$wf) { print "FAIL webform eval_contact does not exist\n"; return; }
  $elements = $wf->getElementsDecodedAndFlattened();
  $name = $email = $message = FALSE;
  foreach ($elements as $el) {
    $type = $el["#type"] ?? "";
    $req  = !empty($el["#required"]);
    if ($type === "textfield" && $req) { $name = TRUE; }
    if ($type === "email" && $req) { $email = TRUE; }
    if ($type === "textarea" && $req) { $message = TRUE; }
  }
  $email_handler = FALSE;
  foreach ($wf->getHandlers() as $handler) {
    if ($handler->getPluginId() === "email") { $email_handler = TRUE; }
  }
  $ok = $name && $email && $message && $email_handler;
  print ($ok ? "PASS" : "FAIL")
    . " name_textfield_required=" . ($name?1:0)
    . " email_required=" . ($email?1:0)
    . " message_textarea_required=" . ($message?1:0)
    . " email_handler=" . ($email_handler?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
