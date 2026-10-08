#!/usr/bin/env bash
# Introspection SETUP: install a small fixture module (jsonapi_hypermedia_ping) providing a
# JSON:API Hypermedia LinkProvider plugin that adds a link with key 'jsonapi_hypermedia_eval_ping'
# (relation type 'help') to the JSON:API entrypoint, so an inspecting agent can discover it via
# the provider manager. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/jsonapi_hypermedia_ping
mkdir -p "$M/src/Plugin/jsonapi_hypermedia/LinkProvider"
cat > "$M/jsonapi_hypermedia_ping.info.yml" <<'YML'
name: 'JSON:API Hypermedia Ping (eval fixture)'
type: module
description: 'Eval fixture: adds a hypermedia link provider to the JSON:API entrypoint.'
core_version_requirement: ^9 || ^10 || ^11
package: Testing
dependencies:
  - drupal:jsonapi_hypermedia
YML
cat > "$M/src/Plugin/jsonapi_hypermedia/LinkProvider/PingLinkProvider.php" <<'PHP'
<?php
namespace Drupal\jsonapi_hypermedia_ping\Plugin\jsonapi_hypermedia\LinkProvider;
use Drupal\Core\Access\AccessResult;
use Drupal\Core\Cache\CacheableMetadata;
use Drupal\Core\Url;
use Drupal\jsonapi_hypermedia\AccessRestrictedLink;
use Drupal\jsonapi_hypermedia\Plugin\LinkProviderBase;
/**
 * @JsonapiHypermediaLinkProvider(
 *   id = "jsonapi_hypermedia_ping",
 *   link_key = "jsonapi_hypermedia_eval_ping",
 *   link_relation_type = "help",
 *   link_context = {
 *     "top_level_object" = "entrypoint",
 *   }
 * )
 */
class PingLinkProvider extends LinkProviderBase {
  public function getLink($context) {
    return AccessRestrictedLink::createLink(AccessResult::allowed(), new CacheableMetadata(), Url::fromUri('base:/'), $this->getLinkRelationType());
  }
}
PHP
drush en jsonapi_hypermedia_ping -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: enabled jsonapi_hypermedia_ping (link_key jsonapi_hypermedia_eval_ping)"
