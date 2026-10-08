#!/usr/bin/env bash
# Execution VERIFY: PASS when a deepl_glossary labelled "Legal Terms FR" exists with source_lang
# en and target_lang fr. Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("deepl_glossary");
  $found = $s->loadByProperties(["label" => "Legal Terms FR"]);
  $g = $found ? reset($found) : NULL;
  $src = $g ? $g->get("source_lang")->value : "";
  $tgt = $g ? $g->get("target_lang")->value : "";
  $ok = ($g && $src === "en" && $tgt === "fr");
  print ($ok ? "PASS" : "FAIL") . " entity=" . ($g ? "yes" : "no") . " src=" . $src . " tgt=" . $tgt . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
