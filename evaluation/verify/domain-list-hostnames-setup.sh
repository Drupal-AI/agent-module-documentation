#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for domain.
# Saves a KNOWN set of eval `domain` config entities the agent must discover:
#   eval_alpha -> eval-alpha.example.com  (Eval Alpha)
#   eval_beta  -> eval-beta.example.com   (Eval Beta)
# Only touches eval-prefixed ids; never real domains. Cleanup deletes them.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("domain");
  foreach ($s->loadMultiple() as $d) { if (str_starts_with($d->id(), "eval")) { $d->delete(); } }
  foreach ([
    ["eval_alpha", "eval-alpha.example.com", "Eval Alpha"],
    ["eval_beta",  "eval-beta.example.com",  "Eval Beta"],
  ] as [$id, $host, $name]) {
    $s->create(["id" => $id, "hostname" => $host, "name" => $name, "scheme" => "https", "status" => TRUE])->save();
  }
  print "setup: created eval_alpha, eval_beta\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
