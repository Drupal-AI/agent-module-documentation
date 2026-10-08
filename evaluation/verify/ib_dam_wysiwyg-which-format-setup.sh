#!/usr/bin/env bash
# Introspection SETUP: format ibw_probe_fmt with the ib_dam_wysiwyg filter enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("ibw_probe_fmt") ?: FilterFormat::create(["format" => "ibw_probe_fmt", "name" => "IBW Probe Fmt"]);
  $f->setFilterConfig("ib_dam_wysiwyg", ["id" => "ib_dam_wysiwyg", "status" => TRUE, "weight" => 0, "settings" => []]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ibw_probe_fmt ib_dam_wysiwyg status=TRUE"
