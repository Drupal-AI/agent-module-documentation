<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery ScrollUp integrates the jQuery ScrollUp plugin to add a smooth "back to top" button that appears as the visitor scrolls down the page, with appearance and behavior configurable through an admin settings form.

---

The module attaches the ScrollUp JS library site-wide and exposes settings at `/admin/config/user-interface/jquery_scrollup` (permission `access jquery scrollup settings`) for options such as button text/image, scroll distance, animation and theme. An `api.php` documents alter hooks for further customization.

This is a front-end UI enhancement. Its single permission gates only the settings form; the button itself is a purely client-side convenience with no access-control role, and the module defines no data routes.

---

- Add a smooth back-to-top button.
- Show the button after scrolling down.
- Configure button text or image.
- Set the scroll distance that reveals the button.
- Choose the scroll animation style.
- Apply a theme/appearance to the button.
- Enable the button site-wide.
- Gate settings behind a dedicated permission.
- Improve navigation on long pages.
- Attach the ScrollUp JS library automatically.
- Customize behavior via documented alter hooks.
- Provide a lightweight UX enhancement.
- Configure through an admin form.
- Require no content changes.
- Support keyboard/mouse smooth scrolling.
- Add no data routes of its own.
