#!/usr/bin/env bash
# Introspection setup: install two KNOWN section_library_template content entities on the
# live site so the medium cases can be asked about the current library and must inspect the
# running site (drush) to answer. Idempotent — deletes any prior eval templates first, then
# recreates the exact known content. Known facts the medium cases probe:
#   - "Eval Landing Page"  : type=template, 2 layout_section sections,
#                            first section layout id = layout_onecol
#   - "Eval Promo Section" : type=section, 1 layout_section section (layout_onecol)
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\layout_builder\Section;
  $storage = \Drupal::entityTypeManager()->getStorage("section_library_template");
  foreach (["Eval Landing Page", "Eval Promo Section"] as $lbl) {
    $ids = $storage->getQuery()->accessCheck(FALSE)->condition("label", $lbl)->execute();
    if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  }
  $page = $storage->create([
    "label" => "Eval Landing Page",
    "type" => "template",
    "entity_type" => "node",
    "entity_id" => 1,
    "layout_section" => [new Section("layout_onecol"), new Section("layout_twocol_section")],
  ]);
  $page->save();
  $sec = $storage->create([
    "label" => "Eval Promo Section",
    "type" => "section",
    "entity_type" => "node",
    "entity_id" => 1,
    "layout_section" => [new Section("layout_onecol")],
  ]);
  $sec->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: 'Eval Landing Page' (template, 2 sections) + 'Eval Promo Section' (section, 1) installed"
