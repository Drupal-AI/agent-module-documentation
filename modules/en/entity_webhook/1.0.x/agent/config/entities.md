<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities, routes & permission

Three config-entity types model the setup, each with `AdminHtmlRouteProvider` HTML routes and the
`administer entity_webhook` admin permission. Schema: `config/schema/entity_webhook.schema.yml`.

## webhook_endpoint

`src/Entity/WebhookEndpoint.php`, config prefix `entity_webhook.webhook_endpoint.*`. One receiver
endpoint. `config_export` keys:

- `id`, `label`
- `target_entity_type` (string|null) — Drupal entity type to write, e.g. `node`, `user`.
- `target_entity_bundle` (string|null) — optional bundle filter for created entities.
- `source_types` (string[]) — allowed `webhook_source_type` IDs (`hasSourceType()`,
  `addSourceType()`, `removeSourceType()`).
- `processing_mode` (`async` default | `sync`). `isSync()` returns TRUE only for `sync`.

Links: collection `/admin/config/services/entity-webhook/endpoints`; add/edit/delete under that;
`source_types` tab at `…/endpoints/{webhook_endpoint}/source-types`.

## webhook_source_type

`src/Entity/WebhookSourceType.php`, prefix `entity_webhook.webhook_source_type.*`. Belongs to one
endpoint. `config_export` keys:

- `id`, `label`, `endpoint` (parent endpoint machine name).
- `operation` (`upsert` default | `delete`) — `getOperation()`.
- `verification_plugin` (string) + `verification_config` (map) — the `webhook_verification` plugin
  that authenticates incoming requests. Select one per source type (via `WebhookSourceTypeForm`).
- `payload_processor` (string) + `payload_processor_config` (map) — optional
  `webhook_payload_processor` plugin that splits a batch payload into one payload per record.

Helpers: `getFieldMappings()` loads child mappings as `FieldMapping` value objects (via
`WebhookFieldMapping::toFieldMapping()`); `getIdentifierMappings()` filters those flagged identifier.

## webhook_field_mapping

`src/Entity/WebhookFieldMapping.php`, prefix `entity_webhook.webhook_field_mapping.*`. ID format
`{source_type_id}.{entity_field}`. Belongs to a source type; adds a config dependency on it
(`calculateDependencies()`). `config_export` keys:

- `id`, `label`, `source_type` (parent).
- `entity_field` — target Drupal field machine name.
- `is_identifier` (bool) — mark as a lookup key for upsert/delete matching (multiple = composite key).
- `resolver` (string, default `json_path`) + `resolver_config` (map) — `value_resolver` plugin.
- `mutation_plugin` (string, `''` = none) + `mutation_config` (map) — `field_value_mutation` plugin.

`FieldMapping` (`src/Entity/FieldMapping.php`) is the immutable value object the runtime consumes
(`entityField`, `isIdentifier`, `resolver`/`resolverConfig`, `mutationPlugin`/`mutationConfig`).

## Routes & menu

Admin routes live under `/admin/config/services/entity-webhook/endpoints/…` and require
`_permission: 'administer entity_webhook'` (edit-source-type uses `_entity_access:
webhook_source_type.update`). Menu link `entity_webhook.admin` sits under **Configuration →
Services**. The public POST receiver route (`entity_webhook.receive`) is documented in
[../inbound/pipeline.md](../inbound/pipeline.md).

## Permission

`entity_webhook.permissions.yml`: `administer entity_webhook` — *Administer Entity Webhook*,
`restrict access: true` — gates all endpoint/source-type/field-mapping management.
