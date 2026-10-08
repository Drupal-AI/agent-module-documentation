<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Advanced Access

## Settings form
- **Route:** `adva.settings` → `/admin/config/people/adva`. Permission `administer adva`
  (restricted). Form `Drupal\adva\Form\SettingsForm` (a `ConfigFormBase`, editable config
  `adva.settings`).
- For every **Access Consumer** (one per adva-enabled entity type) the form shows a fieldset
  with an "Enabled Types" checkbox list of the **Access Providers** available for that entity
  type. Checking a provider reveals its config subform (`provider->buildConfigForm`).
- Two submit buttons: **Save** (persists provider selection/config, clears + requeues records),
  and **Save and Update Access Records** (also runs `triggerBatch` → rebuild all override
  consumers immediately via `adva.batch.consumer_access_rebuild`).
- A "Provider Details" fieldset lists each provider's helper message
  (`Provider::getHelperMessage`).

Consumer configuration is stored as `adva.access_consumer.<id>` config entities
(`Drupal\adva\Entity\AccessConsumer`), exported fields: `id`, `label`, `settings`, `providers`
(enabled provider ids), `provider_config` (per-provider config keyed by provider id). Schema:
`adva.access_consumer.*` and `adva.access_provider.*` (see `config/schema/`).

## Rebuild flow
- Saving provider config calls the consumer's `onChange()`. For an **overriding** consumer this
  `queue()`s a rebuild: it clears `adva_access` for the entity type (re-adding the default
  grant), deletes the old queue, and enqueues every entity id into
  `adva_rebuild_access_records:<entity_type>` for the `RebuildAccessRecordsQueueWorker` to
  process on cron. For the **node** basic consumer, `onChange()` additionally calls
  `node_access_needs_rebuild(TRUE)`.
- **Immediate rebuild:** `/admin/config/people/adva/rebuild/{consumer}` (route
  `adva.access_rebuild`, form `RebuildPermissionsForm`, permission `administer adva`) or the
  "Save and Update Access Records" button run the batch now.
- The status report (`hook_requirements`) shows a per-entity-type count of grants in use and a
  "Rebuild Required" warning when the queue is non-empty.

## Programmatic / drush
There is no dedicated Drush command. Consumer entities are normal config:
```
ddev drush cget adva.access_consumer.media
ddev drush cset adva.access_consumer.media providers.0 anonymous -y   # then rebuild
```
Prefer the UI (it validates providers and queues the rebuild). After any manual config change,
rebuild records (batch or queue) so `adva_access` matches the new config.
