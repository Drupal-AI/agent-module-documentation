<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Driplet Notify (driplet_notify) — agent index

Driplet example submodule: real-time toast notifications. Depends on `driplet:driplet`. Package
`Driplet`. Core `^10 || ^11`. Version 1.0.2. No routes, permissions, config, services, or schema —
it is all hooks + a JS behavior.

## What it provides

- **`driplet_notify.module` hooks**: `hook_node_insert/update/delete` and `hook_rebuild()` send
  Driplet messages on the `driplet-notify` topic via `\Drupal::service('driplet.service')`;
  `hook_page_attachments_alter()` attaches library `driplet_notify/notify`; `hook_page_bottom()`
  injects `<div id="driplet-notify-wrapper">`.
- **Library** `driplet_notify/notify` (`js/notify.js` + `css/notify.css`), depending on
  `driplet/driplet`.

## How it works

- **Details** → [api/notify.md](api/notify.md)
- Node CRUD → `notify-persist` cards targeted at role `authenticated`.
- Cache rebuild → `notify` (timed) card targeted at role `administrator`.
- `js/notify.js` (`Drupal.behaviors.dripletNotify`) subscribes to `driplet-notify` and renders each
  message as a dismissible card in the wrapper.
