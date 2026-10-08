#!/usr/bin/env bash
# Execution VERIFY for the "bubble a real max-age" case. PASS when:
#   * the cache_control_override_eval module is installed;
#   * requesting /cco-eval/short through the HTTP kernel yields a CacheableResponse whose
#     bubbled cacheability max-age is exactly 45;
#   * cache_control_override.settings would leave 45 alone - max_age.minimum <= 45 and
#     max_age.maximum is either -1 (no ceiling) or >= 45.
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Cache\CacheableResponseInterface;
  use Symfony\Component\HttpFoundation\Request;
  use Symfony\Component\HttpKernel\HttpKernelInterface;
  $checks = [];
  $checks["module_installed"] = \Drupal::moduleHandler()->moduleExists("cache_control_override_eval");
  $bubbled = NULL;
  $status = NULL;
  try {
    $request = Request::create("/cco-eval/short");
    $response = \Drupal::service("http_kernel")->handle($request, HttpKernelInterface::MAIN_REQUEST);
    $status = $response->getStatusCode();
    if ($response instanceof CacheableResponseInterface) {
      $bubbled = (int) $response->getCacheableMetadata()->getCacheMaxAge();
    }
  }
  catch (\Throwable $e) {
    $status = "exception: " . $e->getMessage();
  }
  $checks["route_ok"] = ($status === 200);
  $checks["bubbled_45"] = ($bubbled === 45);
  $c = \Drupal::config("cache_control_override.settings");
  $min = (int) $c->get("max_age.minimum");
  $max = (int) $c->get("max_age.maximum");
  $checks["floor_ok"] = ($min <= 45);
  $checks["ceiling_ok"] = ($max === -1 || $max >= 45);
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " status=" . var_export($status, TRUE)
    . " bubbled=" . var_export($bubbled, TRUE)
    . " minimum=$min maximum=$max\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
