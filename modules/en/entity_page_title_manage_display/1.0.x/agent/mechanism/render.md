<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: page-title view mode and render swap

Source files: `entity_page_title_manage_display.install`, `entity_page_title_manage_display.module`,
`src/EntityPageTitleRender.php`. No routes, permissions, services, config schema or settings form.

## Install: create the view mode
`entity_page_title_manage_display_install()` iterates `EntityTypeManager::getDefinitions()`, skips
any entity type without a view-builder class, and for each remaining type creates an
`entity_view_mode` config entity with id `"<entity_type>.page_title"`, `status => TRUE`,
label `"Page Title"` — unless one already exists. So after install every viewable entity type
(node, taxonomy_term, user, media, comment, etc.) exposes a "Page Title" view mode.

The view mode is created but **not enabled per bundle**. A site builder must go to the bundle's
*Manage display* page, enable the "Page Title" view mode (in "Custom display settings"), and
configure it — which creates the `EntityViewDisplay` config entity `<type>.<bundle>.page_title`.
That display entity's existence is the switch the render path checks.

## Alter: attach the pre-render callback
`entity_page_title_manage_display_block_view_alter(array &$build, BlockPluginInterface $block)`:
- Returns immediately unless `$block->getPluginId() === 'page_title_block'` (core's Page title
  block) — it touches nothing else.
- Reads the current route name and proceeds only when it `str_starts_with('entity.')` **and**
  `str_ends_with` one of `.canonical`, `.preview`, `.revision`.
- For `.preview` routes it also requires the route's `view_mode_id` parameter to be `'full'`;
  otherwise it returns (so previews of other view modes are left alone).
- When matched, appends `[EntityPageTitleRender::class, 'renderPageTitle']` to `$build['#pre_render']`.

## Render: swap the block content
`EntityPageTitleRender` implements `TrustedCallbackInterface`; `trustedCallbacks()` returns
`['renderPageTitle']` so the pre-render callback is allowed. `renderPageTitle($build)`:
1. Walks `\Drupal::routeMatch()->getParameters()->all()` and picks the last value that is an
   `EntityInterface` (the routed entity). If none, returns `$build` unchanged.
2. Builds the display id `"<entity_type>.<bundle>.page_title"` and calls
   `EntityViewDisplay::load($id)`. If it does not exist (bundle not configured), returns `$build`
   unchanged — this is the fallback to normal core page-title behaviour.
3. Otherwise gets the entity type's view builder, calls `->view($entity, 'page_title')`, and
   renders it with `\Drupal::service('renderer')->renderInIsolation($title_build)`, then `trim`s.
4. If the rendered HTML is empty, returns `$build` unchanged.
5. Otherwise replaces `$build['content'] = ['#markup' => Markup::create($html)]` — i.e. the core
   page-title block's content becomes the entity rendered in the `page_title` view mode. Returns
   `$build`.

The replacement is the block's rendered content only (comment in code: "NOT the route title"),
so the HTML `<title>` / route title are unaffected; only the on-page title block changes.

## Operating it
1. Enable the module and clear cache. The "Page Title" view modes are created on install.
2. Go to *Structure → (content type / vocabulary / …) → Manage display*.
3. Enable and select the **Page Title** custom display; add/format the title and any extra fields.
4. View a full page of that bundle — the page-title block now shows the configured view mode.
   Leave a bundle unconfigured to keep the default title.

## Notes
- No dependency, no settings, no permissions: enabling is safe site-wide; effect is opt-in per
  bundle via Manage display.
- Only `entity.*.canonical/.preview(full)/.revision` routes are affected; other pages and other
  blocks are untouched.
- `renderInIsolation` renders the field output through the normal entity/field render pipeline
  (field formatters), so title and field values are escaped by that pipeline before the result is
  placed into the block.
