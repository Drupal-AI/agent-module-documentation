<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Content Augmenter (date_content) — agent index

Associates arbitrary **content with a single value of a date field** through the **Date Augmenter**
API (`drupal/date_augmenter`). It ships a new content entity type, **`date_content`**, whose instances
carry your own fields (a topic, a speaker, a notice, a source document) and are pinned to one delta of
one date field on one host entity via four base fields: `parent_type`, `parent_id`, `field_name`,
`field_delta`. A Date Augmenter plugin (`id = content`) hooks into any compatible date **formatter**:
when the date renders, the plugin looks up the matching `date_content` entity and injects its rendered
output plus context-aware Add / Edit / Remove links (optionally in a modal or off-canvas tray). Because
it works through the augmenter API rather than a bespoke field, several augmenters (e.g. an
"add to calendar" link and an associated note) can decorate the same rendered date without knowing
about each other. Although built with Smart Date in mind, it works with any date field whose formatter
supports Date Augmenter, including core date fields.

`date_content` is a full fieldable, revisionable, translatable entity type with its own bundle config
entity **`date_content_type`** (a starter bundle **`session`** is created on install). Manage bundles at
`/admin/structure/date_content_types`, their fields via Field UI, and list entities at
`/admin/content/date_content`. The augmenter is turned on per date-field formatter (Manage display).

- Depends on: `date_augmenter:date_augmenter`. Core: `^9.5 || ^10 || ^11`. Package: `Date Augmenter`.
  Composer: `drupal/date_augmenter:^1.0`. Optional soft integration: `form_mode_control` (adds a
  form-mode picker to the augmenter settings when installed).
- No module-wide settings page / `configure` route. Configuration is per date-field formatter (the
  augmenter's own settings) and per bundle (Field UI + revision options).
- Provides permissions (static + per-bundle dynamic). Provides config schema. No drush. Defines no
  plugin *types* of its own (it registers one `DateAugmenter` plugin implementation).
- Provides Views integration (entity Views data, a creation wizard, a bulk-form field).

## What you'd do → where

- **Turn the augmenter on for a date field / configure which bundles, dialog target, past-event
  behaviour** → [plugins/date-augmenter.md](plugins/date-augmenter.md)
- **Understand the entity model, base fields, routes, controller and revisions** →
  [api/entities.md](api/entities.md)
- **Which permissions gate creating / editing / deleting content and revisions (and the naming
  caveats that make some code paths fail closed)** → [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Content entity: `date_content` — base_table `date_content`, data_table `date_content_field_data`,
  revision tables `date_content_revision` / `date_content_field_revision`; translatable, revisionable,
  fieldable; entity keys `id`/`vid`/`type`/`parent_type` (label)/`uuid`/`langcode`. Base fields:
  `parent_type`, `parent_id`, `field_name`, `field_delta`, `user_id`, `created`, `changed`, `uuid`
  plus revision-log base fields.
- Bundle (config) entity: `date_content_type` — config_prefix `date_content_type`, config_export
  `label,id,description,help,new_revision,revision_expose,revision_log`. Starter bundle: `session`.
- Custom routes (`date_content.routing.yml`): `date_content.add_form_param`
  (`/date_content/add/{date_content_type}/{parent_type}/{parent_id}/{field_name}/{field_delta}`),
  `date_content.revise` (`/date_content/revise/{date_content}`), `entity.date_content_type.edit_form`,
  `entity.date_content.revision`.
- Entity-provided routes: `entity.date_content.{canonical,add_page,add_form,edit_form,delete_form,
  delete_multiple_form,collection,version_history,revision,revision_revert,revision_delete}`,
  `date_content.revision_revert_translation_confirm`, and `entity.date_content_type.{canonical,add_form,
  edit_form,delete_form,collection}`.
- Controller: `Drupal\date_content\Controller\DateContentController` → `addByParam`, `revise`,
  `revisionShow`, `revisionPageTitle`, `revisionOverview`.
- Access: entity handler `DateContentAccessControlHandler`; revision access service
  `access_check.date_content.revision` (`Access\DateContentRevisionAccessCheck`, tagged
  `applies_to: _access_date_content_revision`).
- Route providers: `DateContentHtmlRouteProvider` (adds history/revision/settings routes),
  `DateContentTypeHtmlRouteProvider`. Storage: `DateContentStorage`. Translation handler:
  `DateContentTranslationHandler`. List builders: `DateContentListBuilder`, `DateContentTypeListBuilder`.
- Date Augmenter plugin: id `content` (`Plugin/DateAugmenter/Content`), config keys `bundles`,
  `past_events`, `target` (`''`/`tray`/`modal`), `width`, `form_mode`.
- Views: `ViewsWizard` ids `date_content` and `date_content_revision`; views field plugin
  `Plugin/views/field/DateContentBulkForm`; views data `Entity\DateContentViewsData`.
- Theme hook `date_content` (template `templates/date-content.html.twig`, `date_content.page.inc`),
  suggestions `date_content__<view_mode>|<bundle>|<id>…`. Library `date_content/date_content` (CSS only).
- Config schema key: `date_content.date_content_type.*`.
