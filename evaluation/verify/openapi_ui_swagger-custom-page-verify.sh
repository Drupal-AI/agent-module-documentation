#!/usr/bin/env bash
# Execution VERIFY for "expose /openapi-ui-swagger-eval/docs rendering the JSON:API OpenAPI
# spec with Swagger UI".
# PASS when an anonymous sub-request to that path returns 200 and the markup carries the
# swagger-ui container produced by SwaggerUi::build() (id="swagger-ui" / swagger-ui-wrap)
# together with a data-openapi-ui-url or data-openapi-ui-spec attribute.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  try {
    $request = \Symfony\Component\HttpFoundation\Request::create("/openapi-ui-swagger-eval/docs");
    $response = \Drupal::service("http_kernel")->handle($request);
    $status = $response->getStatusCode();
    $body = (string) $response->getContent();
  }
  catch (\Throwable $e) {
    $status = 0;
    $body = "";
  }
  $wrap = (strpos($body, "swagger-ui-wrap") !== FALSE) || (strpos($body, "id=\"swagger-ui\"") !== FALSE);
  $data = (strpos($body, "data-openapi-ui-url") !== FALSE) || (strpos($body, "data-openapi-ui-spec") !== FALSE);
  $ok = ($status === 200) && $wrap && $data;
  print ($ok ? "PASS" : "FAIL")
    . " status=" . $status
    . " swagger_container=" . var_export($wrap, TRUE)
    . " schema_attribute=" . var_export($data, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
