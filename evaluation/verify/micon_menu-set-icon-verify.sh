#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'Micon Menu Task' menu link has link.options.attributes.data-icon
# === fa-star. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $items = \Drupal::entityTypeManager()->getStorage("menu_link_content")->loadByProperties(["title"=>"Micon Menu Task"]);
  $m = $items ? reset($items) : NULL;
  $icon = NULL;
  if ($m) { $opts = $m->get("link")->first()->get("options")->getValue(); $icon = $opts["attributes"]["data-icon"] ?? NULL; }
  print (($icon === "fa-star") ? "PASS" : "FAIL") . " data-icon=" . var_export($icon, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
