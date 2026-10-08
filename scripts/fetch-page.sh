#!/usr/bin/env bash
# Fetch one page of the popularity-sorted, Drupal-11-compatible module feed and print a
# trimmed table: machine_name, composer_namespace, active_installs, description.
#
# Usage:  scripts/fetch-page.sh [PAGE]     (PAGE defaults to 0; 50 modules per page)
# Run inside the DDEV web container, or via:  ddev exec scripts/fetch-page.sh 0
set -euo pipefail

PAGE="${1:-0}"
LIMIT=50
OFFSET=$(( PAGE * LIMIT ))

BASE='https://www.drupal.org/jsonapi/node/project_module'
QS="sort=-field_active_installs_total"
QS+="&filter[min][condition][path]=field_core_semver_minimum"
QS+="&filter[min][condition][operator]=%3C%3D&filter[min][condition][value]=11999999"
QS+="&filter[max][condition][path]=field_core_semver_maximum"
QS+="&filter[max][condition][operator]=%3E%3D&filter[max][condition][value]=11000000"
QS+="&fields[node--project_module]=title,field_project_machine_name,field_composer_namespace,field_active_installs_total,body"
QS+="&page[limit]=${LIMIT}&page[offset]=${OFFSET}"

curl -sfLg "${BASE}?${QS}" | php -r '
  $d = json_decode(file_get_contents("php://stdin"), true);
  if (!isset($d["data"])) { fwrite(STDERR, "no data\n"); exit(1); }
  printf("# page %d  (offset %d)  —  %d modules\n", (int)$argv[1], (int)$argv[2], count($d["data"]));
  foreach ($d["data"] as $n) {
    $a = $n["attributes"];
    $desc = trim(strip_tags($a["body"]["value"] ?? ""));
    $desc = preg_replace("/\s+/", " ", mb_substr($desc, 0, 90));
    printf("%-40s %-30s %8s  %s\n",
      $a["field_project_machine_name"] ?? "?",
      $a["field_composer_namespace"] ?? "?",
      $a["field_active_installs_total"] ?? 0,
      $desc);
  }
' "$PAGE" "$OFFSET"
