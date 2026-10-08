#!/usr/bin/env bash
# next_jwt execution VERIFY: PASS when next.settings.preview_url_generator === 'jwt' AND the active
# generator resolves to id 'jwt'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $gen = \Drupal::config("next.settings")->get("preview_url_generator");
  $active = \Drupal::service("next.settings.manager")->getPreviewUrlGenerator();
  $id = $active ? $active->getId() : NULL;
  $ok = ($gen === "jwt") && ($id === "jwt");
  print ($ok ? "PASS" : "FAIL") . " setting=" . var_export($gen, TRUE) . " active_id=" . var_export($id, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
