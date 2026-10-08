#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  \Drupal::service("config.storage")->delete("views.view.vttnii_task2");
  if ($voc = Vocabulary::load("vttnii_vocab")) { $voc->delete(); }
' >/dev/null 2>&1
echo "cleanup: vttnii_task2 + vocabulary vttnii_vocab removed"
