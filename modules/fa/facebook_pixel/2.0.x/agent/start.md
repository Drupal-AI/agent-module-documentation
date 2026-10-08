<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facebook Pixel — agent index

One config object, one settings form, one service, one Ajax command, one alter hook, two
permissions. No plugin types, no Drush, no entities.

- **All `facebook_pixel.settings` keys, the visibility/privacy logic, the form, Drush
  recipes** → [configure/settings.md](configure/settings.md)
- **`facebook_pixel.facebook_event` service, the automatic events, the Ajax command, the
  JS contract** → [api/events.md](api/events.md)
- **`hook_facebook_pixel_event_data_alter()`** → [hooks/event-data-alter.md](hooks/event-data-alter.md)
- **Permissions and the admin route** → [permissions/permissions.md](permissions/permissions.md)
- **Drupal Commerce events (AddToCart, InitiateCheckout, Purchase)** → submodule
  [`facebook_pixel_commerce`](../../modules/facebook_pixel_commerce/2.0.x/agent/start.md)

Quick facts:

| Thing | Value |
|---|---|
| Config object | `facebook_pixel.settings` (has a proper `config_object` schema) |
| Configure route / path | `facebook_pixel.facebook_pixel_config_form` → `/admin/config/facebook_pixel` |
| Permissions | `configure facebook_pixel`, `use php for page_visibility` |
| Service | `facebook_pixel.facebook_event` → `Drupal\facebook_pixel\FacebookEvent` |
| Libraries | `facebook_pixel/facebook_pixel` (header), `facebook_pixel/facebook_pixel_command` |
| Auto events | `PageView` (JS), `ViewContent` (node, default/full view mode), `CompleteRegistration` (user insert) |
| Alter hook | `hook_facebook_pixel_event_data_alter(array &$data, string $event)` |
| Migration | `d7_facebook_pixel_settings` (D7 `facebook_pixel_id` → `facebook_id`) |

Gotcha: the `<noscript>` pixel image emitted by `hook_page_top()` bypasses **all** visibility
and privacy checks except `privacy.disable_noscript_img` and an empty `facebook_id`.
