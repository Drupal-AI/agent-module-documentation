<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, hooks, forms & install

No `event.services.yml` — the module registers no container services. Handlers are wired through
the entity annotation instead.

## Storage — `EventStorage`

`Drupal\event\EventStorage` (extends `SqlContentEntityStorage`, implements `EventStorageInterface`).
Adds revision helpers, all using parameterised `db->query()` / query-builder calls (no string
concatenation of user input):
- `revisionIds(EventInterface)` — vids for one event (`{event_revision}`).
- `userRevisionIds(AccountInterface)` — vids authored by a user (`{event_field_revision}`).
- `countDefaultLanguageRevisions(EventInterface)`.
- `clearRevisionsLanguage(LanguageInterface)` — resets langcode on `{event_revision}`.

## Controller — `EventController`

`Drupal\event\Controller\EventController` (DI: `renderer`, `date.formatter`, `event` storage,
`event` view builder). Serves the revision routes:
- `revisionShow($event_revision)` — renders a loaded revision via the view builder.
- `revisionPageTitle($event_revision)` — title for a revision.
- `revisionOverview(EventInterface $event)` — builds the revisions table; per-row Revert/Delete
  operation links are only added when the current user has `revert all event revisions` /
  `delete all event revisions` (or `administer event entities`). Revision log messages are rendered
  with `#allowed_tags => Xss::getHtmlTagList()` (filtered).

## Forms

- `EventForm` (content entity form): adds a "Create new revision" checkbox (existing entities) and a
  publish checkbox; `save()` sets a new revision + revision author when requested, applies the
  publish flag, and redirects to `entity.event.canonical`.
- `EventDeleteForm`, `EventRevisionDeleteForm`, `EventRevisionRevertForm`,
  `EventRevisionRevertTranslationForm` — standard confirm forms.
- `EventTypeForm` — label + machine name (`EventType::load` uniqueness); on new-type save calls
  `event_add_description_field()`. `EventTypeDeleteForm` — bundle delete confirm.
- `EventSettingsForm` — placeholder `FormBase` printing static markup; no route is generated for it
  (see routes doc).

## Hooks & theming (`event.module`, `event.page.inc`)

- `hook_help()` — help text on `help.page.event`.
- `hook_theme()` — registers `event` (template `event.html.twig`, preprocess in `event.page.inc`)
  and `event_content_add_list`.
- `hook_theme_suggestions_event()` — adds suggestions by view mode, bundle, and entity id.
- `event_add_description_field(EventTypeInterface $type, $label = 'Description')` — attaches the
  `description` field (from `field.storage.event.description`) to a bundle and configures its
  form/view display; called on new event-type creation and from `event_update_8102()`.
- `template_preprocess_event()` — exposes children as `content` for the template.

Templates: `templates/event.html.twig` renders `{{ content }}` (field output, already sanitized by
the field render pipeline); `templates/event-content-add-list.html.twig` lists bundles on
`/event/add`.

## Plugin — menu-links deriver

`Drupal\event\Plugin\Derivative\MenuLinks` (referenced by `event.menu_links` in
`event.links.menu.yml`) generates admin-toolbar links only when `admin_toolbar` is installed;
otherwise it returns none.

## Install / update history (`event.install`)

- `event_update_dependencies()` — orders `event_update_8103()` after `content_translation` 8400.
- `event_update_8101()` — renames legacy `event.event_type.*` config to `event.type.*`.
- `event_update_8102()` — replaces old `event_start`/`event_end` fields with the single
  `event_date` daterange, installs `machine_name` and `description` fields, migrating existing data
  via parameterised `db->select`/`db->update`.
- `event_update_8103()` — converts the entity to publishable + revisionable (adds `status`,
  `revision_created`, `revision_user`, `revision_log_message`), migrating from
  `content_translation_status` when present.

`event.post_update.php` — `event_post_update_add_event_admin_view()` creates the `events_admin`
view from `config/optional` on existing sites (when Views is enabled and the view is absent). No
Drush commands are provided by this module.
