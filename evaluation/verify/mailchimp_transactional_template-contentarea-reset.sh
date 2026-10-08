#!/usr/bin/env bash
# Execution RESET: (re)create a Template Map mtt_edit whose content_area is a WRONG value, so
# verify FAILS until the agent sets content_area to 'body_region'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_template");
  if ($e = $s->load("mtt_edit")) { $e->delete(); }
  $s->create([
    "id"=>"mtt_edit","label"=>"Editable map",
    "template_name"=>"receipt","content_area"=>"PLACEHOLDER",
    "only_use_merge_vars"=>FALSE,"mailsystem_key"=>"user_status_activated",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mtt_edit created with content_area=PLACEHOLDER"
