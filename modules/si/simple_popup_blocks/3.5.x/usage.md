Simple Popup Blocks turns any Drupal block, form, view, or custom `div` into a popup/modal by targeting it with a CSS selector — each popup is a `simple_popup_blocks.popup_<uid>` config object with its own trigger, layout, and frequency settings.

---

You create popups from an admin form at `/admin/config/media/simple-popup-blocks/add` (route `simple_popup_blocks.add`, gated by the `administer simple_popup_blocks` permission). Each popup is saved as a standalone config object named `simple_popup_blocks.popup_<uid>` (schema `simple_popup_blocks.*`); there is no popup content of the module's own — you point it at existing markup. A popup either targets a **Drupal block** (`type: 0`, `identifier` = a block config id, wrapped as `block-<id>` at render) or a **custom CSS id/class** (`type: 1`, `identifier` = a bare selector name, with `css_selector` choosing `.` class or `#` id). You pick one of ten screen **layouts** (`layout` 0-9: corners, center, top/bottom/left/right bars), a **trigger method** (`trigger_method` 0 automatic after `delay` seconds, 1 manual on click of `trigger_selector`, 2 before browser/tab close), and display **frequency** (a serialized `visit_counts` list, or a `time_frequency` of hourly/daily/weekly when `use_time_frequency` is on). Booleans control the `overlay`, `close` / `minimize` / `show_minimized_button` buttons, and `enable_escape` (ESC to close); `width`, `cookie_expiry`, and `status` round it out. On every non-admin page the module's `hook_page_attachments()` loads all enabled (`status: 1`) popup configs and hands them to `js/simple_popup_blocks.js` via `drupalSettings`. The module ships **no default popup styling** — the edit form lists the generated CSS selectors (e.g. `.<id>-modal`, position classes) for you to style in your theme. Remember to clear caches after creating or editing a popup. Manage/edit/delete existing popups at `/admin/config/media/simple-popup-blocks/manage`.

---

- Show a newsletter signup block as a centered modal on a visitor's first visit.
- Turn a "Subscribe" webform into an automatic popup after a 5-second delay.
- Display a cookie/GDPR notice as a bottom bar on every page load.
- Pop up a promotional banner block in the top-right corner.
- Show a discount offer just before the visitor closes the browser tab (exit intent).
- Open a custom `div` as a modal when a specific button or link is clicked.
- Present a "Welcome back" message only on a visitor's third visit using `visit_counts` = 3.
- Throttle a popup to appear at most once per day with time frequency (`time_frequency` 86400).
- Show a survey block weekly to returning visitors.
- Display a full-screen overlay announcement using the center layout with overlay enabled.
- Turn any View block into a slide-in panel from the left or right bar layout.
- Add a minimize button so users can collapse a chat/contact popup instead of closing it.
- Let users dismiss a popup with the ESC key.
- Keep a popup dismissed for 100 days by setting a long `cookie_expiry`.
- Re-show a popup every browser session by setting `cookie_expiry` to 0.
- Trigger a popup only on desktop by setting a `trigger_width` breakpoint.
- Convert a menu block into a click-triggered off-canvas style modal.
- Show a login block as a modal for anonymous users.
- Display an age-verification gate as a center overlay before content is shown.
- Promote an event with a top-bar popup that appears on the first two visits (`visit_counts` = 1,2).
- Style each popup independently using the per-popup CSS selectors shown on its edit page.
- Manage several popups at once (enable/disable, edit, delete) from the Manage page.
- Point a popup at a block by its config id (`type: 0`) without touching custom markup.
- Point a popup at an arbitrary theme element by CSS class (`type: 1`, `css_selector: 0`).
- Toggle a popup on or off site-wide by flipping its `status` flag with drush.
