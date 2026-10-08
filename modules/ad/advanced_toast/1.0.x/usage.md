<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Toast Messages shows temporary "toast" notifications built from Single Directory Components (SDC), triggerable from PHP, Twig or JavaScript, with an admin UI to map toast types to components.

---

Advanced Toast Messages is a component-based toast/notification system. It renders dismissible, auto-expiring notices in a fixed screen corner instead of (or alongside) Drupal's standard status messages. Toasts are built as Single Directory Components: the module ships base `toast`, `toast-status`, `toast-warning` and `toast-error` components, and themes/modules can add their own toast types and map them in the admin UI. Toasts are queued from PHP (`advanced_toast.toast` service), Twig (`toast()`, `toast_status()`, `toast_warning()`, `toast_error()` functions), or JavaScript (`Drupal.toast()`), rendered server-side through a lazy builder (so pages stay cacheable), passed to the browser via `drupalSettings`, and displayed by `js/toast-manager.js`. A settings form (`/admin/config/user-interface/advanced-toast`, permission `administer site configuration`) controls default duration, screen position, dismissibility, type-to-component mappings, and whether core Drupal messages are converted to toasts. Depends only on core SDC.

---

- Show dismissible, auto-expiring toast notifications.
- Replace Drupal's default status messages with toasts (opt-in).
- Trigger a toast from a PHP service (`$toast->status('Saved!')`).
- Trigger a toast from a Twig template (`{{ toast_status('Saved!') }}`).
- Trigger a toast from JavaScript (`Drupal.toast('Saved!', 'status')`).
- Use built-in status, warning and error toast types.
- Add a custom toast type (e.g. info, celebration) in a theme.
- Map a toast type to any SDC component via the admin UI.
- Set the default toast display duration (milliseconds).
- Choose the toast position (top/bottom, left/right/center).
- Make toasts dismissible or non-dismissible by default.
- Fall back to a base component when a custom one is missing.
- Pass extra props to custom components (`additional_props`).
- Override toast styles from a theme with `libraries-extend`.
- Extend a base toast template via SDC `{% include %}`.
- Keep pages fully cacheable while toast content stays per-session.
- Announce feedback to screen readers via ARIA live regions.
- Respect the user's reduced-motion preference.
- Show a persistent toast (duration 0, dismiss only).
- Provide consistent, modern notification UX across a site.
