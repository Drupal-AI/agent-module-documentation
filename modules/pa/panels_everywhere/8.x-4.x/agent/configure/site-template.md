# Configure the site template (configure)

Panels Everywhere has **no settings page of its own**. Everything is configured through the
**Page Manager UI** (`/admin/structure/page_manager` — enable core `page_manager_ui` first) on the
page named **`site_template`** that this module installs.

## The seed config

`config/install/` ships two config entities:

- `page_manager.page.site_template` — a Page Manager **page** entity, id `site_template`,
  `path: /site_template`, `use_admin_theme: false`, and **`status: false`** (disabled). Because it is
  disabled at install, Panels Everywhere does nothing until you enable it.
- `page_manager.page_variant.panels_everywhere` — a **page variant** on that page, `variant:
  panels_everywhere_variant`, `layout: layout_onecol`, `builder: standard`,
  `route_override_enabled: false`.

Runtime-verified: after install the `site_template` page loads with `status = false`.

## Turn it on (site builder)

1. Enable the module (pulls in `panels`, `page_manager`, `ctools_block`, `layout_discovery`) and
   enable core **Page Manager UI** (`page_manager_ui`) so the page is visible/editable.
2. At `/admin/structure/page_manager`, edit **Site template** and **enable** it.
3. In its `panels_everywhere_variant` variant, choose a **layout** (defaults to `layout_onecol`) and
   add blocks to the regions — one of them **must** be the **"Main Page Content"** block
   (`system_main_block`, a `MainContentBlockPluginInterface`); that pane is where each route's own
   output is injected. Add the "Page title", "Messages", "Primary menu", etc. blocks for the parts of
   the shell the theme used to render.
4. Because the variant is now selected for **every non-admin route**, that one arrangement becomes the
   page shell site-wide. Admin routes (routes with option `_admin_route`) are skipped — see
   [../api/subscribers.md](../api/subscribers.md).

You can also create **additional** Page Manager pages (e.g. bound to a specific path) whose variant
uses `panels_everywhere_variant` to give a section its own shell; the subscriber prefers a page whose
route carries a matching `page_id` and otherwise falls back to `site_template`.

## The one real setting: `route_override_enabled`

The variant's configuration form (`PanelsEverywhereDisplayVariant::buildConfigurationForm`) adds a
single checkbox, **"Enable page-manager route override"**, stored as
`variant_settings.route_override_enabled` (boolean, config schema
`display_variant.plugin.panels_everywhere_variant`). Default **FALSE**.

| Value | Effect |
|---|---|
| `false` (default) | Panels Everywhere **removes** the route Page Manager would have created for this variant, so the **original** route still runs and produces the "Main Page Content" that the variant wraps. This is the whole point — the shell decorates the real page. |
| `true` | Leaves Page Manager's route override in place; Page Manager takes over the path entirely and the original route's content is **not** rendered. Use only when you deliberately want the variant to *replace* a route rather than wrap it. |

Set it from code on the variant entity:

```php
$variant = \Drupal::entityTypeManager()->getStorage('page_manager_page_variant')->load('panels_everywhere');
$settings = $variant->get('variant_settings');
$settings['route_override_enabled'] = FALSE;   // wrap (default) — TRUE = replace
$variant->set('variant_settings', $settings);
$variant->save();
// The route subscriber acts on the next router rebuild:
\Drupal::service('router.builder')->rebuild();
```

Legacy note: earlier versions stored this as a page-level third-party setting
`panels_everywhere:disable_route_override`. `panels_everywhere_post_update_route_override()` migrates
that value onto each variant's `route_override_enabled` and removes the old setting.
