#!/usr/bin/env bash
# Introspection SETUP for the jsonapi_resources "known resource route" medium cases.
#
# jsonapi_resources is a developer FRAMEWORK: it ships NO routes or resources of its own, so a
# bare site has nothing to introspect. To give the model a KNOWN custom JSON:API resource route
# to read back, this script plants a tiny fixture module that declares one resource route via a
# *.routing.yml `_jsonapi_resource` default, backed by a self-contained ResourceBase subclass.
# The fixed, distinctive values the introspection cases assert on:
#   - module:         jsonapi_resources_eval_fixture (web/modules/custom/…)
#   - route name:     jsonapi_resources_eval_fixture.info
#   - resource path:  /jsonapi/eval-fixture-info   (%jsonapi% is rewritten to /jsonapi)
#   - resource class: Drupal\jsonapi_resources_eval_fixture\Resource\EvalFixtureInfo
# The class mirrors the module's own SiteInfo test example (a config-backed, non-entity resource)
# so the route passes jsonapi_resources' build-time validator and actually registers.
# Idempotent: rewrites the module files and re-enables every run. Paths relative to the Drupal
# root (/var/www/html). Deprecation notices from unrelated contrib print to stderr; the readable
# result is echoed at the end.
set -uo pipefail
cd /var/www/html

MOD=web/modules/custom/jsonapi_resources_eval_fixture
mkdir -p "$MOD/src/Resource"

cat > "$MOD/jsonapi_resources_eval_fixture.info.yml" <<'YML'
name: 'JSON:API Resources Eval Fixture'
type: module
description: 'Fixture custom JSON:API resource route planted for jsonapi_resources introspection evals.'
core_version_requirement: ^9.1 || ^10 || ^11
package: Testing
dependencies:
  - drupal:jsonapi_resources
YML

cat > "$MOD/jsonapi_resources_eval_fixture.routing.yml" <<'YML'
# A custom JSON:API resource route. The path begins with /%jsonapi% (rewritten to the
# JSON:API base path) and uses a _jsonapi_resource default instead of a _controller.
jsonapi_resources_eval_fixture.info:
  path: '/%jsonapi%/eval-fixture-info'
  defaults:
    _jsonapi_resource: Drupal\jsonapi_resources_eval_fixture\Resource\EvalFixtureInfo
  requirements:
    _access: 'TRUE'
YML

cat > "$MOD/src/Resource/EvalFixtureInfo.php" <<'PHP'
<?php

namespace Drupal\jsonapi_resources_eval_fixture\Resource;

use Drupal\Core\Cache\CacheableMetadata;
use Drupal\Core\Cache\CacheableResponseInterface;
use Drupal\Core\Config\ConfigFactoryInterface;
use Drupal\Core\DependencyInjection\ContainerInjectionInterface;
use Drupal\jsonapi\JsonApiResource\LinkCollection;
use Drupal\jsonapi\JsonApiResource\ResourceObject;
use Drupal\jsonapi\JsonApiResource\ResourceObjectData;
use Drupal\jsonapi\ResourceResponse;
use Drupal\jsonapi\ResourceType\ResourceType;
use Drupal\jsonapi\ResourceType\ResourceTypeAttribute;
use Drupal\jsonapi_resources\Resource\ResourceBase;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Route;

/**
 * Known fixture resource used by jsonapi_resources introspection evals.
 */
final class EvalFixtureInfo extends ResourceBase implements ContainerInjectionInterface {

  protected ConfigFactoryInterface $configFactory;

  public function __construct(ConfigFactoryInterface $config_factory) {
    $this->configFactory = $config_factory;
  }

  public static function create(ContainerInterface $container): EvalFixtureInfo {
    return new static($container->get('config.factory'));
  }

  public function process(Request $request, array $resource_types): ResourceResponse {
    $config = $this->configFactory->get('system.site');
    $cacheability = new CacheableMetadata();
    $cacheability->addCacheableDependency($config);

    $resource_type = reset($resource_types);
    $primary_data = new ResourceObject(
      $cacheability,
      $resource_type,
      'system.site',
      NULL,
      ['name' => $config->get('name')],
      new LinkCollection([])
    );

    $top_level_data = new ResourceObjectData([$primary_data], 1);
    $response = $this->createJsonapiResponse($top_level_data, $request);
    if ($response instanceof CacheableResponseInterface) {
      $response->addCacheableDependency($cacheability);
    }
    return $response;
  }

  public function getRouteResourceTypes(Route $route, string $route_name): array {
    $fields = ['name' => new ResourceTypeAttribute('name')];
    $resource_type = new ResourceType('eval_fixture_info', 'eval_fixture_info', NULL, FALSE, TRUE, FALSE, FALSE, $fields);
    return [$resource_type];
  }

}
PHP

drush en jsonapi_resources_eval_fixture -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: route jsonapi_resources_eval_fixture.info -> path /jsonapi/eval-fixture-info, _jsonapi_resource Drupal\\jsonapi_resources_eval_fixture\\Resource\\EvalFixtureInfo (module jsonapi_resources_eval_fixture)"
