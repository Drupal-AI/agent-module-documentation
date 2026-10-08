#!/usr/bin/env bash
# Execution RESET: (re)create the Linkit profile lml_task_profile with ONLY an entity:node
# matcher, so linkit_media_library's media button cannot appear and verify FAILS until the agent
# adds an entity:media matcher. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\linkit\Entity\Profile;
  $p = Profile::load("lml_task_profile");
  if (!$p) {
    $p = Profile::create([
      "id" => "lml_task_profile",
      "label" => "LML Task Profile",
      "description" => "Linkit profile for the linkit_media_library execution eval.",
    ]);
    $p->save();
  }
  $existing = [];
  foreach ($p->getMatchers() as $m) { $existing[] = $m; }
  foreach ($existing as $m) { $p->removeMatcher($m); }
  $matcher = \Drupal::service("plugin.manager.linkit.matcher")->createInstance("entity:node");
  $p->addMatcher($matcher->getConfiguration());
  $p->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: lml_task_profile has only an entity:node matcher"
