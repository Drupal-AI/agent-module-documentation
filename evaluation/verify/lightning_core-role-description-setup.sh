#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: create a KNOWN user role whose description is stored via Lightning
# Core's role-description feature (third_party_settings.lightning_core.description). The
# description text is fixed and discoverable so an inspecting agent (drush) can read it
# back off the user.role config entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("user_role");
  if ($e = $s->load("eval_lc_role")) { $e->delete(); }
  $r = $s->create(["id" => "eval_lc_role", "label" => "Eval LC Role"]);
  $r->setThirdPartySetting("lightning_core", "description", "Reviews and approves editorial content before publication.");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role eval_lc_role created with lightning_core description"
