#!/usr/bin/env bash
# Introspection SETUP (gin_lb_plus): create a section_library_template entity labeled
# 'glb_plus_known_tmpl'. gin_lb_plus lists such templates in its "Library" tab on the
# layout_builder.choose_section screen (SectionLibraryTemplate::loadMultiple()), so an
# inspecting agent must read it back from the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\section_library\Entity\SectionLibraryTemplate;
  $ids = \Drupal::entityTypeManager()->getStorage("section_library_template")
    ->getQuery()->accessCheck(FALSE)->condition("label", "glb_plus_known_tmpl")->execute();
  if (!$ids) {
    SectionLibraryTemplate::create(["label" => "glb_plus_known_tmpl", "type" => "section"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: section_library_template glb_plus_known_tmpl present"
