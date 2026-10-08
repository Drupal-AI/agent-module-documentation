#!/usr/bin/env bash
# Introspection SETUP: create two site settings types (sstp_probe_alpha, sstp_probe_beta) so the
# submodule generates their per-type permissions, then create a role sstp_probe_editor granted
# ONLY the beta type's edit permission. The agent must inspect live role permissions to say which
# settings type that role may edit. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\user\Entity\Role;
  foreach (["sstp_probe_alpha" => "SSTP Probe Alpha", "sstp_probe_beta" => "SSTP Probe Beta"] as $id => $label) {
    if (!SiteSettingEntityType::load($id)) {
      SiteSettingEntityType::create(["id" => $id, "label" => $label, "group" => "", "multiple" => FALSE])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("sstp_probe_editor")) {
    Role::create(["id" => "sstp_probe_editor", "label" => "SSTP Probe Editor"])->save();
  }
  $r = Role::load("sstp_probe_editor");
  foreach ($r->getPermissions() as $p) { $r->revokePermission($p); }
  $r->grantPermission("access content");
  $r->grantPermission("edit sstp_probe_beta site setting");
  $r->grantPermission("view published sstp_probe_beta site setting entities");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role sstp_probe_editor may edit sstp_probe_beta only (types alpha+beta exist)"
