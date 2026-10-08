<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Autocomplete Entity ID

Two ways to turn on ID matching: per field (a widget) or globally (a config toggle). Either way a
user only sees ID-based results if they hold `view entity autocomplete id results`
(see [permissions](../permissions/permissions.md)). As of 1.8 the two paths are **mutually
exclusive** — see "Which matcher runs" below.

## Per-field (recommended): the widget

On an entity reference field's **Manage form display** (`admin/structure/.../form-display`), set the
widget to **Autocomplete match ID** (`entity_reference_autocomplete_id`). It extends core's
`entity_reference_autocomplete` widget and shares its settings (match operator, match limit, size,
placeholder). Stored in the `entity_form_display` config entity:

```yaml
# core.entity_form_display.<entity>.<bundle>.<mode>
content:
  <field_name>:
    type: entity_reference_autocomplete_id
    settings: { match_operator: CONTAINS, match_limit: 10, size: 60, placeholder: '' }
```

Set it with Drush:

```php
// drush php:eval
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_ref', ['type' => 'entity_reference_autocomplete_id', 'region' => 'content'])->save();
```

The widget uses the module's own route/matcher (`autocomplete_id.matcher`), which augments results
**only while `autocomplete_id_global` is false** (leave global mode off when using the widget).

## Globally: one config flag

Settings form: **Configuration → Content → Entity Autocomplete id settings**
(`/admin/config/content/autocomplete-id`, route `autocomplete_id.settings`, permission
`administer entity autocomplete id`). The single checkbox writes:

```yaml
# autocomplete_id.settings  (schema: autocomplete_id.schema.yml)
autocomplete_id_global: true   # default false
```

Or set directly: `drush cset autocomplete_id.settings autocomplete_id_global true -y`.

When `true`, `EntityIdAutocompleteMatcherDecorator` (decorates the core
`entity.autocomplete_matcher` service, priority 60) makes **every** core `entity_autocomplete` field
also match by ID — no per-field widget change needed. The decorator's `access()` requires BOTH the
config flag AND the `view entity autocomplete id results` permission.

## Which matcher runs (1.8 access gates)

- `EntityIdAutocompleteMatcher::access()` = `hasPermission('view entity autocomplete id results')`
  **AND `!autocomplete_id_global`** (per-field path, global off).
- `EntityIdAutocompleteMatcherDecorator::access()` = same permission **AND `autocomplete_id_global`**
  (site-wide path, global on).

The two are inverse on the flag, so exactly one path can add an ID suggestion for a given request —
the module never appends the same ID match twice.

## How a match is produced (`EntityIdAutocompleteMatcher::getMatches`)

1. Empty typed string → returns `[]`. Otherwise core's matcher runs first (label matches) unchanged.
2. Access gate: skip the ID match unless `access()` passes (permission + correct global-flag state).
3. Load `entity_storage->load($typed_string)`; the ID suggestion is added only if the entity exists,
   passes `->access('view', $currentUser)`, and (when `target_bundles` is set) its bundle is allowed.
4. The suggestion `Label (id)` is prepended; if `count($matches) == match_limit`, the last label
   match is popped to make room. Label is `Html::escape`d, whitespace-collapsed, and `Tags::encode`d.

## Notes

- The matcher's constructor takes an **optional** `?ConfigFactoryInterface` (falls back to
  `\Drupal::configFactory()`), so a container not yet rebuilt after updating to 1.8 won't fatal.
- Config schema and a permission are provided; there are no other settings, no state, and no tables.
