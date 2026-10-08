#!/usr/bin/env bash
# Introspection SETUP: vocabulary tmt_known with exactly 7 terms. Agent reports the term count.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if(!Vocabulary::load("tmt_known")){Vocabulary::create(["vid"=>"tmt_known","name"=>"TMT Known"])->save();}
  $s=\Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $ex=$s->loadByProperties(["vid"=>"tmt_known"]); if($ex){$s->delete($ex);}
  for($i=1;$i<=7;$i++){Term::create(["vid"=>"tmt_known","name"=>"tmt_known_$i"])->save();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary tmt_known has 7 terms"
