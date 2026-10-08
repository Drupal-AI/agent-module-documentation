Browser update (bu) integrates the third-party browser-update.org script to show an unobtrusive, dismissible notification asking visitors on outdated browsers to upgrade, with a settings form to control which browsers/versions trigger it, where it appears, and how the message looks.

---

The module has no dependencies beyond Drupal core and provides a single admin settings form at `/admin/config/system/browser-update` (route `bu.admin_settings`, gated by core's `administer site configuration`). `hook_page_attachments()` (`bu.module`) reads `bu.settings`, defaults the script source to `//browser-update.org/update.min.js` if unset, evaluates page visibility (a `visibility_pages` path list with show/hide `visibility_type`, matched via the path matcher, skipped when `test_mode` is on), and — where the popup should show — attaches the `bu/bu.checker` JS library plus all settings as `drupalSettings.bu`. The bundled `js/bu.js` hands those settings to the remote browser-update script, which does the actual browser sniffing client-side and renders the message. Settings (see `config/schema/bu.schema.yml`) include per-browser version thresholds (`notify_ie/firefox/opera/safari/chrome`, e.g. `-4` = "more than 4 versions behind"), toggles for insecure/unsupported/mobile browsers, screen `position` (top/bottom/corner), a `text_override` message template with `{brow_name}`/`{up_but}`/`{ignore_but}` placeholders, reminder intervals, a destination `url`, new-window and no-close options, and a `test_mode` that forces the message on every page (also triggerable by appending `#test-bu` to any URL). Config schema is provided; there are no permissions of its own, no Drush, and no plugins.

---

- Prompt visitors on outdated browsers to upgrade, using the maintained browser-update.org script.
- Set how many versions behind each browser (IE/Edge, Firefox, Opera, Safari, Chrome) triggers the message.
- Notify all browser versions with known severe security issues (`insecure`, on by default).
- Optionally notify browsers no longer supported by their vendor (`unsupported`).
- Optionally include or exclude mobile browsers (`mobile`).
- Restrict the notice to specific pages, or hide it on specific pages, via a path list.
- Hide the notice on admin pages (default `visibility_pages: admin/*`, type `hide`).
- Position the message at the top, bottom, or corner of the viewport.
- Override the message text with a custom template using `{brow_name}`, `{up_but}`, `{ignore_but}`.
- Send users to a custom destination URL when they click the notification.
- Open the update link in a new window.
- Hide the "Ignore" button to make the reminder harder to dismiss (`no_close`).
- Control how many hours before the message reappears (`reminder`, `reminder_closed`).
- Point the script `source` / `show_source` at a self-hosted or CDN copy instead of the default.
- Preview the notification on any page by appending `#test-bu` to the URL.
- Enable Test Mode to display the message on all pages while configuring it.
- Provide a lightweight, no-dependency way to nudge users off legacy browsers.
- Reduce support burden from bugs caused by very old browsers.
