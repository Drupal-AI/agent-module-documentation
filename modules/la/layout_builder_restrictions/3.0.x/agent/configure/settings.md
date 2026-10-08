# Configuring restrictions

Two places:

## 1. Global plugin admin page
Route `layout_builder_restrictions.restriction_plugin_config_form` →
`/admin/config/content/layout-builder-restrictions` (permission: *configure layout builder
restrictions*). Enable/disable the available restriction plugins and set their **weight**
(order of precedence). Config stored in `layout_builder_restrictions.settings`. Only one plugin
(`entity_view_mode_restriction`) ships by default; more appear when submodules/custom plugins
are installed. The manager exposes `getSortedEnabledPlugins()` — enabled plugins run in weight
order.

## 2. Per view mode (where you actually pick blocks/layouts)
On each bundle/view mode's Layout Builder defaults page (**Manage layout** for the default
layout), the `entity_view_mode_restriction` plugin adds a **"Layout Builder Restrictions"**
form section. There you:
- Choose **allowed layouts** (all, or a specific whitelist of layout plugins).
- Choose **allowed blocks** per block category — whitelist/blacklist individual blocks or allow
  a whole category (e.g. "Content fields", "Inline blocks").
- Restrict which **inline block** types can be created.

Selections are saved as **third-party settings** on the layout section storage, so they export
with the display/config and deploy between environments.

## How enforcement happens
- `alterBlockDefinitions()` / `alterSectionDefinitions()` remove disallowed blocks/layouts from
  the chooser (via `ChooseBlockController` and a `FormAlter`).
- `blockAllowedinContext()` blocks drag-and-drop moves into disallowed regions
  (`MoveBlockController` / `MoveBlockForm`), returning an error message when denied.
- A `RouteSubscriber` swaps in the module's controllers for the core Layout Builder routes.
