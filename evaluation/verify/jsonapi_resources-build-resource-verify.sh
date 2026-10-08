#!/usr/bin/env bash
# Live-state verification for the "build a custom JSON:API resource" hard case.
# PASS (exit 0) requires ALL of:
#   mod    — the module jsonapi_resources_eval_build is installed
#   route  — a route in the live table declares a _jsonapi_resource default AND belongs to that
#            module (route name starts with jsonapi_resources_eval_build. OR the _jsonapi_resource
#            value references the module's namespace/service), with a path under the JSON:API base
#            path (starts with /jsonapi)
#   base   — the resource the route points to resolves to a class that is a subclass of
#            Drupal\jsonapi_resources\Resource\ResourceBase (a real resource processor)
# Scoped to the jsonapi_resources_eval_build module so it never matches the medium fixture route.
# Prints PASS/FAIL with detail. No arguments. Paths relative to the Drupal root.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $mod = \Drupal::moduleHandler()->moduleExists("jsonapi_resources_eval_build");
  $route_ok = FALSE; $base_ok = FALSE; $path = ""; $res = ""; $rname = "";
  if ($mod) {
    $provider = \Drupal::service("router.route_provider");
    foreach ($provider->getAllRoutes() as $name => $route) {
      $resource = $route->getDefault("_jsonapi_resource");
      if (empty($resource)) { continue; }
      $owned = (strpos($name, "jsonapi_resources_eval_build.") === 0)
        || (strpos($resource, "jsonapi_resources_eval_build") !== FALSE);
      if (!$owned) { continue; }
      $path = $route->getPath();
      if (strpos($path, "/jsonapi") !== 0) { continue; }
      $route_ok = TRUE; $res = $resource; $rname = $name;
      // Resolve the resource to a class: either a service id in the container or a class FQN.
      $class = NULL;
      $container = \Drupal::getContainer();
      if ($container->has($resource)) { $class = get_class($container->get($resource)); }
      elseif (class_exists($resource)) { $class = $resource; }
      if ($class && is_subclass_of($class, "Drupal\\jsonapi_resources\\Resource\\ResourceBase")) {
        $base_ok = TRUE;
      }
      break;
    }
  }
  $pass = $mod && $route_ok && $base_ok;
  print ($pass ? "PASS" : "FAIL") . " mod=" . ($mod?1:0) . " route=" . ($route_ok?1:0)
    . " base=" . ($base_ok?1:0) . " name=" . $rname . " path=" . $path . " res=" . $res . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
