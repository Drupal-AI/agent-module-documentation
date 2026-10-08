#!/usr/bin/env bash
# Introspection SETUP: create a domain dp_intro and a domain-specific path alias
# (/dp-known-alias -> /node/9001) tagged with domain_id dp_intro, so the agent can read back
# the alias configured for that domain. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\domain\Entity\Domain;
  use Drupal\path_alias\Entity\PathAlias;
  if (!Domain::load("dp_intro")) {
    Domain::create(["id"=>"dp_intro","hostname"=>"dp-intro.example.com","name"=>"DP Intro","scheme"=>"https","status"=>1,"weight"=>50])->save();
  }
  $existing = \Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["domain_id"=>"dp_intro","alias"=>"/dp-known-alias"]);
  if (!$existing) {
    $pa = PathAlias::create(["path"=>"/node/9001","alias"=>"/dp-known-alias","langcode"=>"en"]);
    $pa->set("domain_id","dp_intro");
    $pa->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: domain dp_intro has alias /dp-known-alias"
