#!/usr/bin/env bash
# Execution RESET: write view vttnii_task with a 'Has taxonomy term ID' (tid) contextual filter
# but WITHOUT the taxonomy_term_name_into_id validator (validate.type='none'). Raw config storage.
# verify FAILS until the validator is switched to taxonomy_term_name_into_id. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Serialization\Yaml;
  $p = DRUPAL_ROOT . "/modules/contrib/views_taxonomy_term_name_into_id/tests/modules/views_taxonomy_term_name_into_id_test/test_views/views.view.test_argument_taxonomy_name_into_id.yml";
  $d = Yaml::decode(file_get_contents($p));
  $d["id"] = "vttnii_task"; $d["label"] = "VTTNII Task";
  $d["uuid"] = \Drupal::service("uuid")->generate();
  $d["display"]["page_1"]["display_options"]["path"] = "vttnii-task";
  $d["display"]["default"]["display_options"]["arguments"]["tid"]["specify_validation"] = FALSE;
  $d["display"]["default"]["display_options"]["arguments"]["tid"]["validate"]["type"] = "none";
  \Drupal::service("config.storage")->write("views.view.vttnii_task", $d);
' >/dev/null 2>&1
echo "reset: view vttnii_task present, tid contextual filter has NO name-into-id validator"
