<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Load Progress shows a full-screen lock overlay with a spinner/throbber when a page takes a long time to reload, so users know a time-consuming action (form submit, slow navigation) is in progress.

---

On configured triggers the module's JavaScript appends a `.page-load-progress-lock-screen` overlay with a throbber and sets `body { overflow: hidden }` after a configurable delay. By default it fires on the submit of any form containing an element matching the CSS selector `.page-load-progress-submit`; `template_preprocess_input()` automatically adds that class to non-AJAX submit buttons, so standard forms are covered out of the box. Optionally it can also lock the screen on internal-link clicks (skipping external links, `use-ajax`/toolbar/modal/new-tab links). Assets are attached via `hook_page_attachments` only for users holding the `use page load progress` permission and only on paths allowed by the visibility conditions (a path list with wildcard matching and a show/hide toggle; the Views admin UI is always excluded). A settings form controls the delay (immediate, 1/3/5 s), the visibility path conditions, the internal-links toggle, and whether the ESC key can dismiss the throbber. Config values are passed to the browser as `drupalSettings.page_load_progress`. Depends only on `core/jquery` and `core/drupal`.

---

- Show a loading spinner overlay when a long form (import, report) is submitted.
- Reassure users during a slow save/checkout by locking the screen with a throbber.
- Delay the throbber 1/3/5 seconds so it only appears on genuinely slow actions.
- Show the throbber immediately on submit for very slow operations.
- Also show the throbber when users click internal links to slow pages.
- Limit the throbber to specific paths (e.g. only `/checkout`, `/reports/*`).
- Exclude specific paths from the throbber using the negate ("hide for listed pages") toggle.
- Use `<front>` and `/user/*` style wildcards in the visibility path list.
- Restrict who sees the throbber via the `use page load progress` permission.
- Let users cancel the overlay with the ESC key when a request hangs.
- Target custom elements by adding the `.page-load-progress-submit` class to them.
- Trigger the lock on any custom CSS selector by configuring the elements setting.
- Avoid triggering on AJAX form buttons (excluded automatically).
- Avoid triggering on modal/`use-ajax`/new-tab links.
- Provide consistent "working…" feedback across an admin site.
- Prevent double-submits by visually locking the page during processing.
- Keep the Views UI usable (its admin paths are always excluded).
- Give anonymous or specific roles the feedback by granting them the permission.
- Theme the overlay/throbber via `css/page_load_progress.theme.css`.
