<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SweetAlert (sweetalert) — agent index

Integrates **SweetAlert2** as a Drupal **AJAX command**. Version **2.0.1**, core `^9 || ^10`. No module deps; needs the SweetAlert2 JS library at `/libraries/sweetalert2` (install check).

**Shape:** `SweetAlertCommand` (CommandInterface + CommandWithAttachedAssetsInterface) → `render()` emits `{command:'sweetalert', settings:{options}}`, attaches library `sweetalert/command` (dep `core/drupal.ajax`); `js/command.js` calls `Swal.fire(options)`. Add it to any `AjaxResponse`.

**Sandbox:** demo form `SandboxForm` at `/admin/config/user-interface/sweetalert/sandbox` (route `sweetalert.sandbox`, *administer site configuration*). No persisted config, no own permissions. Developer building block; nothing untrusted or anon-exposed.
