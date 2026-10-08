#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\taxonomy\Entity\Vocabulary; $s=\Drupal::entityTypeManager()->getStorage("taxonomy_term"); $ex=$s->loadByProperties(["vid"=>"tmt_half"]); if($ex){$s->delete($ex);} if($v=Vocabulary::load("tmt_half")){$v->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vocabulary tmt_half removed"
