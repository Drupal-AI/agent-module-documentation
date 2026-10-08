#!/usr/bin/env bash
# Introspection SETUP: write view vttnii_known (from the module's test view; its 'tid' contextual
# filter uses the taxonomy_term_name_into_id validator). Uses raw config storage to avoid Views
# handler discovery. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Serialization\Yaml;
  $p = DRUPAL_ROOT . "/modules/contrib/views_taxonomy_term_name_into_id/tests/modules/views_taxonomy_term_name_into_id_test/test_views/views.view.test_argument_taxonomy_name_into_id.yml";
  $d = Yaml::decode(file_get_contents($p));
  $d["id"] = "vttnii_known"; $d["label"] = "VTTNII Known";
  $d["uuid"] = \Drupal::service("uuid")->generate();
  $d["display"]["page_1"]["display_options"]["path"] = "vttnii-known";
  \Drupal::service("config.storage")->write("views.view.vttnii_known", $d);
' >/dev/null 2>&1
echo "setup: view vttnii_known written with taxonomy_term_name_into_id validator on tid"
