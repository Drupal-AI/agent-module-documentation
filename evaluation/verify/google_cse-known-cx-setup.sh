#!/usr/bin/env bash
# MEDIUM introspection setup: create a Google Programmable Search page (core search.page
# config entity using the google_cse_search plugin) with a KNOWN Search Engine ID (cx) and
# configured to redirect results to Google, so the agent can be asked to read it back.
# google_cse stores NO google_cse.settings object — its config lives inside search.page.<id>
# under configuration.*. Removed by google_cse-known-cx-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\search\Entity\SearchPage;
$s = \Drupal::entityTypeManager()->getStorage("search_page")->load("google_eval_known");
if ($s) { $s->delete(); }
SearchPage::create([
  "id" => "google_eval_known",
  "label" => "Google Eval Known",
  "path" => "google-eval-known",
  "plugin" => "google_cse_search",
  "configuration" => [
    "cx" => "eval-known-778899:sampleengine",
    "results_display" => "google",
    "custom_results_display" => "results-only",
  ],
])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search.page.google_eval_known created (cx=eval-known-778899:sampleengine, results_display=google)"
