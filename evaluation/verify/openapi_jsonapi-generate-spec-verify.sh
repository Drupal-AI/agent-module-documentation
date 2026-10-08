#!/usr/bin/env bash
# Hard verify: the agent must produce a JSON:API OpenAPI (Swagger 2.0) specification with
# the `jsonapi` openapi generator and write it as JSON to /tmp/openapi_jsonapi_eval_spec.json.
# Checks the artifact is a valid OpenAPI/Swagger doc that clearly describes JSON:API.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html
FILE=/tmp/openapi_jsonapi_eval_spec.json

if [ ! -s "$FILE" ]; then
  echo "FAIL: $FILE missing or empty"
  exit 1
fi

# Validate with PHP (always available here) so we don't depend on jq.
out=$(php -r '
  $f = $argv[1];
  $spec = json_decode(file_get_contents($f), TRUE);
  if (!is_array($spec)) { print "FAIL bad_json"; exit; }
  // OpenAPI/Swagger version marker (accept swagger 2.0 or openapi 3.x).
  $ver = $spec["swagger"] ?? $spec["openapi"] ?? "";
  $has_ver = (strpos((string) $ver, "2.0") === 0) || (strpos((string) $ver, "3.") === 0);
  // Must have info + at least one path documented.
  $has_info = !empty($spec["info"]) && !empty($spec["info"]["title"]);
  $has_paths = !empty($spec["paths"]) && count($spec["paths"]) > 0;
  // Must clearly be a JSON:API spec: title says JSON API, or /jsonapi base path,
  // or the vnd.api+json media type appears in consumes/produces.
  $blob = strtolower(json_encode($spec));
  $mentions_jsonapi =
    (strpos(strtolower((string)($spec["info"]["title"] ?? "")), "json api") !== FALSE) ||
    (strpos(strtolower((string)($spec["basePath"] ?? "")), "jsonapi") !== FALSE) ||
    (strpos($blob, "vnd.api+json") !== FALSE) ||
    (strpos($blob, "jsonapi") !== FALSE);
  printf("ver=%d info=%d paths=%d jsonapi=%d npaths=%d title=%s",
    $has_ver?1:0, $has_info?1:0, $has_paths?1:0, $mentions_jsonapi?1:0,
    $has_paths ? count($spec["paths"]) : 0, (string)($spec["info"]["title"] ?? ""));
  if ($has_ver && $has_info && $has_paths && $mentions_jsonapi) { print " OK"; }
' "$FILE" 2>/dev/null)

echo "$out"
if echo "$out" | grep -q ' OK$'; then
  echo "PASS: valid JSON:API OpenAPI spec produced"
  exit 0
fi
echo "FAIL: artifact is not a valid JSON:API OpenAPI spec"
exit 1
