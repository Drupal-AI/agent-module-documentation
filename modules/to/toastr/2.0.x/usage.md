<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toastr renders Drupal's status, warning and error messages as toastr.js "toast" notifications — the small transient panels that slide in and fade out — instead of as a block of text in the theme's status-messages region.

---

The module attaches its JavaScript on every page and, in `hook_js_settings_alter`, pulls all queued messages out of Drupal's Messenger (`deleteAll()`) so they no longer render normally; it hands them to the browser via `drupalSettings.toastr` together with the configured options, and a `Drupal.behaviors.toastrMessages` behaviour calls `toastr.success/warning/error()` for each one (Drupal's `status` type maps to a green `success` toast). A settings form at `/admin/config/system/toastr`, behind the `administer toastr` permission, exposes almost every toastr.js option — position, default timeouts, extended (hover) timeout, show/hide durations, easing and jQuery show/hide methods, close button, progress bar, newest-on-top, prevent-duplicates, tap-to-dismiss, and a "do not hide error messages" toggle that pins warning and error toasts open until dismissed. Values are stored in the `toastr.settings` config object (with schema) and fall back to `ToastrSettingsForm::defaultSettings()` when unset. Dependencies are core only (`^9 || ^10 || ^11`); the toastr.js library itself is loaded from the cdnjs CDN rather than bundled, so toasts require both JavaScript and network access to that CDN. Because messages are removed from the normal region, the built-in "Status messages" block can be dropped from the layout.

---

- Show status messages as toast notifications instead of a page-top block.
- Confirm a save without scrolling back to the top of a long form.
- Give an application-style, non-blocking message experience.
- Position notifications in a screen corner or full-width band.
- Auto-dismiss informational (status/success) toasts after a timeout.
- Keep warning and error toasts on screen until the user closes them.
- Configure the display timeout centrally for all messages.
- Extend how long a toast stays after the user hovers over it.
- Add a close button and/or a progress bar to each toast.
- Stack the newest toast on top of older ones.
- Prevent duplicate toasts with identical content.
- Enable tap/click-anywhere to dismiss a toast.
- Choose the show/hide animation easing and jQuery method.
- Tune show and hide animation durations.
- Show AJAX/queued messages that arrive after a redirect as toasts.
- Reduce layout shift caused by an inline message block.
- Give editors clearer, consistent save confirmation.
- Turn `messenger()->addStatus/addWarning/addError()` calls into toasts automatically.
- Remove the "Status messages" block from Block layout.
- Restrict who can change toast behaviour via the `administer toastr` permission.
- Match an admin theme's interaction style with corner notifications.
- Provide feedback on a dashboard or bulk-action page.
- Support sites still on Drupal 9 through 11.
