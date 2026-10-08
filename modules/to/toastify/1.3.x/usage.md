Toastify renders Drupal's status/warning/error messages as animated "toast" pop-ups using the vanilla-JS toastify-js library instead of the default inline message boxes.

---

Toastify integrates the bundled toastify-js library and re-routes Drupal messages to it. It swaps the core `status_messages` render element for `ToastifyStatusMessages` (via `hook_element_plugin_alter`) and overrides `Drupal.theme.message` (the client-side messages API), so both server-rendered and JavaScript-added messages appear as toasts. A single admin settings form (`toastify.settings`, at `/admin/config/user-interface/toastify`) configures per-type (status / warning / error) look and behaviour: duration, gravity (top/bottom), position (left/right/center), X/Y offset, an optional close button, and — when not using the Gin admin theme — the gradient colors, gradient direction and progress-bar color. Two toggles under "Enable for" decide whether toasts appear on the admin theme, the frontend theme, or both. Toasts are only shown to users whose role holds the `show toastify messages` permission; without it Drupal's normal messages render. The module detects the Gin theme and loads a Gin-specific stylesheet (hiding the color fields, which Gin controls). All settings are exposed to the browser through `drupalSettings.toastify.settings` and consumed by `Drupal.toastify.getDefaultSettings()`.

---

- Replace Drupal's default status message boxes with animated toast pop-ups site-wide.
- Show a green "saved" toast in the top-right corner after a content editor submits a node form.
- Display validation errors as red toasts that auto-dismiss after a configurable duration.
- Give warning messages a distinct color and a manual close button so they stay until dismissed.
- Enable toasts only in the admin theme so the public frontend keeps standard messages.
- Enable toasts only on the frontend theme for a friendlier end-user experience.
- Move toasts to the bottom-center of the screen on a mobile-first site.
- Extend how long important messages stay on screen by raising the per-type duration (ms).
- Offset toasts away from a fixed header or admin toolbar using X/Y offsets.
- Restrict toast notifications to trusted roles via the `show toastify messages` permission.
- Theme status, warning and error toasts with different gradient colors to reinforce severity.
- Automatically match Toastify's styling to the Gin admin theme without configuring colors.
- Surface JavaScript-triggered messages (`Drupal.message().add()`) as toasts through the overridden `Drupal.theme.message`.
- Provide non-blocking feedback on AJAX form submissions instead of full-page message blocks.
- Add a progress bar to toasts so users see the remaining time before auto-dismiss.
- Use a color-picker widget for the toast colors when the jquery_colorpicker module is installed.
- Standardise notification styling across an editorial workflow.
- Keep the message area from pushing page content down (toasts float above content).
- Configure a right-to-left gradient direction for branded notifications.
- Turn Toastify off temporarily by revoking the permission or disabling both "Enable for" toggles.
- Export the toast configuration (`toastify.settings`) with the site's config for consistent deployment.
