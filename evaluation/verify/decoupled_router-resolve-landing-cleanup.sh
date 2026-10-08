#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) cleanup for decoupled_router: remove the known landing
# node + alias created by decoupled_router-resolve-landing-setup.sh.
set -uo pipefail
cd /var/www/html

drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => "/dr-eval-landing"]) as $a) { $a->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["uuid" => "aaaaaaaa-1111-4222-8333-444444444444"]) as $n) { $n->delete(); }
  print "cleanup: landing node + alias removed\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
