#!/usr/bin/env bash
# Introspection SETUP: create a Linkit profile lml_eval_profile carrying an entity:media matcher
# restricted to the 'document' media type with substitution_type 'media', which is what
# linkit_media_library reads to build its media library dialog. The agent must inspect the live
# profile config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\linkit\Entity\Profile;
  $p = Profile::load("lml_eval_profile");
  if (!$p) {
    $p = Profile::create([
      "id" => "lml_eval_profile",
      "label" => "LML Eval Profile",
      "description" => "Linkit profile used by the linkit_media_library eval.",
    ]);
    $p->save();
  }
  $existing = [];
  foreach ($p->getMatchers() as $m) { $existing[] = $m; }
  foreach ($existing as $m) { $p->removeMatcher($m); }
  $matcher = \Drupal::service("plugin.manager.linkit.matcher")->createInstance("entity:media");
  $config = $matcher->getConfiguration();
  $config["settings"]["bundles"] = ["document" => "document"];
  $config["settings"]["substitution_type"] = "media";
  $p->addMatcher($config);
  $p->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: linkit profile lml_eval_profile has an entity:media matcher limited to bundle 'document'"
