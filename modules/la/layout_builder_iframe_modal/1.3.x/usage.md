Renders Layout Builder's block and section edit forms inside an iframe modal styled with the site's admin theme, instead of core's off-canvas tray rendered in the front-end theme.

---

Layout Builder iFrame Modal replaces core Layout Builder's off-canvas dialog with a centered iframe dialog. Core renders every "Add block", "Configure section", "Move block" etc. form in the off-canvas tray using the front-end theme, which forces themers to re-style complex widgets (tabs, entity autocomplete, media library, entity browser) so they work in that narrow tray. This module instead opens the same form in an iframe whose `src` is the form's own route, so the form renders in the admin theme fully isolated from front-end CSS. It works by registering a `drupal_iframe` main-content renderer (based on core's `DialogRenderer`) plus a custom `OpenIframeCommand` AJAX command; `hook_contextual_links_alter`/`hook_link_alter` rewrite matching links to `data-dialog-type="iframe"`, and `hook_preprocess_html` strips page furniture (header, breadcrumb, footer) on the iframed routes and tags the page with a `layout-builder-iframe-modal` body class. When the inner form saves successfully Drupal redirects to a tiny redirect route that uses `postMessage` to tell the parent window to close the modal and rebuild the layout, then scroll back to the edited block. Which routes get this treatment is controlled entirely by one config object, `layout_builder_iframe_modal.settings`, holding two lists: `layout_builder_iframe_routes` (the ten built-in Layout Builder routes) and `custom_routes` (any additional dialog routes you opt in). A settings form at `/admin/config/content/layout_builder_iframe_modal` toggles them, gated by the `configure layout builder iframe modal` permission. It also adds a "Rebuild" action to the layout and is compatible with `layout_builder_st` translation routes.

---

- Show Layout Builder "Add block" forms in an admin-themed iframe modal instead of the off-canvas tray.
- Get complex block widgets (media library, entity browser, entity autocomplete) to render correctly while editing a layout.
- Eliminate front-end CSS leaking into Layout Builder edit forms.
- Present "Configure section" and "Add section" forms in a full admin-theme dialog.
- Render "Remove block" and "Remove section" confirmation forms in the iframe modal.
- Open the "Move block" and "Reorder sections" forms in the iframe modal.
- Iframe the "Update block" (inline block edit) form for cleaner editing of custom blocks.
- Enable iframe modals for `layout_builder_st` translation routes (Translate block / Translate inline block).
- Selectively enable the iframe modal for only some Layout Builder routes (e.g. just Add block and Update block) via config.
- Turn off the iframe modal for a specific Layout Builder route while keeping the rest.
- Opt an arbitrary custom dialog route into the iframe modal through the `custom_routes` list.
- Automatically close the modal and rebuild the layout when a block form is saved.
- Restore the editor's scroll position after a block edit modal closes.
- Restrict who can change the iframe route configuration with the `configure layout builder iframe modal` permission.
- Manage the full route list from the admin form at `/admin/config/content/layout_builder_iframe_modal`.
- Deploy the route configuration between environments as exported `layout_builder_iframe_modal.settings` config.
- Provide site builders a Layout Builder editing experience consistent with the rest of the admin UI.
- Avoid the maintenance burden of theming Layout Builder forms for the front-end theme.
- Add a "Rebuild" action to the Layout Builder form to force a layout refresh.
- Use the module as a drop-in alternative to `layout_builder_modal` when you want admin-theme isolation via an iframe rather than in-page rendering.
- Override the iframe markup by overriding the `lbim-iframe.html.twig` template.
- Set custom iframe attributes (width/height/class) by overriding the `lbim_iframe` theme variables in a theme preprocess.
