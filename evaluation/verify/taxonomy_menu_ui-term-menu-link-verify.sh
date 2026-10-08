#!/usr/bin/env bash
# Execution VERIFY for "add the Human Resources term to the departments menu".
# PASS when a term named 'Human Resources' exists in the tmui_depts vocabulary AND a
# menu_link_content entity exists in the tmui_depts_menu menu whose link URI is
# internal:/taxonomy/term/<that tid> (the URI taxonomy_menu_ui writes), titled 'HR',
# enabled, at weight 5. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $terms = $ts->loadByProperties(["vid" => "tmui_depts", "name" => "Human Resources"]);
  $term = $terms ? reset($terms) : NULL;
  $link = NULL;
  if ($term) {
    $mlc = \Drupal::entityTypeManager()->getStorage("menu_link_content");
    $found = $mlc->loadByProperties([
      "menu_name" => "tmui_depts_menu",
      "link__uri" => "internal:/taxonomy/term/" . $term->id(),
    ]);
    $link = $found ? reset($found) : NULL;
  }
  $title = $link ? $link->getTitle() : NULL;
  $weight = $link ? $link->getWeight() : NULL;
  $enabled = $link ? (bool) $link->isEnabled() : FALSE;
  $ok = $term && $link && $title === "HR" && (int) $weight === 5 && $enabled;
  print ($ok ? "PASS" : "FAIL")
    . " term=" . ($term ? "tid" . $term->id() : "missing")
    . " link=" . ($link ? "present" : "missing")
    . " title=" . var_export($title, TRUE)
    . " weight=" . var_export($weight, TRUE)
    . " enabled=" . var_export($enabled, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
