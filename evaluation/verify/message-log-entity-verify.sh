#!/usr/bin/env bash
# Live-state verification for the "create the eval_comment template AND log a message" task.
# PASS if (a) a message_template config entity `eval_comment` exists and is enabled with a
# text partial containing [message:author:name], AND (b) at least one `message` content
# entity of bundle eval_comment exists in the database.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("message_template")->load("eval_comment");
  $tpl = (bool) $t;
  $enabled = $tpl && $t->status();
  $tok = FALSE;
  if ($tpl) {
    foreach ($t->getRawText() as $partial) {
      $v = is_array($partial) ? ($partial["value"] ?? "") : (string) $partial;
      if (stripos($v, "[message:author:name]") !== FALSE) { $tok = TRUE; }
    }
  }
  $msgs = \Drupal::entityTypeManager()->getStorage("message")->loadByProperties(["template" => "eval_comment"]);
  $has_msg = count($msgs) > 0;
  print (($tpl && $enabled && $tok && $has_msg) ? "PASS" : "FAIL")
    . " tpl=" . ($tpl?1:0) . " enabled=" . ($enabled?1:0) . " token=" . ($tok?1:0)
    . " messages=" . count($msgs) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
