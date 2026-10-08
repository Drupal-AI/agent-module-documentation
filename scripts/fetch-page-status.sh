#!/usr/bin/env bash
# Like fetch-page.sh but also resolves each project's development + maintenance status.
# Output (tab-separated): machine_name  composer_namespace  active_installs  dev_status  maint_status
# Usage:  scripts/fetch-page-status.sh [PAGE]   (PAGE default 0; 50/page)
set -euo pipefail
PAGE="${1:-0}"; LIMIT=50; OFFSET=$(( PAGE * LIMIT ))
BASE='https://www.drupal.org/jsonapi/node/project_module'
QS="sort=-field_active_installs_total"
QS+="&filter[min][condition][path]=field_core_semver_minimum&filter[min][condition][operator]=%3C%3D&filter[min][condition][value]=11999999"
QS+="&filter[max][condition][path]=field_core_semver_maximum&filter[max][condition][operator]=%3E%3D&filter[max][condition][value]=11000000"
QS+="&include=field_development_status,field_maintenance_status"
QS+="&fields[node--project_module]=field_project_machine_name,field_composer_namespace,field_active_installs_total,field_development_status,field_maintenance_status"
QS+="&fields[taxonomy_term--development_status]=name&fields[taxonomy_term--maintenance_status]=name"
QS+="&page[limit]=${LIMIT}&page[offset]=${OFFSET}"
curl -sfLg "${BASE}?${QS}" | php -r '
  $d=json_decode(file_get_contents("php://stdin"),true);
  if(!isset($d["data"])){fwrite(STDERR,"no data\n");exit(1);}
  $term=[]; foreach(($d["included"]??[]) as $i){ $term[$i["id"]]=$i["attributes"]["name"]??""; }
  foreach($d["data"] as $n){ $a=$n["attributes"]; $r=$n["relationships"]??[];
    $dev=$term[$r["field_development_status"]["data"]["id"]??""]??"";
    $mnt=$term[$r["field_maintenance_status"]["data"]["id"]??""]??"";
    printf("%s\t%s\t%s\t%s\t%s\n",
      $a["field_project_machine_name"]??"?", $a["field_composer_namespace"]??"?",
      $a["field_active_installs_total"]??0, $dev, $mnt);
  }'
