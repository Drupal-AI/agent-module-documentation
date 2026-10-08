#!/usr/bin/env bash
# Execution VERIFY: PASS when the "Product Glossary" deepl_glossary has an entry whose source term
# "product" maps to the German "Produkt". Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  $found = $s->loadByProperties(["label" => "Product Glossary"]);
  $g = $found ? reset($found) : NULL;
  $match = "no";
  if ($g) {
    foreach ($g->get("entries") as $item) {
      if (strtolower((string) $item->subject) === "product" && (string) $item->definition === "Produkt") { $match = "yes"; }
    }
  }
  $ok = ($match === "yes");
  print ($ok ? "PASS" : "FAIL") . " entity=" . ($g ? "yes" : "no") . " match=" . $match . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
