# Paragraphs Usage — agent index

Read-only "where used" report for Paragraphs types. Adds a **Usage** tab/operation to each
`paragraphs_type` listing every entity type / bundle / field that references it. No config
(`configure` null), no own permissions, no Drush, no config schema. Depends on `paragraphs`.

- **Where the report lives, the route, and the access permission** → [configure/usage-report.md](configure/usage-report.md)
- **Call the usage service from code to get references programmatically** → [api/service.md](api/service.md)

Key facts:
- Route `entity.paragraphs_type.paragraphs_usage` at `…/{paragraphs_type}/usage`, permission
  **`administer paragraphs types`** (core Paragraphs permission).
- Service id `paragraphs_usage.paragraphs_usage_service`
  (`\Drupal\paragraphs_usage\Service\ParagraphsUsageService`): `setParagraphType($type)` then
  `getUsedParagraphs()` returns an array of `entity_type` / `bundle` / `field` records.
- Scans every `ContentEntityType` bundle for `entity_reference_revisions` fields whose
  `handler_settings.target_bundles` matches the type; honours the `negate` exclude mode.
- Extra menu links appear under the Admin Toolbar tree only when `admin_toolbar_tools` is enabled.
