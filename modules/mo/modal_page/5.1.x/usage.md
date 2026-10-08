Modal (modal_page) lets site builders create configurable dialog/pop-up windows — announcements, notifications, cookie notices, lightboxes or fully custom content — that appear on chosen pages, targeted by path, role and language, without writing code.

---

Each modal is a `modal` config entity (config prefix `modal`, so config names
`modal_page.modal.<id>`), managed at *Structure → Modal* (`/admin/structure/modal`,
route `entity.modal.collection`) and created/edited via `ModalForm`. A modal carries a rich
set of options exposed as entity keys: `label` (title), `body` (a formatted text value with a
filter format), `pages` (paths to show on, supports wildcards and `<front>`), `type`
(`page` or `parameter`), `roles` and `languages_to_show` (audience targeting), `auto_open`,
`open_modal_on_element_click` (open on click of a CSS selector), size (`modal_size`:
`modal-sm`/`modal-md`/`modal-lg`), header/footer/button toggles and CSS classes, a
"don't show again" cookie option with custom expiration, ESC-key / click-outside close
behavior, optional redirect link, auto-hide, show-once, an embedded `modal_video_link`, and
scheduling via `publish_on` / `unpublish_on` timestamps. Global behavior is a
`modal_page.settings` config object (route `modal_page.settings` at
`/admin/config/user-interface/modal-page/settings`): whether to auto-load Bootstrap (and which
version, 3x/5x), the `allowed_tags` for modal bodies, whether to clear caches on modal save,
and the default cookie expiration. The front-end is delivered by `ModalPageService` (which
decides which modals to show for the current path/role/language) plus JS libraries and a small
CSS file; AJAX submit and Bootstrap-enable endpoints live in controllers. The module defines
one permission, `administer modal page` (gates all routes and is the entity admin permission),
a Drush command `modal_page:cron` (aliases `modal-page-cron`) that runs the scheduler
(`ModalPageScheduler`) to publish/unpublish scheduled modals, and hooks
`hook_modal_alter()` / `hook_modal_ID_alter()` / `hook_modal_submit()` for altering modals and
handling modal form submits. It depends on core `filter` and `datetime`.

---

- Show a site-wide announcement or promotion in a dialog on selected pages.
- Display a cookie-consent / GDPR notice with a "don't show again" option.
- Pop up a welcome or onboarding message for authenticated users.
- Present terms-of-service or important-update notices that users must acknowledge.
- Target a modal to specific paths using `pages` (wildcards like `/blog/*` or `<front>`).
- Restrict a modal to certain user roles via the `roles` setting.
- Show different modals per language using `languages_to_show`.
- Auto-open a modal on page load (`auto_open`) or open it when a CSS element is clicked.
- Embed a video in a modal via `modal_video_link`.
- Schedule a modal to appear and disappear between dates using `publish_on` / `unpublish_on` + the `modal_page:cron` Drush command.
- Show a modal only once per visitor using the show-once / cookie option.
- Set a custom cookie expiration so a dismissed modal stays hidden for a chosen time.
- Choose the modal size (small / medium / large).
- Add OK, Dismiss (left) and top-right X buttons with custom labels and CSS classes.
- Redirect the user to a URL when they accept the modal (`redirect_link`).
- Auto-hide a modal after a delay.
- Close the modal on ESC key or by clicking outside.
- Style the modal, header and footer with custom CSS classes.
- Let Bootstrap be loaded automatically (v3 or v5) or rely on the theme's own Bootstrap.
- Render sanitized HTML in the body limited to the configured `allowed_tags`.
- Run modal AJAX submit handling via `hook_modal_submit()` for custom server-side logic.
- Alter a modal's title/body at runtime with `hook_modal_alter()` / `hook_modal_ID_alter()`.
- Build a fully custom-content dialog (marketing splash, newsletter signup prompt, etc.).
- Manage all modals from one admin list at Structure → Modal.
