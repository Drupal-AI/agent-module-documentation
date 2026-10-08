<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `alert_message` entity: fields, scheduling, targeting, permissions

There is **no meaningful global settings form**. `entity.alert_message.settings`
(`admin/structure/alert-message`, `AlertMessageSettingsForm`) renders one line of markup ("Only one
bundle is available… you may want to configure the fields though") and a submit that flashes a status
message. It exists mainly to be the `field_ui_base_route`, so *Manage fields / form display / display*
tabs hang off it. Author real alerts from the **collection**, `/admin/content/alert-message` →
*Add alert message*.

## Entity definition

`src/Entity/AlertMessage.php`, a `#[ContentEntityType]` (id `alert_message`). Translatable;
`base_table` `alert_message`, `data_table` `alert_message_field_data`;
`admin_permission: administer alert message`. Handlers of note:

- `access` = `Drupal\entity\EntityAccessControlHandler`, `permission_provider` =
  `Drupal\entity\EntityPermissionProvider`, `query_access` = the Entity API query-access handler.
- `route_provider` = Entity API `AdminHtmlRouteProvider` + `DeleteMultipleRouteProvider` (this is what
  actually creates the add/edit/delete/collection routes — the module's own `.routing.yml` only
  declares the settings form).
- `form.add`/`edit` = `AlertMessageForm` (a thin `ContentEntityForm` that redirects to the canonical
  page after save); `form.delete` = core `ContentEntityDeleteForm`.
- `list_builder` = `AlertMessageListBuilder` (table with id/label/status/author/users/roles/dates + a
  total count).

## Base fields (`baseFieldDefinitions`)

| Field | Type | Notes |
|---|---|---|
| `label` | string (255), required, translatable | form weight -5; the entity label |
| `message` | `text_long`, required, translatable | widget `text_textarea`; rendered with `text_default` (i.e. filtered through the chosen **text format**) |
| `users` | entity_reference → `user`, unlimited | widget `entity_reference_autocomplete_tags`. Empty = all users |
| `roles` | entity_reference → `user_role`, unlimited | widget `options_select`. Empty = all roles |
| `publish_date` | datetime (`datetime` type), **required** | default `now`; form-configurable off |
| `unpublish_date` | datetime, **required** | default `+2 day`; form-configurable off |
| `to_publish` | boolean | default FALSE; module-managed, not a user control |
| `status` | boolean (published key) | default FALSE; module-managed; on_label "Enabled" |
| `uid` | entity_reference → user | author/owner (`EntityOwnerTrait`) |
| `created` / `changed` | created / changed | timestamps |

> The `users` field description in source ("Enter a comma-separated list. For example: Amsterdam,
> Mexico City…") is a copy-paste leftover from the Drupal example entity — it references a user
> autocomplete, not cities.

## Scheduling (the important behaviour)

**You do not toggle `status` manually.** On every save, `AlertMessage::preSave()`:

1. Defaults an empty owner to uid 0.
2. **Resets** both `status = FALSE` and `to_publish = FALSE`.
3. Compares the publish/unpublish window against `\Drupal::time()->getRequestTime()`:
   - `publish_date > now` → `to_publish = TRUE` (waiting) and returns.
   - `publish_date <= now <= unpublish_date` → `status = TRUE` (live).
   - otherwise (window already past) → both stay FALSE (never shown).

`alert_message_cron()` (`hook_cron`) then re-evaluates waiting/live alerts: it queries with an **OR**
group for `to_publish = TRUE` OR `status = TRUE` and `save()`s each match, which re-runs `preSave()` and
flips a waiting alert live once its start time has passed (and flips a live alert off once its window
closes). **Consequence: scheduling resolution equals your cron interval.** For an emergency, set
`publish_date` to now/the past so the first save makes it live immediately; do not rely on cron.

### Validation constraint

`AlertMessagePublishDates` (`Plugin/Validation/Constraint/AlertMessagePublishDatesConstraint` +
`…Validator`) adds two violations: unpublish date `<= now` ("in the past"), and unpublish date `<=`
publish date ("earlier than the publishing one"). So every alert must have a future unpublish date that
is after its publish date.

## Targeting

Purely a **display filter** applied in the lazy builder (see [../blocks/block.md](../blocks/block.md)),
not an access control:

- Empty `roles` **and** empty `users` → shown to everyone.
- Non-empty `roles` → shown only if the current user has at least one of them
  (`array_intersect(getTargetedRoleIds(), currentUser->getRoles())`).
- Non-empty `users` → shown only if the current uid is in the list.

## Permissions

Static (`alert_message.permissions.yml`): **`administer alert message`** (`restrict access: true`) —
gates the settings route and is the entity `admin_permission`.

Dynamic, from `EntityPermissionProvider` (verified at runtime): `access alert_message overview`,
`view alert_message`, `view own unpublished alert_message`, `create alert_message`,
`update own alert_message`, `update any alert_message`, `delete own alert_message`,
`delete any alert_message`. Field UI adds `administer alert_message fields` / `form display` /
`display`. Grant `create`/`update`/`delete` to let a non-admin role author alerts.

## Account-lifecycle hooks (`alert_message.module`)

- `hook_user_cancel`: `user_cancel_block_unpublish` sets `status = FALSE` on the account's alerts;
  `user_cancel_reassign` sets their owner to uid 0.
- `hook_ENTITY_TYPE_predelete` (`alert_message_user_predelete`): deletes all alerts authored by a user
  being deleted.
