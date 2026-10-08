<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure media access

adva_media has **no settings form of its own**. Media access is configured on the shared adva form,
using the `media` consumer that this submodule registers.

## Enable and configure

1. Enable the module: `drush en adva_media -y` (pulls in `adva` and core `media`).
2. Go to `/admin/config/people/adva` (route `adva.settings`, permission `administer adva`). The
   **Media** consumer appears alongside any other consumers.
3. Enable one or more **Access Providers** for the Media consumer (e.g. **Anonymous Access**, id
   `anonymous`) and set the per-operation / per-media-type options the provider offers.
4. Save. Saving queues a rebuild of media access records.
5. Rebuild records if prompted: `/admin/config/people/adva/rebuild/media` (route
   `adva.access_rebuild`, `RebuildPermissionsForm`), or let cron drain the queue
   `adva_rebuild_access_records:media`.

The status report (`/admin/reports/status`) shows an **Advanced Access Media Permissions** line:
"Disabled. No Access Providers configured." until a provider is enabled, then a count of records in
use, plus a "Rebuild Required" warning when the queue is non-empty.

## Config storage

The Media consumer's settings are stored in an `access_consumer` config entity with id `media`
(defined by the parent module). Exported keys: `id`, `settings`, `providers`, `provider_config`.
There is no `config/install` or `config/schema` in adva_media — the schema comes from adva
(`adva.schema.yml`, `adva.access_provider.schema.yml`).

Set providers for the media consumer with PHP:

```php
$consumer = \Drupal::entityTypeManager()
  ->getStorage('access_consumer')
  ->load('media') ?: \Drupal\adva\Entity\AccessConsumer::create(['id' => 'media']);
$consumer->setProviders(['anonymous']);
// Optional per-provider config, e.g. grant view to anonymous for all media types:
$consumer->setProviderConfig('anonymous', [
  'default' => ['enabled' => TRUE, 'operations' => ['view' => ['anonymous' => 1]]],
]);
$consumer->save();
// Rebuild media access records.
\Drupal::service('plugin.manager.adva.consumer')
  ->getConsumerForEntityTypeId('media')
  ->queue();
```

Or via drush config commands, e.g. `drush cget access_consumer.media` to inspect and
`drush cset access_consumer.media providers.0 anonymous -y` to set a provider id.

## Bypass permission

Once the `media` consumer exists, adva's permission callback exposes
**`bypass adva media access`** ("Bypass Advanced Access grants for media"; `restrict access: TRUE`).
Roles holding it (or the global `bypass adva access`) skip adva's media grant checks and query
filtering entirely. Both are defined by the parent module — see
[../../../../../1.2.x/agent/permissions/permissions.md](../../../../../1.2.x/agent/permissions/permissions.md).

## Scope

Applies to the **core** Media entity type (Drupal 8.4+) only. The contrib Media Entity project is
not supported out of the box (a patch is referenced in drupal.org issue 2971237).
