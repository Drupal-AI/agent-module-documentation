# Entity Share — programmatic use

All Entity Share configuration is plain **config entities**, so use the entity type manager.
The relevant storages appear only when the submodules are enabled (`entity_share_server` →
`channel`; `entity_share_client` → `remote`, `import_config`, `entity_import_status`).

## Create a server Channel

```php
$channel = \Drupal::entityTypeManager()->getStorage('channel')->create([
  'id' => 'articles_en',
  'label' => 'Articles EN',
  'channel_entity_type' => 'node',
  'channel_bundle' => 'article',
  'channel_langcode' => 'en',
  'access_by_permission' => TRUE,
]);
$channel->save();
```

## Create a client Remote

```php
$remote = \Drupal::entityTypeManager()->getStorage('remote')->create([
  'id' => 'hub',
  'label' => 'Content hub',
  'url' => 'https://hub.example.com',
  'auth' => ['pid' => 'anonymous', 'uuid' => '', 'data' => []],
]);
$remote->save();
```

## Read config entities back

```php
$channel = \Drupal::entityTypeManager()->getStorage('channel')->load('articles_en');
$type   = $channel->get('channel_entity_type');   // "node"
$bundle = $channel->get('channel_bundle');         // "article"

$remote = \Drupal::entityTypeManager()->getStorage('remote')->load('hub');
$url    = $remote->get('url');                      // "https://hub.example.com"
```

List all channels / remotes:

```php
$channels = \Drupal::entityTypeManager()->getStorage('channel')->loadMultiple();
$remotes  = \Drupal::entityTypeManager()->getStorage('remote')->loadMultiple();
```

## Client services

The client submodule exposes services you can call to drive an import (see
`entity_share_client.services.yml`):

- `entity_share_client.remote_manager` (`RemoteManager`) — builds the authenticated HTTP client
  for a `remote` and fetches channel JSON:API data.
- `entity_share_client.import_service` (`ImportService`) — runs the import pipeline for a set of
  entity UUIDs pulled from a channel, applying the chosen `import_config` processors.
- `entity_share_client.jsonapi_helper` — maps JSON:API documents to Drupal entities.

Typical flow: load a `remote`, use `RemoteManager` to list a channel's entities, then hand the
selected UUIDs plus a `remote`, channel id, and `import_config` id to `ImportService` to
create/update the local entities. The Pull form and Drush commands are thin wrappers over this.

## Extension points (plugin types, client)

`entity_share_client` defines pluggable managers you can extend:

- **Import processor** — `entity_share_client.plugin.manager.import_processor`, attribute
  `Drupal\entity_share_client\Attribute\ImportProcessor`, base
  `ImportProcessorPluginBase`, place classes in `Plugin/ImportProcessor/`.
- **Client authorization** — `entity_share_client.plugin.manager.client_authorization`, attribute
  `Drupal\entity_share_client\Attribute\ClientAuthorization`, base
  `ClientAuthorizationPluginBase`, place classes in `Plugin/ClientAuthorization/`
  (existing: `anonymous`, `basic_auth`, `header`, `oauth`).
- **Import policy** — `ImportPolicyPluginManager`, used by the default data processor to decide
  publish/update behavior of pulled content.

Limitation: an actual pull needs a reachable second Drupal site running `entity_share_server`.
On a single site the config-entity create/read calls above still work and are the ground truth
the evals check.
