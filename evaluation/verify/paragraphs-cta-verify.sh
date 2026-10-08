#!/usr/bin/env bash
# Live-state verification for the "eval_cta paragraph type" Paragraphs task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against real site config:
#   pt    — a paragraphs_type 'eval_cta' exists
#   link  — eval_cta carries a field of type 'link'
#   text  — eval_cta carries a plain/formatted text field (string|text|text_long)
# Field machine names are not hard-required (robust to agent naming); only that the
# bundle has one link field and one text field.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $type = \Drupal::entityTypeManager()->getStorage("paragraphs_type")->load("eval_cta");
  $pt = (bool) $type;
  $link = FALSE; $text = FALSE; $found = [];
  if ($pt) {
    $defs = \Drupal::service("entity_field.manager")->getFieldDefinitions("paragraph", "eval_cta");
    foreach ($defs as $name => $def) {
      if ($def instanceof \Drupal\field\Entity\FieldConfig) {
        $t = $def->getType();
        $found[] = $name . ":" . $t;
        if ($t === "link") { $link = TRUE; }
        if (in_array($t, ["string", "text", "text_long", "string_long"], TRUE)) { $text = TRUE; }
      }
    }
  }
  $ok = $pt && $link && $text;
  print ($ok ? "PASS" : "FAIL")
    . " pt=" . ($pt?1:0) . " link=" . ($link?1:0) . " text=" . ($text?1:0)
    . " fields=[" . implode(",", $found) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
