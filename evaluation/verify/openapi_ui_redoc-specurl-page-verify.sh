#!/usr/bin/env bash
# Execution VERIFY: /oui-redoc-eval/docs must render the ReDoc openapi_ui plugin from a spec
# URL. Issues a real sub-request through the http_kernel and requires:
#   HTTP 200, a <redoc ...> element, spec-url="https://example.com/oui-redoc-eval/openapi.json",
#   and the ReDoc CDN library (redoc.min.js) in the page.
# (200 additionally proves the missing `type: external` on the redoc library was dealt with --
#  with core's locale module enabled the page otherwise throws in _locale_parse_js_file().)
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
# Rebuild caches first: the agent may have just added a route/module and the container
# in the previous drush run can still be stale. Read-only w.r.t. content and config.
drush cr >/dev/null 2>&1
out=$(drush php:eval '
  use Symfony\Component\HttpFoundation\Request;
  try {
    $res = \Drupal::service("http_kernel")->handle(Request::create("/oui-redoc-eval/docs"));
    $status = $res->getStatusCode();
    $html = (string) $res->getContent();
  }
  catch (\Throwable $e) {
    $status = 0;
    $html = "";
  }
  $tag = str_contains($html, "<redoc");
  $url = str_contains($html, "spec-url=\"https://example.com/oui-redoc-eval/openapi.json\"");
  $lib = str_contains($html, "redoc.min.js");
  $ok = ($status === 200 && $tag && $url && $lib);
  print ($ok ? "PASS" : "FAIL")
    . " status=" . $status
    . " redoc_tag=" . (int) $tag
    . " spec_url=" . (int) $url
    . " library=" . (int) $lib . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
