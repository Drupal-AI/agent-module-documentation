#!/usr/bin/env bash
# Introspection SETUP: create a published llms_txt_section titled 'LLMS Eval Docs' so an agent
# can list the sections and report the title. Idempotent (removes prior copies first). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("llms_txt_section");
  foreach ($storage->loadByProperties(["title"=>"LLMS Eval Docs"]) as $s) { $s->delete(); }
  $storage->create(["title"=>"LLMS Eval Docs","content"=>["value"=>"- [Docs](/docs.md)","format"=>"plain_text"],"status"=>1,"weight"=>0])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: published llms_txt_section 'LLMS Eval Docs' created"
