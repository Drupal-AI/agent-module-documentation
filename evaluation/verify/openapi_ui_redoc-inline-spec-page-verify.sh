#!/usr/bin/env bash
# Execution VERIFY: /oui-redoc-eval/inline must render the ReDoc openapi_ui plugin from an
# INLINE spec array, i.e. ReDoc::build()'s non-Url branch. Requires:
#   HTTP 200, a <redoc ...> element carrying a `spec=` attribute (NOT spec-url), the
#   JSON-encoded title "OUI ReDoc Eval Inline API", and the ReDoc CDN library.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
# Rebuild caches first: the agent may have just added a route/module and the container
# in the previous drush run can still be stale. Read-only w.r.t. content and config.
drush cr >/dev/null 2>&1
out=$(drush php:eval '
  use Symfony\Component\HttpFoundation\Request;
  try {
    $res = \Drupal::service("http_kernel")->handle(Request::create("/oui-redoc-eval/inline"));
    $status = $res->getStatusCode();
    $html = (string) $res->getContent();
  }
  catch (\Throwable $e) {
    $status = 0;
    $html = "";
  }
  $tag = (bool) preg_match("/<redoc[^>]*>/", $html);
  $spec = (bool) preg_match("/<redoc[^>]*\\sspec=/", $html);
  $nourl = !str_contains($html, "spec-url=");
  $title = str_contains($html, "OUI ReDoc Eval Inline API");
  $lib = str_contains($html, "redoc.min.js");
  $ok = ($status === 200 && $tag && $spec && $nourl && $title && $lib);
  print ($ok ? "PASS" : "FAIL")
    . " status=" . $status
    . " redoc_tag=" . (int) $tag
    . " spec_attr=" . (int) $spec
    . " no_spec_url=" . (int) $nourl
    . " title=" . (int) $title
    . " library=" . (int) $lib . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
