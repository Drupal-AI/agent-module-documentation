# dashboard — configure

## The dashboard config entity

`dashboard` is a config entity (`ConfigEntityType` id `dashboard`, prefix `dashboard`,
config file `dashboard.dashboard.<id>.yml`). Exported keys: `id`, `label`, `description`,
`layout`, `weight` (plus `uuid`, `status`). `layout` is a sequence of Layout Builder
sections — the entity implements `SectionListInterface`, so a dashboard IS its layout.

## Admin UI / routes

- Collection (the `configure` route): `entity.dashboard.collection` → `/admin/structure/dashboard`
  (requires `administer dashboard`). Lists dashboards, ordered by weight.
- Add: `/admin/structure/dashboard/add` — Edit: `/admin/structure/dashboard/{dashboard}`
  — Delete: `/admin/structure/dashboard/{dashboard}/delete`.
- Preview: `/admin/structure/dashboard/{dashboard}/preview`.
- Manage permissions: `/admin/structure/dashboard/{dashboard}/permissions`.
- User-facing default dashboard: `/admin/dashboard` (route `dashboard`); a specific one at
  `/admin/dashboard/{dashboard}` (route `entity.dashboard.canonical`).

## Create a dashboard

Via UI: Add dashboard, give it a label/description, save. Or ship it as config
(`dashboard.dashboard.<id>.yml`) with `id`, `label`, `weight`, and an empty `layout: {}`.

## Place blocks / build the layout

Editing the layout uses core Layout Builder at `layout_builder.dashboard.view`, reached by the
**"Edit layout"** local action on the dashboard/edit pages. Add sections (e.g.
`layout_onecol`, `layout_twocol_section`) and drop blocks into regions. Placeable blocks
include this module's own (category "Dashboard"):

- `dashboard_text_block` — **Dashboard Text**: a formatted text (`text_format`) block.
- `dashboard_site_status` — **Site Status**: core status-report summary.
- `navigation_dashboard` — **Navigation Dashboard**: links to dashboards from navigation.
- `dashboard_placeholder` — **Placeholder**: decorates a block that may not exist (e.g. a
  Views block), degrading gracefully if the referenced block is missing.

…plus any Views block, Shortcuts, or core/contrib block. Inline blocks are disabled for the
`dashboard` section storage. A stored component looks like (from a shipped example):

```yaml
layout:
  - layout_id: layout_twocol_section
    layout_settings: { column_widths: 50-50 }
    components:
      <uuid>:
        region: first
        configuration:
          id: dashboard_text_block
          provider: dashboard
          text: { value: '<p>Welcome</p>', format: basic_html }
        weight: 0
```

## Per-role dashboards & the login landing page

There is no literal "front page" setting; the effect is produced by access + weight +
a login redirect:

1. Create one dashboard per role.
2. Grant each role the dynamic `view <id> dashboard` permission for its dashboard
   (see permissions/dashboard.md).
3. `DashboardManager::getDefaultDashboard()` returns the first **enabled** dashboard,
   ordered by `weight` ascending, that the current user has `view` access to. That is what
   `/admin/dashboard` renders — so weight decides precedence when a user can see several.
4. `hook_user_login` (`Drupal\dashboard\Hook\UserLoginRedirect`) sends the user to
   `/admin/dashboard` right after login when an accessible dashboard exists — unless an
   explicit `?destination=` is set, or they are on the password-reset (`user.reset.login`)
   route. This makes the role's dashboard the effective post-login landing page.

Disabling a dashboard (`status: false`) removes it from view and from the redirect.

## Not a plugin type

The module defines no plugin manager of its own. Its blocks are ordinary core Block plugins,
and it registers a Layout Builder **section storage** plugin (`dashboard`, inline blocks off)
— it implements core plugin types rather than providing new ones.

## Integrations

Gin theme, Navigation, Toolbar, and Coffee integrations ship as `src/Hook/*` classes and
activate automatically when those modules are present.
