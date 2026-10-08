#!/usr/bin/env bash
# Execution VERIFY: PASS when node.page has BOTH a FieldConfig for field_ft_widget AND a
# component for it on the node.page.default entity_form_display. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "page", "field_ft_widget");
  $pfd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.page.default");
  $comp = $pfd ? $pfd->getComponent("field_ft_widget") : NULL;
  $ok = ($fc && !empty($comp));
  print ($ok ? "PASS" : "FAIL") . " field=" . ($fc ? "yes" : "no") . " form_component=" . (!empty($comp) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
