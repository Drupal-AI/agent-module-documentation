#!/usr/bin/env bash
# Execution VERIFY: PASS when entity browser b4m_large uses the bootstrap4_modal display AND
# its modal_size is modal-lg. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\entity_browser\Entity\EntityBrowser;
  $eb = EntityBrowser::load("b4m_large");
  $disp = $eb ? $eb->get("display") : "none";
  $size = $eb ? ($eb->get("display_configuration")["modal_size"] ?? "") : "";
  $ok = ($eb && $disp === "bootstrap4_modal" && $size === "modal-lg");
  print ($ok ? "PASS" : "FAIL") . " display=" . $disp . " modal_size=" . var_export($size, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
