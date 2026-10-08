#!/usr/bin/env bash
# Introspection SETUP: create a TMGMT translator tmgg_eval using the google plugin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if (!Translator::load("tmgg_eval")) {
    Translator::create(["name"=>"tmgg_eval","label"=>"TMGG Eval","plugin"=>"google","settings"=>["api_key"=>"EVAL-KEY","auto_accept"=>false]])->save();
  }
' >/dev/null 2>&1
echo "setup: tmgmt_translator tmgg_eval (plugin google) created"
