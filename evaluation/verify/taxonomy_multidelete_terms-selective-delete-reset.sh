#!/usr/bin/env bash
# Execution RESET: vocabulary tmt_half with 3 keep terms + 3 delete terms.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if(!Vocabulary::load("tmt_half")){Vocabulary::create(["vid"=>"tmt_half","name"=>"TMT Half"])->save();}
  $s=\Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $ex=$s->loadByProperties(["vid"=>"tmt_half"]); if($ex){$s->delete($ex);}
  for($i=1;$i<=3;$i++){Term::create(["vid"=>"tmt_half","name"=>"tmt_keep_$i"])->save();}
  for($i=1;$i<=3;$i++){Term::create(["vid"=>"tmt_half","name"=>"tmt_del_$i"])->save();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tmt_half has 3 tmt_keep_* and 3 tmt_del_* terms"
