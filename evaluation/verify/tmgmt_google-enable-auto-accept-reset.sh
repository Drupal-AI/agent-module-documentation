#!/usr/bin/env bash
# Execution RESET: create translator tmgg_autotask (plugin google) with auto_accept=false so verify
# FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if ($t = Translator::load("tmgg_autotask")) { $t->delete(); }
  Translator::create(["name"=>"tmgg_autotask","label"=>"TMGG Autotask","plugin"=>"google","settings"=>["api_key"=>"EVAL-KEY","auto_accept"=>false]])->save();
' >/dev/null 2>&1
echo "reset: tmgg_autotask auto_accept=false"
