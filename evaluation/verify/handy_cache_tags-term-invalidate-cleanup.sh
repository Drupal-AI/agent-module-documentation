#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\taxonomy\Entity\Vocabulary; $s=\Drupal::entityTypeManager()->getStorage("taxonomy_term"); $ex=$s->loadByProperties(["vid"=>"hct_vocab"]); if($ex){$s->delete($ex);} if($v=Vocabulary::load("hct_vocab")){$v->delete();}' >/dev/null 2>&1
drush sqlq "DELETE FROM cachetags WHERE tag='handy_cache_tags:taxonomy_term:hct_vocab'" >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: hct_vocab and its cachetags row removed"
