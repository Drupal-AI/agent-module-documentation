#!/usr/bin/env bash
# Introspection SETUP: create a pagerer_preset 'pgr_known' whose center pane uses the
# 'adaptive' style, so the agent can inspect the live config and identify it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("pagerer_preset");
  $p = $s->load("pgr_known") ?: $s->create(["id" => "pgr_known", "label" => "Known Pager"]);
  $p->set("panes", [
    "left" => ["style" => "none", "config" => []],
    "center" => ["style" => "adaptive", "config" => []],
    "right" => ["style" => "none", "config" => []],
  ]);
  $p->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pagerer_preset 'pgr_known' (center=adaptive) created"
