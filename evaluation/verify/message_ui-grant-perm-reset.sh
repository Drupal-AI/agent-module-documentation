#!/usr/bin/env bash
# Execution RESET: ensure template 'message_ui_hard' exists and role 'message_ui_hrole' exists
# WITHOUT the per-template create permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\message\Entity\MessageTemplate;
  use Drupal\user\Entity\Role;
  if (!MessageTemplate::load("message_ui_hard")) {
    MessageTemplate::create(["template"=>"message_ui_hard","label"=>"Message UI Hard","text"=>[["value"=>"H","format"=>"basic_html"]]])->save();
  }
  $r = Role::load("message_ui_hrole") ?: Role::create(["id"=>"message_ui_hrole","label"=>"Message UI HRole"]);
  $r->revokePermission("create message_ui_hard message");
  $r->save();
' >/dev/null 2>&1
echo "reset: role message_ui_hrole present without create-perm; template message_ui_hard present"
