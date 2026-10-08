#!/usr/bin/env bash
# Introspection SETUP: create a known Template Map config entity mtt_default (template_name
# 'welcome-brand', content_area 'main_content', mailsystem_key 'default-system'), so an inspecting
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_template");
  if (!$s->load("mtt_default")) {
    $s->create([
      "id"=>"mtt_default","label"=>"Default brand map",
      "template_name"=>"welcome-brand","content_area"=>"main_content",
      "only_use_merge_vars"=>FALSE,"mailsystem_key"=>"default-system",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Template Map mtt_default (template_name=welcome-brand, content_area=main_content, mailsystem_key=default-system)"
