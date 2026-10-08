#!/usr/bin/env bash
# Introspection SETUP for the workbench_access "known taxonomy scheme" medium cases.
# Saves a KNOWN access_scheme config entity to the live site so the model can be asked to
# read its configuration back with drush. Idempotent: deletes any prior copy first, then
# recreates it with fixed, distinctive values the introspection cases assert on:
#   - id/label:        wa_eval_editorial / "Eval Editorial"
#   - scheme (plugin): taxonomy   (an AccessControlHierarchy plugin)
#   - scheme_settings: vocabularies => ["tags"]
#   - plural_label:    "Editorial desks"
# Deprecation notices from unrelated contrib modules print on stderr; suppressed with 2>/dev/null.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("access_scheme");
  if ($e = $s->load("wa_eval_editorial")) { $e->delete(); }
  $s->create([
    "id" => "wa_eval_editorial",
    "label" => "Eval Editorial",
    "plural_label" => "Editorial desks",
    "scheme" => "taxonomy",
    "scheme_settings" => ["vocabularies" => ["tags"], "fields" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: access_scheme 'wa_eval_editorial' saved (plugin taxonomy, vocabulary tags)"
