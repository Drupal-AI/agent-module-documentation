<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js (next) — agent index

Connects Drupal to Next.js front ends: authenticated **preview/draft** URLs, an in-Drupal **iframe
live preview**, and **on-demand revalidation (ISR)**. Config UI at *Configuration → Web services →
Next.js* (`configure: entity.next_site.collection`, `/admin/config/services/next`). Depends on
`decoupled_router`, `simple_oauth`, `subrequests`, `pathauto`.

- **Config entities & settings** — `next_site`, `next_entity_type_config`, `next.settings` →
  [configure/sites-and-settings.md](configure/sites-and-settings.md)
- **The four plugin types** (site_resolver, site_previewer, preview_url_generator, revalidator),
  their built-in plugins, and how to add one → [plugins/plugin-types.md](plugins/plugin-types.md)
- **Services, entity API, events, routes** (NextSettingsManager, NextEntityTypeManager, NextSite,
  EntityActionEvent/EntityRevalidatedEvent, PreviewSecretGenerator) →
  [api/services-and-events.md](api/services-and-events.md)
- **`hook_next_site_preview_alter`** (alter the editor preview) →
  [hooks/preview-alter.md](hooks/preview-alter.md)

Key facts:
- Two config entity types: `next_site` (id, label, base_url, preview_url, preview_secret,
  revalidate_url, revalidate_secret) and `next_entity_type_config` (id = `entity_type.bundle`,
  site_resolver, configuration, draft_enabled, revalidator, revalidator_configuration).
- `next.settings`: `site_previewer` (default `iframe`), `preview_url_generator` (default
  `simple_oauth`), `debug`, plus the selected plugins' `*_configuration`.
- Plugin type ids: `site_resolver` (`site_selector`, `entity_reference_field`), `site_previewer`
  (`iframe`), `preview_url_generator` (`simple_oauth`; `jwt` in next_jwt), `revalidator` (`path`,
  `cache_tag`).
- On entity insert/update/delete, `next.module` dispatches `EntityActionEvent`; the revalidate
  subscriber runs the entity type's revalidator.
- Submodules: `next_jsonapi`, `next_graphql`, `next_jwt`, `next_extras` (each nested under this dir).
