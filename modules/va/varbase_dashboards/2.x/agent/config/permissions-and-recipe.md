<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions, install recipe, Views, and the default dashboard

## Install / enable

`composer require drupal/varbase_dashboards` then `drush en varbase_dashboards`. On install,
`varbase_dashboards_install()` runs the bundled recipe at `recipes/default` via
`RecipeRunner::processRecipe()`. There is **no settings form / `configure` route**; the dashboard
is configured through the Dashboard module's UI and Layout Builder.

## Permissions (`varbase_dashboards.permissions.yml`)

Ten permissions, each a *visibility* gate consumed by the recipe's Views (none guard a route in
this module — the module has no routes):

- `access varbase dashboards content` / `... content in draft`
- `access varbase dashboards content in drafts by user`
- `access varbase dashboards recent changes` / `... recent changes by user`
- `access varbase dashboards recently created` / `... recently created by user`
- `access varbase dashboards terms`
- `access varbase dashboards comments`
- `access varbase dashboards users`

The `... by user` variants are meant to scope a Views block to the current user's own items.

## The recipe (`recipes/default/recipe.yml`)

- `install:` `content_moderation`, `layout_builder_restrictions`, `dashboard`.
- `config.import: dashboard: '*'` — imports the shipped dashboard + Views config.
- `config.actions` grantPermissions to Varbase roles, escalating in scope:
  - `authenticated` → the three `... by user` permissions only (own drafts / own activity / own
    recently created).
  - `editor` → `view dashboard dashboard` + all content/draft/changes/created permissions.
  - `seo_admin` / `content_admin` → the above plus `terms` (and `comments` for content_admin).
  - `site_admin` → everything plus `users`, `administer dashboard`.

`view dashboard dashboard` and `administer dashboard` are **Dashboard-module** permissions — that
module (not this one) enforces who can view/administer a dashboard entity.

## Shipped Views (`recipes/default/config/views.view.*`)

Each display sets `access: { type: perm }`. Access mapping:

- `varbase_dashboards_content` → `access varbase dashboards content`
- `varbase_dashboards_content_in_draft` → `access varbase dashboards content in draft`
- `varbase_dashboards_recent_changes` → `access varbase dashboards recent changes` (and
  `... by user` on the "your activity" display)
- `varbase_dashboards_terms` → `access varbase dashboards terms`
- `varbase_dashboards_users` → `access varbase dashboards users`
- `varbase_dashboards_recently_created` → core `access content overview`
- `varbase_dashboards_publishing_content` → `view publishing dashboard`

These Views are exposed as `views_block:*` blocks placed on the dashboard.

## Default dashboard config (`config/dashboard.dashboard.dashboard.yml`)

A `dashboard` config entity id `dashboard`, label "Dashboard", built with Layout Builder:

- Section 1 `layout_twocol_section` (33-67): `varbase_dashboard_user`,
  `dashboards_block:dashboard:varbase_add_content_menu` (Add content), `varbase_content_overview`
  (My Site Overview), and Views blocks for drafts and all-content.
- Section 2 `layout_onecol`: the scheduled-publishing Views block.
- `third_party_settings.layout_builder_restrictions` whitelists a fixed set of Views/Menu/System/
  User blocks and only `layout_onecol` / `*_section` layouts, so editors cannot place arbitrary
  blocks on the dashboard.

## Updates

`hook_update_20001` (in `varbase_dashboards.install`) adds a `navigation_dashboard` block to
`navigation.block_layout` when both `navigation` and `dashboard` modules are enabled and the
block is not already present.

## Notes

- No `config/schema/*` and no `config/install/*` (the install dir holds only a README pointing to
  the recipe) — so the module ships **no config schema of its own**; its runtime config are the
  Views + dashboard entities imported by the recipe.
- Library `varbase_dashboards/style` (theme CSS) is attached only on dashboard routes by
  `hook_page_attachments`.
