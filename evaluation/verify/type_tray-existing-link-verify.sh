#!/usr/bin/env bash
# Execution VERIFY: PASS when tt_demo carries the requested Type Tray link text and icon path.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("tt_demo");
  $s = $t ? $t->getThirdPartySettings("type_tray") : [];
  $ok = (($s["existing_nodes_link_text"] ?? NULL) === "View existing TT Demo content")
    && (($s["type_icon"] ?? NULL) === "/modules/contrib/type_tray/assets/icons/file-text.svg");
  print ($ok ? "PASS" : "FAIL") . " settings=" . json_encode($s) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
