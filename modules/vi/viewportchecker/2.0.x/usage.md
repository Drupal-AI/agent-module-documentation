<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery-viewport-checker attaches the jQuery-viewport-checker JS library to the site so elements gain classes (e.g. to trigger CSS animations) when they enter the viewport. An admin can attach the library site-wide or restrict it to include/exclude specific paths, and choose the compressed or uncompressed build.

---

This is a front-end library integration with a single admin settings form gated by the `administer viewportchecker configuration` permission (marked `restrict access: true`). Page attachment uses core's `request_path` condition plugin against admin-entered path patterns — no user-supplied input is rendered, and there is no dynamic route, controller or data endpoint. The main hardening note is operational: the "uncompressed library" (devel) toggle should stay off in production. No security-relevant sink (no XSS/SSRF/SQLi/access surface beyond the admin form).

---

- Trigger CSS animations as elements scroll into view.
- Add reveal/fade-in effects without custom JS.
- Attach the viewport-checker library site-wide.
- Limit the library to specific pages by path.
- Exclude the library from listed paths instead.
- Use path wildcards (e.g. `/user/*`) for targeting.
- Serve the minified library on production.
- Switch to the uncompressed build for debugging only.
- Restrict configuration to a dedicated admin permission.
- Drive scroll-based UI without a heavy animation framework.
- Enhance landing pages with on-scroll motion.
- Integrate the library via Drupal's asset system.
- Toggle include vs exclude path visibility logic.
- Keep the devel build off in live environments.
- Pair with theme CSS classes to define the animations.
- Apply effects to marketing or story pages selectively.
- Manage everything from one settings form.
