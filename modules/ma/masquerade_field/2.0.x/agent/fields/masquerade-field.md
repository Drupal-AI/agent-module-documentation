<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `masquerade_as` field, formatter, widget, selection & constraint

## The field
- Base field `masquerade_as` is attached to the **user** entity in
  `MasqueradeFieldHooks::entityBaseFieldInfo()` (`#[Hook('entity_base_field_info')]`).
- Field type `masquerade_field` (`src/Plugin/Field/FieldType/MasqueradeFieldItem.php`) extends core
  `EntityReferenceItem`; `target_type` is fixed to `user`, default field handler is
  `masquerade_field_user`, default formatter `masquerade_field_default`. Cardinality is **unlimited**.
- Constraints: `ExcludeOriginUser`. Not translatable. Display is configurable for both form and view.
- The item **list class** `MasqueradeFieldItemList` overrides `preSave()` to **filter out duplicate
  target ids** before saving.

Because it is a base field (not a configurable field on a bundle), it exists on every user and is not
managed through Field UI storage — it appears on the user form/display by default.

## Widget
- No custom widget. `field_widget_info_alter` (`MasqueradeFieldHooks::fieldWidgetInfoAlter()`) adds
  `masquerade_field` to the `entity_reference_autocomplete` widget's supported field types, and the
  field's default form display uses `entity_reference_autocomplete`.

## Selection handler
- `masquerade_field_user` (`MasqueradeFieldUserSelection`, extends core `UserSelection`).
- Currently it only defers to the parent query. A `@todo` notes that filtering out the *edited* user
  from the autocomplete results is not yet possible (needs core issue 2826826; tracked in
  masquerade_field issue 3107746). Self-masquerade is instead blocked at validation (below), not at
  selection time.

## Formatter — `masquerade_field_default`
`src/Plugin/Field/FieldFormatter/MasqueradeFieldFormatter.php`, extends `EntityReferenceLabelFormatter`.
- `viewElements()` starts from the parent's rendered labels, then:
  - Computes `can_masquerade = (entity is the current user) AND (not currently masquerading)`.
  - For each referenced user element, if `can_masquerade`, replaces `#url` with
    `$target_account->toUrl('masquerade')` — i.e. the core Masquerade switch route, which carries the
    CSRF token. Otherwise the parent's profile link is kept.
  - Sets `#title` to `$target_account->getDisplayName()` (real name rather than the entity label).
- `settingsForm()` / `settingsSummary()` are empty — no formatter options.

Net effect: on your own user profile you see clickable "masquerade as X" links; on someone else's
profile (viewable via `view any masquerade field`) you see the same names but linking to profiles, not
switch links.

## Validation — `ExcludeOriginUser`
- `ExcludeOriginUser` / `ExcludeOriginUserValidator`: if any listed `target_id` equals the account's
  own id, adds a violation ("User %user cannot masquerade as itself."). Skipped for new/empty entities.

## Field access — `hook_entity_field_access`
`MasqueradeFieldHooks::entityFieldAccess()` (applies only to user `masquerade_as`):
- **view**: allowed if `view any masquerade field`, OR the entity is the viewer's own account AND they
  have `view own masquerade field`. Adds `user.permissions` cache context.
- **edit**: allowed if `edit masquerade field`.
- Default is **forbidden** if neither branch allows.

> Note: `edit masquerade field` alone permits editing the field. A user editing **their own** account
> form needs no `administer users`; combined with this field's edit access that means a holder of
> `edit masquerade field` can set their own target list. See `agent/api/masquerade-access.md` for the
> security implication.
