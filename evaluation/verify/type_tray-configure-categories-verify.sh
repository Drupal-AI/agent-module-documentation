#!/usr/bin/env bash
# Execution VERIFY: PASS when type_tray.settings defines the categories tt_news => News and
# tt_promo => Promotions, and the tt_demo content type is in tt_promo with weight 3.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $cats = \Drupal::config("type_tray.settings")->get("categories") ?? [];
  $t = NodeType::load("tt_demo");
  $settings = $t ? $t->getThirdPartySettings("type_tray") : [];
  $ok = (($cats["tt_news"] ?? NULL) === "News")
    && (($cats["tt_promo"] ?? NULL) === "Promotions")
    && (($settings["type_category"] ?? NULL) === "tt_promo")
    && ((int) ($settings["type_weight"] ?? -1) === 3);
  print ($ok ? "PASS" : "FAIL")
    . " categories=" . json_encode($cats)
    . " tt_demo=" . json_encode($settings) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
