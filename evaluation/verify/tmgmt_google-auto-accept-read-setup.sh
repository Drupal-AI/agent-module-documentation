#!/usr/bin/env bash
# Introspection SETUP: create a google translator tmgg_auto_eval with auto_accept=true. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tmgg_auto_eval") ?: Translator::create(["name"=>"tmgg_auto_eval","label"=>"TMGG Auto","plugin"=>"google"]);
  $t->setSetting("api_key","EVAL-KEY");
  $t->setSetting("auto_accept", TRUE);
  $t->save();
' >/dev/null 2>&1
echo "setup: tmgg_auto_eval auto_accept=true"
