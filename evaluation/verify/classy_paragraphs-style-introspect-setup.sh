#!/usr/bin/env bash
# MEDIUM setup: create a known classy_paragraphs_style config entity so the agent can
# introspect the live site and report its CSS classes. Cleanup removes it.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("classy_paragraphs_style");
  if ($e = $s->load("eval_card")) { $e->delete(); }
  $s->create([
    "id" => "eval_card",
    "label" => "Eval Card",
    "classes" => "card\r\nshadow-lg\r\nrounded",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: classy_paragraphs_style eval_card (card, shadow-lg, rounded) created"
