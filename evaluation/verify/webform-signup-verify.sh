#!/usr/bin/env bash
# Live-state verification for the "build the eval_signup webform" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the webform eval_signup exists AND its submission confirmation is a redirect
# to the front page (confirmation_type "url" with confirmation_url "<front>" or "/"),
# AND it has at least one handler of plugin type 'email'.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $wf = \Drupal::entityTypeManager()->getStorage("webform")->load("eval_signup");
  if (!$wf) { print "FAIL webform eval_signup does not exist\n"; return; }
  $ctype = (string) $wf->getSetting("confirmation_type");
  $curl  = trim((string) $wf->getSetting("confirmation_url"));
  $redirect_front = ($ctype === "url") && in_array($curl, ["<front>", "/"], TRUE);
  $email_handler = FALSE;
  foreach ($wf->getHandlers() as $handler) {
    if ($handler->getPluginId() === "email") { $email_handler = TRUE; }
  }
  $ok = $redirect_front && $email_handler;
  print ($ok ? "PASS" : "FAIL")
    . " confirmation_type=" . $ctype
    . " confirmation_url=" . $curl
    . " redirect_to_front=" . ($redirect_front?1:0)
    . " email_handler=" . ($email_handler?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
