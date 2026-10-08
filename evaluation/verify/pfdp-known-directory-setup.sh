#!/usr/bin/env bash
# Introspection SETUP: create the role pfdp_intro_role and two pfdp_directory config entities —
# pfdp_intro_open (/pfdp-intro-open, granted to pfdp_intro_role) and pfdp_intro_locked
# (/pfdp-intro-locked, granted to nobody) — so the agent must read live pfdp config to say who
# may download from which path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\pfdp\Entity\DirectoryEntity;
  use Drupal\user\Entity\Role;
  if (!Role::load("pfdp_intro_role")) { Role::create(["id" => "pfdp_intro_role", "label" => "PFDP Intro Role"])->save(); }
  $spec = [
    "pfdp_intro_open" => ["path" => "/pfdp-intro-open", "roles" => ["pfdp_intro_role"]],
    "pfdp_intro_locked" => ["path" => "/pfdp-intro-locked", "roles" => []],
  ];
  foreach ($spec as $id => $s) {
    if ($existing = DirectoryEntity::load($id)) { $existing->delete(); }
    DirectoryEntity::create([
      "id" => $id, "path" => $s["path"], "bypass" => FALSE,
      "grant_file_owners" => FALSE, "users" => [], "roles" => $s["roles"],
    ])->save();
    print $id . " path=" . $s["path"] . " roles=" . implode(",", $s["roles"]) . "\n";
  }
' 2>/dev/null
echo "setup: pfdp_intro_open granted to pfdp_intro_role, pfdp_intro_locked granted to nobody"
