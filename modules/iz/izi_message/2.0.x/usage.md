<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Izi Message replaces Drupal's in-page status/warning/error message block with iziToast pop-up toasts, so a save confirmation or validation notice appears as a light, animated notification instead of a strip of text at the top of the page.

---

The module overrides core's `status_messages` render element (via `hook_element_info_alter`), pulls whatever the messenger is holding, and re-renders it into hidden markers that a small JS behavior feeds to the third-party iziToast library as toasts. A single settings form at `/admin/config/development/izi_message/settings` (permission `administer site configuration`) writes one config object, `izi_message.settings`, whose keys are iziToast options — position, timeout, theme, max width, font sizes, drag/close behaviour, progress bar, overlay, and open/close animations (including separate mobile transitions) — and `hook_preprocess_page` exposes that config to the browser as `drupalSettings.iziMessage`. It has no module dependencies and a core range of `^9.3 || ^10 || ^11`, but it does need the iziToast v1.4.0 library unpacked at `/libraries/iziToast/`; until that file exists, `hook_requirements` blocks the module with a "Library not detected" error. The considerations are accessibility rather than aesthetics: a transient toast must land in an appropriate ARIA live region to reach a screen reader, the timeout must be long enough to read, and error/validation messages ideally should not auto-dismiss — those are exactly the ones a user re-reads while correcting a form (set `timeout` to `0` for no auto-close). A common, sensible scoping is to apply the treatment to the admin theme only so editors get improved confirmations while front-end validation keeps core's persistent behaviour.

---

- Show status messages as light iziToast notifications.
- Confirm a save without scrolling back to the top of the page.
- Improve feedback on long forms where the message region is off-screen.
- Give an application-style, non-blocking message experience.
- Configure toast position (top/bottom, left/right/center).
- Set how long a toast stays before auto-closing (`timeout`).
- Keep messages visible until dismissed (`timeout` = 0).
- Choose a light or dark toast theme.
- Set title and message font sizes.
- Cap toast width with `maxWidth`.
- Enable drag-to-dismiss and a close ("x") button.
- Show a timeout progress bar on each toast.
- Pause or reset the timeout while the pointer is over a toast.
- Pick open/close animations, with separate mobile transitions.
- Show a page overlay behind toasts and optionally close on overlay click.
- Support right-to-left layouts.
- Reduce layout shift caused by core's message block.
- Apply the treatment to the admin theme only.
- Show queued messages after a redirect as toasts.
- Support a site still on Drupal 9.3.
