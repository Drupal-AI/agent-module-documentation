#!/usr/bin/env bash
# Introspection SETUP: create two ckeditor_templates config entities on the same text format,
# one enabled and one disabled, so an inspecting agent must read `status` (the deriver only
# exposes status = 1) rather than just list the entities. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("ckeditor_templates");
  $rows = [
    ["ckeditor_templates_live", "Live Callout", TRUE, 0],
    ["ckeditor_templates_draft", "Draft Callout", FALSE, 1],
  ];
  foreach ($rows as [$id, $label, $status, $weight]) {
    if ($existing = $storage->load($id)) { $existing->delete(); }
    $storage->create([
      "id" => $id,
      "label" => $label,
      "status" => $status,
      "description" => "Callout snippet (" . $label . ").",
      "thumb" => [],
      "thumb_alternative" => "",
      "code" => ["value" => "<div class=\"callout-" . $id . "\">Callout</div>", "format" => "full_html"],
      "formats" => ["full_html" => "full_html"],
      "weight" => $weight,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckeditor_templates_live (status=1) and ckeditor_templates_draft (status=0) created"
