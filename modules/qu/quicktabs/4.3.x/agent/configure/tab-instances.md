# Configure Quick Tabs instances

## Admin UI

- List / entry point: `/admin/structure/quicktabs` (route `quicktabs.admin`, the
  `configure` route; menu under Structure). Lists `quicktabs_instance` entities.
- Add: `/admin/structure/quicktabs/add` (`entity.quicktabs_instance.add_form`).
- Edit: `/admin/structure/quicktabs/{quicktabs_instance}/edit` (`entity.quicktabs_instance.edit_form`).
- Delete: `/admin/structure/quicktabs/{quicktabs_instance}/delete`.
- Duplicate: `/admin/structure/quicktabs/{quicktabs_instance}/duplicate`.
- All of the above require the `administer quicktabs` permission. The AJAX content
  route `/quicktabs/{js}/{instance}/{tab}` (`quicktabs.ajax_content`) requires
  only `access content` and serves one tab's content on demand.

After saving an instance, a block is derived from it (block plugin
`quicktabs_block:{instance_id}`, admin category "QuickTabs"). Place it on
`/admin/structure/block` like any block.

## Config entity: `quicktabs_instance`

Config-entity type id `quicktabs_instance`; config prefix/name pattern
`quicktabs.quicktabs_instance.{id}`. Exported keys (`config_export`):

| Key | Meaning |
|---|---|
| `id`, `label` | machine id + human label |
| `renderer` | tab renderer plugin id: `quick_tabs`, `accordion_tabs` (accordion submodule), or `ui_tabs` (jqueryui submodule) |
| `options` | per-renderer options, keyed by renderer (see schema below) |
| `hide_empty_tabs` | bool — drop tabs whose content renders empty |
| `remember_last_clicked_tab` | bool — re-open last tab via js_cookie |
| `default_tab` | integer index of the tab open on load |
| `configuration_data` | ordered list of tabs; each has `title`, `weight`, `type` (tab type id), `content` |

Each `configuration_data` item's `type` is a **TabType** plugin id — one of
`node_content`, `block_content`, `view_content`, `qtabs_content` — and its
`content` holds that type's options.

## Schema highlights (`config/schema/quicktabs.schema.yml`, FullyValidatable)

Renderer `options`:
- `quick_tabs`: `ajax` (bool, load tabs over AJAX), `class` (string, extra CSS
  classes, nullable), `style` (one of `''`, `pamela`, `on-the-gray`, `tabsbar`,
  `material-tabs`), `direct_linking` (bool, deep-linkable tabs).
- `accordion_tabs`: `jquery_ui.collapsible` (bool), `jquery_ui.heightStyle`
  (`auto` | `fill` | `content`).

TabType `content` options:
- `node_content`: `nid`, `view_mode`, `hide_title`.
- `block_content`: `bid`, `block_title`, `display_title`.
- `view_content`: `vid`, `display`, `args`.
- `qtabs_content`: `machine_name` (another Quick Tabs instance).

## Styles / CSS libraries

The `quick_tabs` renderer's `style` option maps to a library in
`quicktabs.libraries.yml`: `pamela`, `on-the-gray`, `tabsbar`, `material-tabs`
(each a CSS theme). The base `quicktabs` library (js/quicktabs.js + js_cookie)
drives AJAX loading and last-clicked-tab memory.

## Views style

A View can render its own rows as tabs with the Views style plugin id
`quicktabs` (`Plugin/views/style/Quicktabs`, `views.style.quicktabs` schema,
optional `path` mapping) — independent of creating a `quicktabs_instance`.

## Security note (from README)

Node tabs use node_access, but any node fetched via `/quicktabs/ajax/node/{nid}`
returns its configured display as JSON. Control field visibility on the node
type's Manage Display; do not rely on other mechanisms to hide fields in a tab.
