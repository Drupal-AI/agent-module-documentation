#!/usr/bin/env bash
# Execution RESET: vocabulary vttnii_vocab + view vttnii_task2 whose tid contextual filter uses
# the taxonomy_term_name_into_id validator with NO vocabulary restriction (bundles empty). Raw
# config storage. verify FAILS until restricted to vttnii_vocab. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\Core\Serialization\Yaml;
  if (!Vocabulary::load("vttnii_vocab")) {
    Vocabulary::create(["vid" => "vttnii_vocab", "name" => "VTTNII Vocab"])->save();
  }
  $p = DRUPAL_ROOT . "/modules/contrib/views_taxonomy_term_name_into_id/tests/modules/views_taxonomy_term_name_into_id_test/test_views/views.view.test_argument_taxonomy_name_into_id.yml";
  $d = Yaml::decode(file_get_contents($p));
  $d["id"] = "vttnii_task2"; $d["label"] = "VTTNII Task 2";
  $d["uuid"] = \Drupal::service("uuid")->generate();
  $d["display"]["page_1"]["display_options"]["path"] = "vttnii-task2";
  $d["display"]["default"]["display_options"]["arguments"]["tid"]["validate_options"]["bundles"] = [];
  \Drupal::service("config.storage")->write("views.view.vttnii_task2", $d);
' >/dev/null 2>&1
echo "reset: view vttnii_task2 uses the validator with NO vocabulary restriction"
