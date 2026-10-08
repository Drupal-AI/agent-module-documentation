<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks and the VarbaseDashboard widget plugin type

Everything the module renders is a **block placed on the Dashboard's Layout Builder layout**. No
routes/controllers exist here — the Dashboard (`drupal/dashboard`) module owns the pages.

## The `VarbaseDashboard` plugin type

A lightweight custom plugin type for dashboard widgets.

- Manager: `Plugin/VarbaseDashboardManager` (service `plugin.manager.varbase_dashboard`),
  discovers `Plugin/VarbaseDashboard`, alter hook `varbase_dashboard_info`, cache
  `varbase_dashboard_plugins` on the `dashboard` bin.
- Annotation `Annotation/VarbaseDashboard` (`id`, `label`, `category`). Interface
  `Plugin/VarbaseDashboardInterface` (marker). Base `Plugin/VarbaseDashboardBase`.
- `VarbaseDashboardBase` gives subclasses: abstract `buildRenderArray(array $configuration)`,
  overridable `buildSettingsForm()` / `validateForm()` / `massageFormValues()`, and cache
  helpers `getCache()/setCache()` (keys prefixed with the plugin id, default 3600s TTL) backed
  by the injected `dashboard.cache` backend.

### `dashboards_block` — the bridge to Layout Builder

`Plugin/Block/VarbaseDashboardBlock` is a core block with
`deriver = Derivative\VarbaseDashboardBlock`. The deriver iterates every `VarbaseDashboard`
definition and exposes one derived block id `dashboards_block:dashboard:<plugin_id>`. The block
delegates `blockValidate`/`buildConfigurationForm`/`blockSubmit`/`build` to the underlying
`VarbaseDashboardBase` instance (it parses the plugin id out of the derivative id, e.g.
`dashboard:varbase_add_content_menu` → `varbase_add_content_menu`). `build()` wraps the widget's
render array in a `.varbase-dashboard-component` container, or renders nothing when the widget
returns `[]`.

### `varbase_add_content_menu` (`Plugin/VarbaseDashboard/AddContentMenu.php`)

- `buildRenderArray()` loads all `node_type`s, and for each configured `items` bundle emits an
  `node.add` link **only when** `entityTypeManager->getAccessControlHandler('node')
  ->createAccess($bundle)` is TRUE — so it never advertises a type the viewer cannot create.
- Optional `include_destination` config appends the current `redirect.destination` to the add
  link so the user returns to the dashboard. Output theme: `varbase_dashboards_admin_list`.
- `buildSettingsForm()` renders a tabledrag weight table of content types + the
  `include_destination` checkbox.

## Core block plugins (`src/Plugin/Block/`)

### `varbase_dashboard_user` — "Varbase Dashboard User"

`VarbaseDashboardUser::build()` loads the current user, builds an account-edit link with
`Link::fromTextAndUrl(... entity.user.edit_form ...)` (display name is escaped by `Link`), and
returns a small `#markup` "Welcome back" panel with an *Edit Account* button. Rendered via
`templates/block--varbase-dashboard-user.html.twig`.

### `varbase_content_overview` — "My Site Overview"

`VarbaseContentOverview::build()` builds a Content/Discussion table of counts per node type:

- Published node count: `SELECT count(*) FROM {node_field_data} WHERE type = :type AND status = 1`.
- If `comment` is enabled: published-comment and (optional) unpublished/"spam" comment counts,
  each with a **bound `:type` placeholder** — no user input reaches the SQL, no concatenated
  values.
- Config (`blockForm`/`blockSubmit`): `varbase_dashboards_types_overview` (checkboxes),
  `varbase_dashboards_comments_overview` (checkboxes), `varbase_dashboards_spam_overview`
  (radios). Counts link to `system.admin_content?type=<type>`. Interpolated text is the
  admin-defined node-type `name`; numbers are formatted with `formatPlural`/`number_format`.

## Hooks (`src/Hook/VarbaseDashboardsHooks.php`)

Attribute-based (`#[Hook(...)]`) implementations:

- `page_attachments` — attaches `varbase_dashboards/style` CSS on `dashboard`,
  `entity.dashboard.canonical`, `layout_builder.dashboard.view`, `entity.dashboard.preview`.
- `theme` + `theme_registry_alter` — when the active theme is the admin theme and is (or extends)
  Gin/Claro, registers the module's per-layout templates from `templates/layouts/{gin,claro}`;
  also registers/relocates the `varbase_dashboards_admin_list` theme.
- `preprocess_varbase_dashboards_admin_list` — builds an `href`/`title` `Attribute` per list item
  from its `Url`.

## Extending

Add a widget by creating `Plugin/VarbaseDashboard/MyWidget` extending `VarbaseDashboardBase`,
annotated `@VarbaseDashboard(id="...", label=..., category=...)`, and implementing
`buildRenderArray()`. It becomes placeable on any dashboard as `dashboards_block:dashboard:<id>`.
