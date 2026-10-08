<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders configured routes inside a modal window and submits their forms over AJAX without a full page reload.

---

You list routes (one per line, optionally with parameters) on the settings form at `/admin/config/user-interface/route-in-modal`. A `hook_link_alter` implementation then adds the `use-ajax` class and `data-dialog-type=modal` attributes to any link pointing at a matching route, so clicking it opens the target in a Drupal core modal at the width/height you configured (per-route overrides via a `|width:...,height:...` suffix are supported, falling back to the module defaults). A `hook_form_alter` wraps forms rendered inside the modal, attaches an AJAX submit callback, and returns errors or a `RefreshPageCommand` in the dialog rather than reloading. `ModalRouteHelper` parses the configured route list and `RouteInModalAjaxHelper` builds the AJAX response.

Setup: enable the module, grant `administer route_in_modal`, and add the routes you want modal-ised on the settings form. The single route is admin-gated; the module changes only link markup and form rendering, adds no new endpoints.

---
- Open an admin or content route in a modal by adding it to the settings list.
- Submit a form inside the modal via AJAX with no page reload.
- Display validation errors inside the dialog instead of reloading.
- Show a confirmation message in the modal after a successful submit.
- Set a default dialog width/height for all modal routes.
- Override width/height for a single route with a `|width:600,height:400` suffix.
- Pass route parameters in the configured route string.
- Turn an existing "add entity" route into a modal without custom code.
- Keep users in context by editing records in an overlay.
- Refresh the underlying page after a modal form submits (RefreshPageCommand).
- Restrict who can configure modal routes via `administer route_in_modal`.
- Convert menu-link destinations into modal launchers automatically.
- Provide a lightweight modal workflow without writing JavaScript.
- Modal-ise multiple routes at once from one textarea.
- Style the dialog via the `route-in-modal` dialog class.
