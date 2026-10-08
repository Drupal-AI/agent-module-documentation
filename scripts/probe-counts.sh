#!/usr/bin/env bash
probe() {
  local label="$1" minval="$2" maxval="$3"
  local url="https://www.drupal.org/jsonapi/node/project_module"
  url+="?sort=-field_active_installs_total"
  url+="&filter[min][condition][path]=field_core_semver_minimum&filter[min][condition][operator]=%3C%3D&filter[min][condition][value]=${minval}"
  url+="&filter[max][condition][path]=field_core_semver_maximum&filter[max][condition][operator]=%3E%3D&filter[max][condition][value]=${maxval}"
  url+="&filter[status]=1&page[limit]=50"
  echo "--- $label ---"
  curl -sfLg "$url" | php -r '$d=json_decode(file_get_contents("php://stdin"),true); echo "returned=".count($d["data"]??[])."\n"; foreach(["next","last"] as $k){ if(isset($d["links"][$k]["href"])){ preg_match("/offset%5D=(\d+)|offset\]=(\d+)/",$d["links"][$k]["href"],$m); echo "  $k offset=".(($m[1]??"")?:($m[2]??"?"))."\n"; } else echo "  $k: none\n"; }'
}
probe "D11-compatible" 11999999 11000000
probe "D10-compatible" 10999999 10000000
