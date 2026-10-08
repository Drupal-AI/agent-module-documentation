# API — responsive_preview

Service id: **`responsive_preview`** → `Drupal\responsive_preview\ResponsivePreview`.
Constructor deps: `router.admin_context`, `current_route_match`, `entity_type.manager`,
`current_user`, `request_stack`. Get it with `\Drupal::service('responsive_preview')`.

## Query flag

The preview URL for a page is the same URL plus `?responsive_preview=enabled` and `absolute => TRUE`.
Constants: `RESPONSIVE_PREVIEW_QUERY_PARAMETER = 'responsive_preview'`,
`RESPONSIVE_PREVIEW_ENABLED = 'enabled'`. When that query flag is present,
`preprocessHtml()` (called from `hook_preprocess_html`) unsets `page_top`'s `toolbar`,
`navigation` and `top_bar`, and removes contextual links — so the framed page has no admin chrome.

## Public methods

- `getPreviewUrl(): ?string` — returns the absolute preview URL for the current route (with the
  query flag), or `NULL` when preview shouldn't show. Handles `node.add` / node edit forms (respects
  the content type's Preview mode) and any non-admin route; returns `NULL` on admin routes with no
  previewable entity.
- `getRenderableDevicesList(): array` — render array (`#theme => item_list__responsive_preview`) of
  all `status = 1` devices sorted by weight, each a `<button>` carrying
  `data-responsive-preview-{name,width,height,dppx}` attributes, plus a "Configure devices" link
  (shown only with `administer responsive preview`).
- `previewEnabled(NodeTypeInterface $node_type): bool` — TRUE unless the content type's preview mode
  is `DRUPAL_DISABLED`. Used to suppress preview for content types with Preview turned off.
- `previewToolbar(): array` — builds the `hook_toolbar` item (cached on `user.permissions`,
  `route.is_admin`, `url`; returns empty if the user lacks `access responsive preview`).
- `formAlter(&$form, $form_state, $form_id)` — on node forms adds a hidden `ajax_responsive_preview`
  element wired to the Preview button so an unsaved draft can be previewed.
- `handleAjaxDevicePreview($form, $form_state): AjaxResponse` (static) — AJAX callback that pushes the
  draft preview URL via `SettingsCommand` and triggers the chosen device button; on validation errors
  it re-clicks the normal Preview button so messages display.

## Front-end wiring

The toolbar/block attaches library `responsive_preview/drupal.responsive-preview` (deps:
`core/once`, `core/drupal.displace`, `core/internal.floating-ui`, `core/internal.backbone`) and
`drupalSettings.responsive_preview.url`. `js/responsive-preview.js` reads the device
`data-*` attributes and builds the scaled iframe.

## Block plugin

`Drupal\responsive_preview\Plugin\Block\ResponsivePreviewBlock` (id `responsive_preview_block`,
label "Responsive preview controls") renders `getRenderableDevicesList()` for placement outside the
toolbar. Access requires `access responsive preview`.

## Theme hook

`item_list__responsive_preview` (registered in `hook_theme`, based on core `item_list`); template
`templates/item-list--responsive-preview.html.twig`. The module also registers a `cache.context`
service `cache_context.route.is_admin` (`RouteAdminCacheContext`).
