Responsive Preview adds a toolbar control that reloads the current page inside a resizable iframe at the dimensions of common devices (phone, tablet, desktop), so you can check a page's layout at different screen widths without leaving the site.

---

The module registers a toolbar item (`hook_toolbar`) whose tab lists every enabled Device config entity. Clicking a device opens an in-page preview scaled to that device's width, height and dots-per-pixel (dppx), with a portrait/landscape orientation. Devices are `responsive_preview_device` config entities; four ship by default (Phone, Tablet Portrait, Tablet Landscape, Desktop) and are fully editable at Admin > Configuration > User interface > Responsive preview (`/admin/config/user-interface/responsive-preview`). The preview works on regular pages and on node add/edit forms — for unsaved or in-progress nodes it hooks the node form's Preview button over AJAX so you can preview the draft. When a preview URL is requested it appends `?responsive_preview=enabled`, and `hook_preprocess_html` strips the toolbar, navigation, top bar and contextual links from the framed page. Two permissions gate the feature: "access responsive preview" to use the toolbar, and "administer responsive preview" to manage device definitions. A "Responsive preview controls" block is also provided for placing the control outside the toolbar, and the optional `responsive_preview_navigation` submodule surfaces the icons in the new core Navigation top bar.

---

- Preview the current page at phone width without resizing your browser window
- Check a node's layout at tablet portrait and landscape before publishing
- Preview an unsaved node draft from the edit form's Preview action over AJAX
- Verify responsive breakpoints and media queries render correctly per device
- Add a custom device (e.g. a specific phone model) with exact width/height/dppx
- Disable devices you never use so the toolbar list stays short
- Reorder the device list via the `weight` field on each Device entity
- Set a device's default orientation to portrait or landscape
- Simulate high-DPI ("retina") screens by setting a device's dppx to 2 or 3
- Give content editors preview access without giving them device-admin rights
- Place the "Responsive preview controls" block in a region for non-toolbar themes
- Show responsive preview icons in the core Navigation top bar via the submodule
- QA a theme's grid at multiple widths from inside the admin session
- Demo a page's responsive behavior to a client during a review meeting
- Confirm a Layout Builder layout collapses correctly on narrow screens
- Test that a hero image or slider crops sensibly at mobile dimensions
- Export the four default device definitions as config for reuse across sites
- Programmatically build the device list render array from the `responsive_preview` service
- Get the current page's preview URL (with the query flag) from the service in custom code
- Restrict preview to specific node types by disabling their content-type Preview mode
- Compare portrait vs landscape rendering of the same page side by side
- Provide a distraction-free framed view of a page with admin chrome removed
- Add device presets matching your organization's target-device analytics
- Preview taxonomy, user or view pages (any front-end route) at device widths
- Check that sticky headers/footers behave when the viewport is short
- Validate that font sizes and tap targets look right at real device dppx
