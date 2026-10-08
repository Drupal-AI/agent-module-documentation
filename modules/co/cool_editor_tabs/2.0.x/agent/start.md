<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cool Editor Tabs (cool_editor_tabs) — agent index

Restyles Drupal's **local task tabs** (View / Edit / Translate / Delete / Revisions) into a
**floating, icon-based pop-up menu** for authenticated editors. A gear toggle is fixed to the
bottom-right of the viewport; clicking it fans the tabs out as circular SVG icon buttons.
Version **2.0.0**, core **`^11.1`**. It is a maintained fork of the abandoned `better_admin_tabs`.

## What it actually is (not a CKEditor plugin)

Despite the name, this has **nothing to do with CKEditor 5** or text-format filters. "Editor tabs"
means the **local tasks** an *editor* (user) clicks. There is no widget stored in body markup, no
`@Filter`, no CKEditor5 plugin. It is a theming/administration module built from hooks + Twig
overrides + an Icon API pack.

## Mechanism (all in `cool_editor_tabs.module`)

- **`hook_page_attachments()`** — for any authenticated user with `use cool editor tabs`, attaches
  the `cool_editor_tabs/admin_tabs` library (CSS + toggle JS) and injects the 5 configured colours
  as `:root` CSS custom properties inside an inline `<style>` tag. Each colour is validated against
  `/^#[0-9a-fA-F]{3}([0-9a-fA-F]{3})?$/` first, so non-hex values are dropped (CSS-injection guard).
- **Theme suggestions + `hook_preprocess_menu_local_task()`** — only when `_enable_cool_editor_tabs()`
  is TRUE, i.e. **authenticated AND NOT an admin route AND has the permission**. Swaps in the
  `menu_local_tasks__better` / `menu_local_task__better` / `menu_local_action__better` templates and
  replaces each non-active tab title with an inline SVG icon (Heroicons v2) resolved from the tab's
  **route name** by `_cool_editor_tabs_get_icon()`; unmatched tabs fall back to the title's first
  letter (escaped). Icons load from disk via `_cool_editor_tabs_load_icon()` — `icon_id` is sanitized
  to `[a-z0-9-]` (path-traversal guard) and output with `Markup::create()`.
- **JS** — `assets/src/js/cool_editor_tabs.js` toggles `aria-expanded` on the list via `core/once`.

## Configuration & extension

- Settings form: `/admin/config/user-interface/cool-editor-tabs`
  (`administer site configuration`). Five `#type => color` fields (toggle, toggle-hover, tab,
  tab-hover, icon) + a "Reset to defaults" submit. Live client-side WCAG 2.1 contrast checker in
  `assets/src/js/admin-settings.js`. Config object `cool_editor_tabs.settings` (schema provided).
- **Icon API**: `cool_editor_tabs.icons.yml` registers an SVG icon pack (`assets/src/icons/*.svg`).
- **Developer hook**: `hook_cool_editor_tabs_icon_alter(?string &$icon_id, string &$pack_id, string $route_name)`
  (see `cool_editor_tabs.api.php`) — map custom routes to icons or to a different pack.
- See `agent/configuration/colors-and-api.md` for config keys, defaults, route→icon map, and the hook.

## Permission note

`use cool editor tabs` is explicitly `restrict access: false` — a deliberate statement, not an
omission: it only changes **presentation** for whoever holds it and grants no capability. The
config form is separately gated by `administer site configuration`.

## Files

- `cool_editor_tabs.module` — page attachments, colour injection, theme suggestions, preprocess, icon helpers, hook_help.
- `src/Form/CoolEditorTabsSettingsForm.php` — colour settings form + reset handler.
- `templates/menu-local-task(s)--better.html.twig`, `menu-local-action--better.html.twig` — tab overrides.
- `cool_editor_tabs.{routing,permissions,links.menu,icons,libraries}.yml`, `config/{install,schema}`.
- `assets/src/js/*.js`, `assets/dist/css/admin-tabs.css`, `assets/src/icons/*.svg`.
