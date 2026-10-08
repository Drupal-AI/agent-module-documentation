# Entity model, routes & revisions

The module defines two entity types plus the controller and access wiring that support them.

## `date_content` — the content entity

`src/Entity/DateContent.php`, `@ContentEntityType(id = "date_content")`.

- Tables: base `date_content`, data `date_content_field_data`, revision `date_content_revision`,
  revision-data `date_content_field_revision`.
- Flags: `translatable = TRUE`, revisionable (revision-log trait), `fieldable = TRUE`,
  `common_reference_target = TRUE`, `permission_granularity = "bundle"`,
  `bundle_entity_type = "date_content_type"`, `field_ui_base_route = "entity.date_content_type.edit_form"`.
- Entity keys: `id` = `id`, `revision` = `vid`, `bundle` = `type`, **`label` = `parent_type`**,
  `uuid` = `uuid`, `langcode` = `langcode`. (`label()` is overridden to render as
  "`<bundle>` for `<parent label>` at `<rendered date>`".)
- Revision metadata keys: `revision_user` = `revision_uid`, `revision_created` = `revision_timestamp`,
  `revision_log_message` = `revision_log`.
- Handlers: storage `DateContentStorage`, view_builder core `EntityViewBuilder`, list_builder
  `DateContentListBuilder`, views_data `Entity\DateContentViewsData`, translation
  `DateContentTranslationHandler`, forms `DateContentForm` (default/add/edit) + `DateContentDeleteForm`
  + core `DeleteMultipleForm`, route_provider `DateContentHtmlRouteProvider`, access
  `DateContentAccessControlHandler`.

### Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `parent_type` | string (ascii, ID length) | Required. Host entity type id. Used as entity label key. |
| `parent_id` | entity_reference | Required. Host entity id (stored as `target_id`). |
| `field_name` | string (ascii) | The date field on the host that the content is pinned to. |
| `field_delta` | integer | The specific delta of that multi-value/recurring date field. |
| `user_id` | entity_reference → user | Author; revisionable, translatable; defaults to current user on create, anonymous on save if unset. |
| `created` / `changed` | created / changed | Timestamps. |
| `uuid` | uuid | Read-only. |

Plus revision-log base fields via `revisionLogBaseFieldDefinitions()`. `postSave()` invalidates the
host's cache tag (`<parent_type>:<parent_id>`) so the host re-renders the augmented output.

> Note (`field_delta`): a `->setSetting('max_length', …)` is applied to an `integer` field (copy-paste
> from the string fields); harmless but meaningless for integers.

## `date_content_type` — the bundle (config) entity

`src/Entity/DateContentType.php`, `@ConfigEntityType(id = "date_content_type")`,
`config_prefix = "date_content_type"`, `bundle_of = "date_content"`,
`admin_permission = "administer site configuration"`.

- config_export / schema keys (`config/schema/date_content_type.schema.yml`, key
  `date_content.date_content_type.*`): `label`, `id`, `description`, `help`, `new_revision` (default
  TRUE), `revision_expose` (default FALSE), `revision_log` (default FALSE), `uuid`.
- Behaviour helpers: `shouldCreateNewRevision()`, `shouldShowRevisionToggle()`, `shouldShowRevisionLog()`
  drive whether `DateContentForm` exposes the revision checkbox / log field.
- Starter bundle **`session`** ships in `config/optional/date_content.date_content_type.session.yml`,
  with two example fields `field_topic` and `field_speaker` and matching form/view displays (also in
  `config/optional/`, installed only if the field module and dependencies are present).

## Routes

Custom (`date_content.routing.yml`):

| Route | Path | Access |
|---|---|---|
| `date_content.add_form_param` | `/date_content/add/{date_content_type}/{parent_type}/{parent_id}/{field_name}/{field_delta}` | `_permission: add date content entities+administer date content entities` |
| `date_content.revise` | `/date_content/revise/{date_content}` | `_permission: edit date content entities+administer date content entities` |
| `entity.date_content_type.edit_form` | `/admin/structure/date_content_types/{date_content_type}/edit` | `_permission: administer site configuration` |
| `entity.date_content.revision` | `/date_content/{date_content}/revisions/{date_content_revision}/view` | `_access_DateContent_revision: view` |

Entity-provided (route providers): `entity.date_content.{canonical,add_page,add_form,edit_form,
delete_form,delete_multiple_form,collection,version_history,revision,revision_revert,revision_delete}`,
`date_content.revision_revert_translation_confirm`, and the full `entity.date_content_type.*` set. The
collection lives at `/admin/content/date_content`; the bundle collection at
`/admin/structure/date_content_types`.

`DateContentHtmlRouteProvider` additionally builds the version-history, revision, revert, delete and
translation-revert routes with `_permission` requirements referring to the `date_content` (underscore)
permission spellings — see [permissions/permissions.md](../permissions/permissions.md) for why those
differ from the spellings actually defined.

## Controller — `DateContentController`

- `addByParam($date_content_type,$parent_type,$parent_id,$field_name,$field_delta)` — static; creates a
  prefilled entity and returns its `default` add form.
- `revise(DateContentInterface $date_content)` — static; returns the `default` edit form.
- `revisionShow($date_content_revision)` / `revisionPageTitle(...)` — load a revision by vid and render
  it / build its title.
- `revisionOverview(DateContentInterface $date_content)` — builds the revisions table (used by the
  provider's `version-history` route).

## Access

- `DateContentAccessControlHandler::checkAccess()` — **`view` ⇒ `AccessResult::allowed()`
  unconditionally**; `update`/`delete` ⇒ own-permission check then
  `edit`/`delete date content entities`. `checkCreateAccess()` ⇒
  `allowedIfHasPermission('add date_content entities')`.
- `Access\DateContentRevisionAccessCheck` (service `access_check.date_content.revision`, tag
  `applies_to: _access_date_content_revision`) maps view/update/delete to
  `view/revert/delete all revisions` (and per-bundle `… <bundle> revisions`) permissions.
- Runtime note: the `date_content` base tables are not present in the current environment (the module
  is listed but its entity schema is not installed), so entity CRUD could not be exercised live; the
  access-handler logic above is confirmed via the access control handler at runtime.
