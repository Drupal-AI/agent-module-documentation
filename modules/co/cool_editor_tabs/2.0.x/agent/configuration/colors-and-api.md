<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cool Editor Tabs — colours, icons & developer API

## Colour settings

- **Route:** `/admin/config/user-interface/cool-editor-tabs` (menu: Configuration → User interface).
- **Permission:** `administer site configuration`.
- **Config object:** `cool_editor_tabs.settings` (schema in `config/schema/cool_editor_tabs.schema.yml`).
- **Form:** `Drupal\cool_editor_tabs\Form\CoolEditorTabsSettingsForm` — five `#type => color` inputs
  grouped into "Toggle button", "Tab buttons", "Icons", plus a **Reset to defaults** submit
  (`::resetDefaults`).

| Config key           | Default     | Applied as CSS custom property        |
|----------------------|-------------|---------------------------------------|
| `toggle_color`       | `#0550e6`   | `--cool-tabs-toggle-color`            |
| `toggle_color_hover` | `#080090`   | `--cool-tabs-toggle-color-hover`      |
| `tab_color`          | `#666666`   | `--cool-tabs-color`                   |
| `tab_color_hover`    | `#333333`   | `--cool-tabs-color-hover`             |
| `icon_color`         | `#ffffff`   | `--cool-tabs-icon-color`              |

At render time (`hook_page_attachments`) each stored value must match
`/^#[0-9a-fA-F]{3}([0-9a-fA-F]{3})?$/`; values that fail are omitted from the emitted
`:root { ... }` inline style. The output carries the cache tag `config:cool_editor_tabs.settings`.

The settings form loads `assets/src/js/admin-settings.js`, a **client-side WCAG 2.1 non-text
contrast** checker (target 3:1; AAA at 4.5:1) that compares the icon colour against every button
background live as you pick colours. It is advisory UI only — it does not block saving.

## Route → icon resolution

`_cool_editor_tabs_get_icon(string $route_name)` maps a local task's route name to a built-in icon
(all icons are Heroicons v2 SVGs in `assets/src/icons/`). Matching order:

- Suffix: `*.edit_form`→`edit`, `*.delete_form`/`*.delete_multiple_form`→`delete`,
  `*.version_history`/`*.revision_overview`→`revisions`, `*.path`→`path`.
- Substring: `translation`→`translate`, `devel`→`devel`, `layout_builder`→`layout`, `clone`→`clone`,
  `manage_display`→`view`, `revisions`→`revisions`.
- Contrib: `metatag`, `webform`, `scheduler`, `sitemap`, `moderation` (and `latest_version`→`moderation`),
  `redirect`, `rabbit_hole`→`rabbit-hole`.
- No match → NULL → first-letter fallback (`<span class="admin-tabs__initial">`, HTML-escaped).

A small accesskey map is also applied: `edit`→b, `translate`→v, `devel`→d, `delete`→x.

## Icon pack (Icon API)

`cool_editor_tabs.icons.yml` registers an icon pack `cool_editor_tabs` (extractor `svg`, template
`cool-editor-tabs-icon`, sources `assets/src/icons/{icon_id}.svg`). Available to other modules through
Drupal core's Icon API.

## Developer hook

```php
/**
 * @see cool_editor_tabs.api.php
 */
function hook_cool_editor_tabs_icon_alter(?string &$icon_id, string &$pack_id, string $route_name): void {
  // Map one of your module's routes to a built-in icon:
  if ($route_name === 'mymodule.my_custom_route') {
    $icon_id = 'edit';
  }
  // Or use an icon from your own registered pack:
  if ($route_name === 'mymodule.workflow_route') {
    $icon_id = 'workflow';
    $pack_id = 'mymodule'; // looks in mymodule/assets/icons/workflow.svg, then falls back.
  }
}
```

`_cool_editor_tabs_load_icon()` tries `{pack_module}/assets/icons/{icon_id}.svg` (when `pack_id` is a
different, existing module) then always falls back to
`cool_editor_tabs/assets/src/icons/{icon_id}.svg`. `icon_id` is sanitized to `[a-z0-9-]` before the
lookup.

## Scope of effect

The restyled tab **markup** appears only where `_enable_cool_editor_tabs()` is TRUE: authenticated
user, **not** an admin route, and holding `use cool editor tabs`. On admin routes the normal Drupal
local tasks render (the floating toggle CSS/JS library may still be attached wherever the permission
holds, per `hook_page_attachments`). Anonymous users get nothing.
