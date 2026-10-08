<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `argument` content entity

Source: `src/Entity/Argument.php` (`@ContentEntityType id = "argument"`),
`src/Entity/ArgumentInterface.php`, access in `src/ArgumentAccessControlHandler.php`,
routes in `src/ArgumentHtmlRouteProvider.php`, revision UI in
`src/Controller/ArgumentController.php` and `src/Form/Argument*Form.php`.

## Entity definition

- Base table `argument`; data table `argument_field_data`; revision tables `argument_revision`
  / `argument_field_revision`. `translatable = TRUE`, `show_revision_ui = TRUE`.
- `admin_permission = "administer argument entities"`. Storage handler `ArgumentStorage`,
  list builder `ArgumentListBuilder`, views data `ArgumentViewsData`, translation handler
  `ArgumentTranslationHandler`.
- `field_ui_base_route = "argument.settings"` — Field UI (Manage fields / form / display) hangs
  off the settings route. Entity has **no bundles**.
- `preCreate()` seeds `user_id` = current user and `reference_id` = the `{reference_id}` route
  attribute (the parent node id from the add-form URL).
- `preSave()` defaults an unset owner to anonymous (uid 0) and the revision author to the owner.

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|-------|------|-------|
| `type` | list_integer, required | allowed `1 => PRO`, `2 => CONTRA`; default PRO. `getTypeStr()` → `pro`/`contra`. |
| `name` | string | title, max_length 80, no text processing. |
| `argument` | string_long | body, `text_processing => TRUE`; view formatter is plain `string` (escaped). |
| `reference_id` | entity_reference → `node` | the parent node the argument refers to. |
| `user_id` | entity_reference → `user` | author; default callback `\Drupal::currentUser`. |
| `status` | boolean | published flag, default TRUE. |
| `created` / `changed` | created/changed | timestamps. |
| `revision_translation_affected` | boolean | read-only revision bookkeeping. |

## Permissions (`arguments.permissions.yml`)

`add argument entities`, `edit argument entities`, `delete argument entities`,
`view published argument entities`, `view unpublished argument entities`,
`access argument overview`, `administer argument entities` (restricted),
`allow to omit creation of new argument revisions`, `view all argument revisions`,
`revert all argument revisions`, `delete all argument revisions`.

## Access mapping (`ArgumentAccessControlHandler::checkAccess`)

- `view`: published → `view published argument entities`; unpublished → `view unpublished argument entities`.
- `update` → `edit argument entities`. `delete` → `delete argument entities`.
- create (`checkCreateAccess`) → `add argument entities`.
- Everything is permission-gated via `AccessResult::allowedIfHasPermission`; no `_access: TRUE`,
  no owner/token bypass, unknown ops return neutral.

## Routes / links

Link templates (from the annotation): `canonical /argument/{argument}`,
`add-form /argument/add/{reference_id}`, `edit-form /argument/{argument}/edit`,
`delete-form /argument/{argument}/delete`, `collection /admin/structure/argument/list`, and
revision routes under `/admin/structure/argument/{argument}/revisions/...`.

`ArgumentHtmlRouteProvider` adds the revision + settings routes. Note its revision **view/history**
routes require the permission string `access argument revisions`, which is **not declared** in
`arguments.permissions.yml` (only super-admin passes) — a functionality quirk, fails closed.
Revision **revert/delete** routes require `revert all argument revisions` /
`delete all argument revisions`; settings route requires `administer argument entities`.

## Revisions

- `ArgumentController::revisionOverview()` builds the revision table; revert/delete links appear
  per `revert all argument revisions` / `delete all argument revisions` (or admin). Revision log
  messages are rendered with `#allowed_tags => Xss::getHtmlTagList()` (filtered).
- `ArgumentForm::save()` creates a new revision unless the "revision" checkbox is unchecked; the
  checkbox is forced on when `arguments.revisions_default` is set and the user lacks
  `allow to omit creation of new argument revisions`.
- Revert/delete confirm forms: `ArgumentRevisionRevertForm`, `ArgumentRevisionRevertTranslationForm`,
  `ArgumentRevisionDeleteForm` (standard Drupal confirm forms → CSRF-protected).
