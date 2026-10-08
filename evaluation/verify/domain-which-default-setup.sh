#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for domain.
# Creates two eval domains and makes the SECOND the default, so the answer is not
# just "the first/only one":
#   eval_one -> eval-one.example.com  (Eval One)
#   eval_two -> eval-two.example.com  (Eval Two)  <-- default
# The first domain saved is auto-default, so we explicitly promote eval_two.
# Only touches eval-prefixed ids. Cleanup deletes them.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("domain");
  foreach ($s->loadMultiple() as $d) { if (str_starts_with($d->id(), "eval")) { $d->delete(); } }
  $s->create(["id" => "eval_one", "hostname" => "eval-one.example.com", "name" => "Eval One", "scheme" => "https", "status" => TRUE])->save();
  $two = $s->create(["id" => "eval_two", "hostname" => "eval-two.example.com", "name" => "Eval Two", "scheme" => "https", "status" => TRUE]);
  $two->save();
  $two->saveDefault();
  $def = $s->loadDefaultDomain();
  print "setup: default is " . ($def ? $def->id() . " (" . $def->getHostname() . ")" : "none") . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
