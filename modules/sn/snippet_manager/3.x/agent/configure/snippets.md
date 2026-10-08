<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure snippets

A snippet is a `snippet` config entity edited under `/admin/structure/snippet` (route
`entity.snippet.collection`). All edit routes require the `administer snippets` permission. Config is
split across several forms/tabs on one entity; the exported config keys are listed below (schema:
`config/schema/snippet_manager.schema.yml`, entity: `src/Entity/Snippet.php`).

## Creating a snippet

- Add form: `/admin/structure/snippet/add` (`GeneralForm`). Fields: `label`, machine `id`, plus the
  Page / Block / Display variant / Layout sub-sections (below).
- Edit tabs (all under `/admin/structure/snippet/{snippet}/edit/...`):
  - **General** (`edit`, `GeneralForm`) — page/block/variant/layout exposure toggles.
  - **Template** (`edit/template`, `TemplateForm`) — the Twig body.
  - **CSS** (`edit/css`, `CssForm`), **JS** (`edit/js`, `JsForm`).
  - **Variables** — add/edit/delete at `edit/variable/add`, `edit/variable/{variable}/edit`,
    `edit/variable/{variable}/delete`.
- Other operations: `source` (rendered HTML + render-time), `duplicate`, `delete`, `enable`/`disable`
  (CSRF-protected). Access to `view` is granted to anyone only when the snippet's `status` is enabled
  (`SnippetAccessControlHandler`).

## `template` — the Twig body

- Keys: `template.value` (the Twig/markup string) and `template.format` (a filter format id; defaults
  to `full_html` if available, else the site default — `Snippet::getDefaultFormat()`).
- Rendered by `SnippetViewBuilder::viewDefault()` as
  `['#type' => 'inline_template', '#template' => check_markup(value, format), '#context' => …]`. The
  value is first run through the chosen text format, then compiled as Twig. This is core's standard
  (non-sandboxed) Twig — see [../permissions/index.md](../permissions/index.md) for the trust model.
- Twig context available in every template: the snippet's variables (keyed by variable name), plus
  defaults `theme`, `theme_directory`, `base_path`, `front_page`, `is_front`, `language`, `is_admin`,
  `logged_in` (`SnippetViewBuilder::getDefaultContext()`), and the `snippet('id', {...})` function.

## `variables` — named Twig context

`variables` is a sequence of `{plugin_id, configuration}`; each entry is a `SnippetVariable` plugin
(see [../plugins/snippet-variable.md](../plugins/snippet-variable.md)) whose `build()` becomes the
Twig context key of that variable name. Managed on the Variables tab.

## `page` — expose the snippet at a URL

`page` mapping: `status` (bool), `title`, `path` (e.g. `my/page`, `content/%node` for a named
parameter, `%` for a positional arg), `display_variant`, `theme`, and `access`:

- `access.type = all` → route requirement `_access: TRUE` (public — the admin explicitly chose no
  restriction).
- `access.type = permission` → `_permission: <permission>` (`access.permission`).
- `access.type = role` → `_role: <rid+rid>` (`access.role[]`).

Routes are (re)built by `RouteSubscriber::alterRoutes()` into `entity.snippet.page.<id>`; path
placeholders `%name` become `{name}`, and if `name` is an entity type the value is upcast to that
entity. Path is validated in `GeneralForm::validatePath()` (no leading `%`, no query, no numeric
placeholders). Saving a page-enabled snippet triggers a router rebuild (`Snippet::postSave()`).

## `block` — expose as a placeable block

`block` mapping: `status` (bool), `name` (admin description). When enabled, `SnippetBlockDeriver`
derives a `snippet:<id>` block; `SnippetBlock::blockAccess()` defers to `$snippet->access('view')`.
Only shown when the `block` module is installed.

## `display_variant` / `layout`

- `display_variant` mapping: `status`, `admin_label` → derives a `snippet_display_variant:<id>` page
  display variant (`SnippetDisplayVariantDeriver`).
- `layout` mapping: `status`, `label`, `default_region` → derives a `snippet_layout:<id>` layout
  (`SnippetLayoutDeriver`); only when `layout_discovery` is installed. Regions come from
  `layout_region` variables (`Snippet::getLayoutRegions()`), rendered via theme hook `snippet_layout`
  / template `snippet-layout.html.twig`.

## `css` / `js`

- `css` mapping: `status`, `preprocess` (bool), `value` (code), `group` (`component`/`theme`/etc.).
- `js` mapping: `status`, `preprocess` (bool), `value` (code).
- When either is enabled, `SnippetLibraryBuilder::updateAssets()` writes the code to files under
  `public://snippet/` and registers a `snippet_manager/snippet_<id>` library that
  `SnippetViewBuilder` attaches to the rendered snippet. This is author-supplied CSS/JS emitted to the
  page — another reason `administer snippets` is high-trust.
