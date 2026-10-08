#!/usr/bin/env bash
# Introspection SETUP (gin_lb_plus): create a section_library_template labeled
# 'glb_plus_probe_tmpl' so an agent can discover which entity type backs gin_lb_plus's
# "Library" tab and report the label present. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\section_library\Entity\SectionLibraryTemplate;
  $ids = \Drupal::entityTypeManager()->getStorage("section_library_template")
    ->getQuery()->accessCheck(FALSE)->condition("label", "glb_plus_probe_tmpl")->execute();
  if (!$ids) {
    SectionLibraryTemplate::create(["label" => "glb_plus_probe_tmpl", "type" => "section"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: section_library_template glb_plus_probe_tmpl present"
