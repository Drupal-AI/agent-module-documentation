<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Confetti plays a client-side confetti animation on selected pages.

---

Confetti **shows an on-screen confetti burst when a visitor loads a page whose path an admin has
listed** in the module's settings. The effect fires automatically on page load (about half a second
after the page renders, for roughly six seconds) — there is no form-submission, event, or JavaScript
trigger to wire up. It is a purely decorative front-end touch built on the external
[canvas-confetti](https://github.com/catdad/canvas-confetti) library, which the module loads from a
CDN at runtime.

Configure it at `/admin/confetti` (permission **`edit confetti configuration`**): add one or more
URL sub-paths (each must start with `/`, e.g. `/thank-you` or `/node/1`), then Save. The current
path and its alias are matched by exact string equality against that list. The confetti colors,
duration, and particle behaviour are hardcoded in `js/confetti.js`; changing them means editing that
file. It has no content or access-control role beyond its one configuration permission.

---

- Play a confetti animation on chosen pages.
- Trigger the effect on page load, not on an event.
- Match pages by exact URL path (or alias).
- Configure which paths show confetti at `/admin/confetti`.
- Gate configuration behind `edit confetti configuration`.
- Store the path list in `confetti.settings:confetti_urls`.
- Load the canvas-confetti library from a CDN.
- Run the burst client-side for ~6 seconds.
- Provide a decorative UX touch.
- Add no server load and create no content.
- Have no content or access role beyond its permission.
- Customize visuals only by editing `js/confetti.js`.
- Invalidate a target node's cache tags when its path is added or removed.
- Remove the effect by clearing the path or uninstalling.
