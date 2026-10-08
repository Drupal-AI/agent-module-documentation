<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Section & region component limits

## Install & enable

```bash
composer require drupal/layout_builder_limit
drush en layout_builder_limit -y
```

Only dependency is core **`layout_builder`**. No submodules, no Drush, no install hook, no
standalone settings page.

## Permissions

`layout_builder_limit.permissions.yml` defines two:

| Permission | Grants |
|---|---|
| `manage layout builder limit settings on default` | Set limits on a **default** (template) layout display. |
| `manage layout builder limit settings on overrides` | Set limits on a **per-entity override** layout. |

`FormAlter::configureSectionFormAlter()` decides which applies from the section storage: if the
storage is an `OverridesSectionStorageInterface`, the *overrides* permission is required, else the
*default* permission. If the user lacks the relevant permission the "Limit settings" fields are
**not added and the save handler is never attached** — so a user without the permission cannot
set or change limits (they still need core Layout Builder access to reach the section form at all).

## Where limits are configured

There is **no admin page** (`configure` = null). Limits live on the section-configuration tray:
open Layout Builder, edit/configure a section, and use the **"Limit settings"** details element.

- **Limit by** (`scope`) select: **None** (`disabled`), **Region** (`region`), **Section**
  (`section`). Changing it triggers an AJAX rebuild (`updateScopeSettingsAjax`) that swaps in the
  matching min/max fields.
- For **Section** scope: one fieldset with *Enable Minimum / Minimum / Enable Maximum / Maximum*.
- For **Region** scope: one such fieldset **per region** of the section's layout
  (`$section->getLayout()->getPluginDefinition()->getRegions()`).

Field behavior (`FormAlter::attachSettingsForm()`): `minimum`/`maximum` are `#type => number`,
`#min => 1`, shown only when their `_enabled` checkbox is ticked (`#states`, via
`processSettingsForm`). `validateSettingsForm()` errors if an enabled min/max is empty, or if
`maximum < minimum`.

## How it is stored (third-party setting + schema)

On submit, `FormAlter::submitConfigureSectionForm()` (prepended to the section form `#submit`)
normalizes the values through `LayoutBuilderLimit::getDefaultConfiguration()` and calls:

```php
$section->setThirdPartySetting('layout_builder_limit', 'limit', $settings);
```

Schema (`config/schema/layout_builder_limit.schema.yml`) — the third-party setting
`layout_builder.section.third_party.layout_builder_limit.limit`, typed by scope:

- `scope: disabled` → just `{ scope }`.
- `scope: section` → `{ scope, settings: { region: <scope_settings> } }` (note: for section scope
  the single settings block is stored under the `settings.section` key at runtime;
  `getDefaultConfiguration()` writes `settings[section]`).
- `scope: region` → `{ scope, settings: <sequence of scope_settings, one per region> }`.

`layout_builder_limit.scope_settings` mapping = `minimum_enabled` (bool), `minimum` (int),
`maximum_enabled` (bool), `maximum` (int). Defaults come from
`LayoutBuilderLimit::DEFAULT_SCOPE_CONFIGURATION` (`minimum_enabled=false, minimum=1,
maximum_enabled=false, maximum=1`) and `DEFAULT_CONFIGURATION` (`scope=disabled`).

Example (region scope, "content" region requires ≥1 and caps at 3):

```yaml
third_party_settings:
  layout_builder_limit:
    limit:
      scope: region
      settings:
        region:
          content:
            minimum_enabled: true
            minimum: 1
            maximum_enabled: true
            maximum: 3
```

## How the limit is enforced

Three hooks in `layout_builder_limit.module`, each delegating via `class_resolver`:

1. **Plugin filter** — `hook_plugin_filter_block__layout_builder_alter` →
   `PluginFilterAlter::blockLayoutBuilderPluginFilterAlter()`. When the target region (region
   scope) or the whole section (section scope) already has `>= maximum` components and a maximum is
   enabled, it sets `$definitions = []` so the block chooser offers nothing to add.

2. **Pre-render messaging + link removal** — `hook_element_info_alter` →
   `ElementInfoAlter::elementInfoAlter()` adds `#pre_render => preRender()` to the `layout_builder`
   element. `preRender()` walks each section; for regions/sections that are **under minimum** it
   injects a `status_messages` **warning**, for those **over maximum** an **error**, and once a
   region/section is at `>= maximum` it `unset()`s the `layout_builder_add_block` link. (Comment in
   source notes "move into" isn't yet restricted.) `ElementInfoAlter` implements
   `TrustedCallbackInterface` and lists `preRender` in `trustedCallbacks()`.

3. **Server-side validation on save** — the same hook adds
   `#element_validate => validateLayoutBuilderElement()`. On the Layout Builder **Save**, it
   re-reads every section's `limit` third-party setting and, for enabled min/max, compares
   `count($section->getComponentsByRegion($region))` (region scope) or
   `count($section->getComponents())` (section scope) and calls `$form_state->setError()` if a
   region/section is **under its minimum or over its maximum**. This makes the limit a real
   save-time constraint: a layout that violates the configured min/max **cannot be persisted**,
   independent of the UI hiding in (1) and (2).

## Notes

- Messages/validation use `formatPlural` with escaped placeholders (`@minimum`, `@maximum`,
  `@region`); the region label comes from the layout plugin definition, not user input.
- `preRender()` maps section index → render-element key with a small offset table (`$i==0 → 1`,
  `$i==1 → 3`, then `+2`) to account for the "Add section" links between rendered sections; a
  source comment flags this as fragile and worth revisiting.
- Scope `None`/`disabled` short-circuits all enforcement for that section.
