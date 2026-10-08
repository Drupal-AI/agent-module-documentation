#!/usr/bin/env bash
# MEDIUM introspection setup: create a Google Programmable Search page whose display options
# are set to KNOWN non-default values (on-site results, two-column layout, watermark shown,
# custom query key), so the agent can be asked to inspect the live config and report them.
# Config lives in search.page.<id>.configuration.*. Removed by google_cse-layout-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\search\Entity\SearchPage;
$s = \Drupal::entityTypeManager()->getStorage("search_page")->load("google_eval_layout");
if ($s) { $s->delete(); }
SearchPage::create([
  "id" => "google_eval_layout",
  "label" => "Google Eval Layout",
  "path" => "google-eval-layout",
  "plugin" => "google_cse_search",
  "configuration" => [
    "cx" => "eval-layout-445566:layoutengine",
    "results_display" => "here",
    "custom_results_display" => "two-column",
    "watermark" => TRUE,
    "query_key" => "q",
  ],
])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search.page.google_eval_layout created (custom_results_display=two-column, watermark=true, query_key=q)"
