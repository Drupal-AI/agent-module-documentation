#!/usr/bin/env bash
# Introspection SETUP: create two Tags terms; give "TMN Beta Two" an explicit machine_name
# tmn_special_marker (the module sanitises/keeps it), while "TMN Alpha One" gets an
# auto-generated one. The agent must inspect machine_name values to say which term carries
# tmn_special_marker. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  foreach (["TMN Alpha One","TMN Beta Two"] as $name) {
    foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tags")->condition("name",$name)->accessCheck(FALSE)->execute() as $tid) { Term::load($tid)->delete(); }
  }
  Term::create(["vid"=>"tags","name"=>"TMN Alpha One"])->save();
  $b=Term::create(["vid"=>"tags","name"=>"TMN Beta Two"]);
  $b->set("machine_name","tmn_special_marker");
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: 'TMN Beta Two' has machine_name tmn_special_marker; 'TMN Alpha One' auto"
