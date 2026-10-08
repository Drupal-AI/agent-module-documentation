#!/usr/bin/env bash
# Introspection SETUP: create a quiz entity titled quiz_probe with a distinctive pass rate
# (63), so the agent must inspect the live quiz entity to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\Quiz;
  $l = \Drupal::entityTypeManager()->getStorage("quiz")->loadByProperties(["title"=>"quiz_probe"]);
  if (!$l) {
    Quiz::create([
      "type"=>"quiz","title"=>"quiz_probe","randomization"=>0,"keep_results"=>2,
      "build_on_last"=>"all","result_type"=>"quiz_result","pass_rate"=>63,"takes"=>0,
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: quiz entity quiz_probe has pass_rate 63"
