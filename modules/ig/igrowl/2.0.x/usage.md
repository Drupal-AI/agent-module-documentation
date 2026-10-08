<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
iGrowl makes the iGrowl JavaScript library available to a Drupal site and exposes a custom Ajax command so server-side code can pop growl-style (toast) notifications in the browser.

---

The module registers the iGrowl library via `igrowl.libraries.yml` and ships a `GrowlCommand` Ajax command (`src/Ajax/GrowlCommand.php`) that other modules/forms can return from an Ajax response to render an animated notification with configurable title, message, icon, animation and placement. It is a front-end presentation helper: developers attach the library and dispatch the command; there is no admin UI or stored configuration.

This is a JavaScript-library/notification utility with no access-control role. Notification content originates from the code that dispatches the command, so callers are responsible for not passing untrusted markup into notification text. The module itself defines no routes or permissions.

---

- Show growl-style toast notifications in the browser.
- Make the iGrowl JS library available as a Drupal library.
- Trigger notifications from server-side Ajax responses.
- Return a `GrowlCommand` from an Ajax callback.
- Configure notification title and message.
- Set an icon for the notification.
- Choose animation and placement options.
- Provide user feedback after an Ajax action.
- Replace default status messages with animated toasts.
- Attach the library to a render array.
- Build interactive UI feedback without custom JS.
- Reuse the command across multiple forms.
- Add no configuration or admin overhead.
- Keep notifications purely client-side.
- Integrate with Drupal's Ajax framework.
- Enhance UX for form submissions and events.
