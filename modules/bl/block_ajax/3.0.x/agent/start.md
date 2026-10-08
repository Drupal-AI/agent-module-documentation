<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Block (block_ajax) — agent index

Adds a "Load block via Ajax" option to every block's config form (a `block_ajax` third-party
setting under `settings`). A flagged block renders a small placeholder in its region; client JS
then fetches the block's real markup from a custom route and swaps it in after page load — useful
for personalised/expensive blocks that would otherwise make the whole page uncacheable.

- Dependencies: `block` (core), `token` (contrib). Core: `^10.3 || ^11`.
- Configure: no dedicated settings page — options live per block on the block config form.
  `configure` points at core's block-layout page (`block.admin_display`), which this module's
  route subscriber re-routes to its own list controller.
- Defines 1 permission, 0 drush commands, 0 plugin types, and no config schema/config objects.

Solution docs:
- **Turn a block into an Ajax block / set its options (max-age, spinner, button, refresh, context)** → [configure/ajax-block-settings.md](configure/ajax-block-settings.md)
- **Understand/consume the AJAX render endpoint (routes, request params, JS)** → [blocks/ajax-endpoint.md](blocks/ajax-endpoint.md)
- **Call the service / trigger a refresh from PHP or JS** → [api/services.md](api/services.md)
- **See which hooks it implements (block build/view alters, form override)** → [hooks/hooks.md](hooks/hooks.md)
- **The gatekeeping permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts (real machine names):
- Third-party setting namespace: block config `settings['block_ajax']` with keys `is_ajax`,
  `max_age`, `show_spinner`, `placeholder`, `load_button`, `load_button_text`, `refresh_block`,
  `refresh_interval`, `context['context_type']`, `ajax_defaults['method'|'timeout'|'others']`.
- Routes: `block_ajax.ajax_block` (`/block/ajax/{block_id}`) plus node / taxonomy-term / user
  context variants; all `_permission: 'access content'`, `no_cache: TRUE`.
- Services: `block_ajax.ajax_blocks` (`AjaxBlocks`), `block_ajax.block_view_builder`
  (`BlockViewBuilder`), `block_ajax.route_subscriber`.
- Permission: `administer ajax blocks`.
- Library: `block_ajax/ajax_blocks`. Theme hook: `block_ajax_block`. Cache tag: `block_ajax`.
- JS Ajax command / event: `AjaxBlockRefreshCommand` triggers the `RefreshAjaxBlock` DOM event.
