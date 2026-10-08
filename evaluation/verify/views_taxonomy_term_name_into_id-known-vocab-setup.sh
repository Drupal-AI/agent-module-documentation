#!/usr/bin/env bash
# Introspection SETUP: vocabulary vttnii_vocab + view vttnii_vocabview whose
# taxonomy_term_name_into_id validator is restricted to that vocabulary (bundles). Raw config
# storage. Idempotent. Exit 0.
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
  $d["id"] = "vttnii_vocabview"; $d["label"] = "VTTNII Vocab View";
  $d["uuid"] = \Drupal::service("uuid")->generate();
  $d["display"]["page_1"]["display_options"]["path"] = "vttnii-vocabview";
  $d["display"]["default"]["display_options"]["arguments"]["tid"]["validate_options"]["bundles"] = ["vttnii_vocab" => "vttnii_vocab"];
  \Drupal::service("config.storage")->write("views.view.vttnii_vocabview", $d);
' >/dev/null 2>&1
echo "setup: view vttnii_vocabview validator restricted to vocabulary vttnii_vocab"
