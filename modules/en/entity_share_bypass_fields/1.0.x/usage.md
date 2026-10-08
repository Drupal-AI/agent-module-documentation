<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Share Bypass Fields adds an Entity Share Client import processor that removes ("bypasses") missing or explicitly listed fields from incoming synchronized entity data so imports don't fail on unknown fields.
---
When a site pulls content with Entity Share Client, the remote JSON:API payload may contain fields the local entity does not have (schema drift between the source and destination sites), and Entity Share can break while trying to write them. This module's `BypassFieldsProcessor` runs at the `prepare_entity_data` stage (weight -100) and, for each incoming entity, loads the local entity by its UUID, then unsets from the payload any attribute the operator listed in a comma-separated "Bypass fields manually" setting, plus any `field_*` attribute that does not exist as a field on the local entity. Entity Share then imports the trimmed payload. Everything happens per import config on the pulling (client) site; the module ships no routes, permissions, services, hooks, or config of its own — you enable and tune the processor inside an existing Entity Share import config at `/admin/config/services/entity_share/import_config`. Failures (missing entity, non-fieldable entity, duplicate UUID) are logged to the `entity_share_client` channel rather than made fatal.

Typical setup: enable the module, edit an Entity Share import config, enable the "Bypass fields" processor, and optionally list specific field machine names to always drop during sync.
---
- Prevent Entity Share imports from failing when the remote sends unknown fields.
- Automatically drop `field_*` attributes that don't exist on the local entity during sync.
- Manually list specific field machine names to skip on import.
- Reconcile schema drift between a source and destination Drupal site.
- Import a subset of an entity's fields while ignoring the rest.
- Keep a local-only field from being overwritten by dropping its incoming value.
- Enable the processor per Entity Share import config in the Processors section.
- Configure bypassed fields in the processor's settings textarea (comma-separated machine names).
- Run trimming at the `prepare_entity_data` stage (weight -100), before later processors act.
- Load the local entity by UUID to decide which fields exist.
- Log (not fail) when the target entity is missing, duplicated, or not fieldable.
- Migrate content between sites with divergent content models.
- Avoid having to create matching fields on the destination just to satisfy an import.
- Combine with other Entity Share Client import processors in the same pipeline.
- Reduce import errors in staged content-staging workflows.
- Roll out a new field on the source before the destination has it, without breaking sync.
- Deprecate a field on the destination while the source still sends it.
- Sync shared entities across sites that intentionally keep different field sets.
- Skip large or environment-specific fields that should not propagate between sites.
