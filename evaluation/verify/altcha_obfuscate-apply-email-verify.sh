#!/usr/bin/env bash
# hard VERIFY (altcha_obfuscate): PASS when field_aobf_mail uses altcha_obfuscated_email AND its
# reveal_text_override setting === 'Show address'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_aobf_mail") : NULL;
  $type = $c["type"] ?? "none";
  $rev = $c["settings"]["reveal_text_override"] ?? NULL;
  $ok = ($type === "altcha_obfuscated_email" && $rev === "Show address");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " reveal_text_override=" . var_export($rev, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
