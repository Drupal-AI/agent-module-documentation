<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route In Modal (route_in_modal) — agent index

**Define routes that open in a Drupal modal and submit their forms over AJAX.**

- **Version:** 1.0.x (1.0.0-rc1)
- **Core:** ^9 || ^10 || ^11
- **Configure route:** `route_in_modal.settings` → `/admin/config/user-interface/route-in-modal` (`_permission: administer route_in_modal`)
- **Permission:** `administer route_in_modal`
- **Config:** `route_in_modal.settings` — `routes` (textarea, one route per line, optional `|key:value,...` params), `dialog_width`, `dialog_height`
- **Hooks:** `hook_link_alter` (adds `use-ajax` + `data-dialog-type=modal`), `hook_form_alter` (AJAX submit wrapper), `hook_page_attachments`
- **Services:** `route_in_modal.helper` (ModalRouteHelper), RouteInModalAjaxHelper, RefreshPageCommand
- **Library:** `route_in_modal/route_in_modal`

**Security:** the only route is the admin settings form, gated by `administer route_in_modal`. The module only alters link markup / form rendering for already-accessible routes — it does not bypass the target route's own access checks.
