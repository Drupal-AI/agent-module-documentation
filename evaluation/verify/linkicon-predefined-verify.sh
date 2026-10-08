#!/usr/bin/env bash
# Execution VERIFY: PASS when field_li_pred uses Link Icon Predefined titles (title === 5) and its
# title_predefined allowed values contain a 'facebook' key. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_li_pred");
  $title = $fc ? $fc->getSetting("title") : NULL;
  $pre = $fc ? (string) $fc->getSetting("title_predefined") : "";
  $ok = ((int) $title === 5 && stripos($pre, "facebook") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " title=" . var_export($title, TRUE) . " has_facebook=" . (stripos($pre, "facebook") !== FALSE ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
