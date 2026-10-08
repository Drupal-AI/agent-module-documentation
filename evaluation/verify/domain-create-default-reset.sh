#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for domain: clear eval domains, then seed ONE placeholder
# eval domain that IS the default (eval_placeholder -> placeholder.eval.example.com).
# Because a pre-existing default now exists, the agent must EXPLICITLY promote the
# domain it creates to default (creating a domain alone won't make it default).
# On this reset state verify FAILs: the target shop.eval.example.com does not exist.
# Only touches eval-prefixed ids; never real domains.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("domain");
  foreach ($s->loadMultiple() as $d) { if (str_starts_with($d->id(), "eval")) { $d->delete(); } }
  $p = $s->create(["id" => "eval_placeholder", "hostname" => "placeholder.eval.example.com", "name" => "Eval Placeholder", "scheme" => "https", "status" => TRUE]);
  $p->save();
  $p->saveDefault();
  print "reset: seeded eval_placeholder as default\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
