<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Abuse (entity_abuse) — agent index

Lets users submit abuse complaints ("reports") against **any content entity**, and gives moderators a
Views queue to review them. Defines an `entity_abuse_report` content entity, a settings form, granular
permissions, a Views field, and a per-entity "Abuse report link" display component.

- Depends on core `user` and `filter`. No composer.json / no third-party libs. License GPL-2.0-or-later.
- Core `^8 || ^9 || ^10 || ^11`. Version-dir **1.1.x** (installed release **1.1.2**).
- Config object `entity_abuse.settings` (route `entity_abuse.settings`, `/admin/structure/entity-abuse`).
- Provides permissions (`entity_abuse.permissions.yml`); provides config schema; no Drush; no plugin types.

## What it provides (from source)

- **Entity** `entity_abuse_report` (`src/Entity/EntityAbuseReport.php`) — base table `entity_abuse_report`,
  owner (`uid`), `created`/`changed`, plus `entity_id` + `entity_type` (the reported target). Custom
  storage schema adds an `entity_id__entity_type` index (`src/EntityAbuseReportStorageSchema.php`).
  Field UI base route is the settings route, so it has Manage fields / form display / display.
- **Service** `entity_abuse.service` (`EntityAbuseService`) — config accessors, `getEnabledEntityTypes()`,
  `getExistingReport()`, and `userDelete()` (account-cancel handling).
- **Lazy builder** `entity_abuse.report_link_lazy_builder` (`EntityAbuseReportLinkLazyBuilder::getLink`)
  — renders the add/edit/cancel/no-access link injected by `hook_entity_view` into enabled entities.
- **Views field** plugin `entity_abuse_report_entity` (`src/Plugin/views/field/EntityAbuseReportEntity.php`,
  registered via `entity_abuse_views_data_alter`) — a link to the reported entity.
- Bundled config: settings + field storage/field + form/view displays + View `entity_abuse_reports`
  (`config/install/`), schema (`config/schema/entity_abuse.schema.yml`), `entity_abuse.config_translation.yml`.

## Solution docs

- Report submission flow — routes, forms, controller, lazy-built link → [flows/submission.md](flows/submission.md)
- Entity, storage, service & Views field → [api/entity-and-service.md](api/entity-and-service.md)
- Settings form, config keys & schema → [config/settings.md](config/settings.md)
- Permissions, access control & admin review queue → [config/permissions-and-review.md](config/permissions-and-review.md)
