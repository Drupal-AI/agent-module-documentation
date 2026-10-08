<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Critical CSS UI — entity, config, routes, and the renderer

## Install & enable

```bash
composer require drupal/critical_css_ui
drush en critical_css_ui -y
```

No composer requirements beyond `drupal/core: ^10 || ^11` and no declared Drupal module
dependencies. Do **not** run it alongside the `critical_css` contrib module — both decorate
`asset.css.collection_renderer`, and `critical_css_ui_requirements()` (in `critical_css_ui.install`)
raises a `RequirementSeverity::Error` at runtime when both are enabled.

## Site setting

Config object **`critical_css_ui.settings`** (schema `config/schema/critical_css_ui.schema.yml`,
install default `config/install/critical_css_ui.settings.yml` ships `enabled: true`) has one key:

| Key | Type | Meaning |
|---|---|---|
| `enabled` | boolean | Master switch. When off, `CriticalCssProvider::isEnabled()` returns FALSE and no CSS is inlined. |

Edit it at **Configuration → Development → Performance → Critical CSS**
(`/admin/config/development/performance/critical-css`, route `critical_css_ui.settings`, form
`Form\CriticalCssConfigForm`). Toggle via config:

```bash
drush cset critical_css_ui.settings enabled true -y && drush cr
```

## The `critical_css` entity

`src/Entity/CriticalCSS.php` defines a content entity type `critical_css` (base table
`critical_css`, `admin_permission = "administer critical_css"`, label key `target_context`, published
key `status`). Base fields from `baseFieldDefinitions()`:

| Field | Type | Notes |
|---|---|---|
| `target_context` | `string` (max 255) | Required, `UniqueField` constraint. The match key: `node:{id}`, `node:{bundle}`, or `default`. |
| `css` | `string_long` | Required. The critical CSS body that gets inlined. |
| `status` | `boolean` (default TRUE) | Only enabled entities are matched. |
| `created` / `changed` | `created` / `changed` | Timestamps shown in the list. |

Handlers: list builder `CriticalCSSListBuilder` (columns ID / Status / Created / Updated),
`views_data` = core `EntityViewsData`, `AdminHtmlRouteProvider`, and forms — `add`/`edit` =
`Form\CriticalCSSForm`, `node`/`node_type` = `Form\CriticalCssContextForm`, delete =
core `ContentEntityDeleteForm` / `DeleteMultipleForm`. The install profile also ships two
`system.action` config entities (`critical_css_save_action`, `critical_css_delete_action`) for the
entity list's bulk operations.

## Routes & permission

Every route requires the **`administer critical_css`** permission (`critical_css_ui.permissions.yml`,
`restrict access: true`):

| Route | Path | Purpose |
|---|---|---|
| `critical_css_ui.settings` | `/admin/config/development/performance/critical-css` | Settings form. |
| `entity.critical_css.collection` | `.../critical-css/list` | Entity list. |
| `entity.critical_css.add_form` | `.../critical-css/add` | Add entry. |
| `entity.critical_css.canonical` | `.../critical-css/{critical_css}` | View entry (`\d+`). |
| `entity.critical_css.edit_form` | `.../critical-css/{critical_css}/edit` | Edit entry. |
| `entity.critical_css.delete_form` | `.../critical-css/{critical_css}/delete` | Delete entry. |
| `entity.critical_css.node_form` | `/node/{node}/critical-css` | Per-node tab. |
| `entity.critical_css.node_type_form` | `/admin/structure/types/manage/{node_type}/critical-css` | Per-content-type tab. |

Menu/tabs: `critical_css_ui.settings` menu link and local task sit under
`system.performance_settings`. The deriver `Plugin\Derivative\CriticalCssLocalTasks` adds a
"Critical CSS" tab (weight 100) on `entity.node.canonical` and `entity.node_type.edit_form`.

## Context forms (auto-filled target context)

`Form\CriticalCssContextForm` is used for the node and node-type tabs. In `form()` it reads the
`node` or `node_type` route parameter, computes `target_context` = `node:{node id}` or
`node:{node_type id}`, loads an existing matching entity if one exists (otherwise seeds a new one
with `status = TRUE`), and hides the `target_context` field (`#access = FALSE`). On save it redirects
back to the node's canonical page or the node type's edit form and logs to the `critical_css_ui`
channel.

`Form\CriticalCSSForm` (the generic add/edit form) additionally re-validates `target_context`
uniqueness in `validateForm()` with an entity query (`accessCheck(FALSE)`, excluding the current id),
setting a form error if a duplicate exists.

## How injection works (provider + decorator)

`Asset\CriticalCssProvider` (service `critical_css_ui.provider`, args: entity type manager, request
stack, current route match, current user, `router.admin_context`, config factory):

- `isEnabled()` → FALSE when the route is an admin route **and** the user has
  `view the administration theme`, or when the request is XHR; otherwise returns
  `critical_css_ui.settings:enabled`.
- `getTargetContexts()` → resolves the current entity from route parameters typed `entity:*`; for a
  **node** it yields `node:{id}`, then `node:{bundle}`; always appends `default`
  (deduped, empties filtered).
- `getCriticalCss()` → for each candidate context in order, `loadByProperties(['target_context' => …,
  'status' => TRUE])`, takes the first entity's `css`, `trim()`s it, and stops. Result is memoized
  (`isAlreadyProcessed`).

`Asset\CssCollectionRenderer` decorates `asset.css.collection_renderer`
(`critical_css_ui.services.yml`): `render()` runs the inner renderer, and — when the provider is
enabled and not already processed — prepends a `#type => html_tag`, `#tag => style`,
`#attributes[id] => critical-css` element whose `#value` is `Markup::create($criticalCss)`. If a
fragment was found, `makeAssetsAsync()` rewrites every non-`print` stylesheet link to `media="print"`
with `data-onload-media="all"` and `onload="this.onload=null;this.media=this.dataset.onloadMedia"`
(the Filament Group async-CSS pattern), each followed by a `#noscript => TRUE` fallback copy; print
sheets are passed through unchanged.

## Operating notes

- The inlined `css` value comes straight from the entity (created only by holders of the restricted
  `administer critical_css` permission) and is written into the `<style>` tag as `Markup` — it is
  authored, admin-trusted stylesheet content, so keep the permission limited to the roles that would
  otherwise edit theme CSS.
- Nothing is fetched over the network and no files are written: contexts are matched against
  database rows only. There is no request-supplied URL or path involved.
- If CSS does not appear: confirm `enabled` is on, a matching **enabled** entity exists for the
  page's context, you are not on an admin route, and clear cache (`drush cr`).
