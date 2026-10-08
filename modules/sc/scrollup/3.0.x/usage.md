<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scrollup adds a floating "scroll to top" button that appears once a visitor has scrolled down a long page and smooth-scrolls back to the top when clicked.

---

The module needs no theme code: a `hook_preprocess_page` implementation attaches a small vanilla-JavaScript behavior and a stylesheet to every page rendered with a selected theme, and the button is injected into the `<body>` client-side. A settings form at `/admin/config/system/scrollup` (permission `administer site configuration`) writes a single config object, `scrollup.settings`, controlling the button label, its side (left/right, RTL-aware), background and hover colors, the scroll offset after which it appears, the scroll speed, and which installed themes display it. It depends on nothing beyond core and targets `^10.3 || ^11.0`. Because the control is purely presentational and injected the same way on every page of a selected theme, configuration is site-wide rather than per-page; teams that need finer visibility or accessible-name/reduced-motion guarantees should plan to override the CSS and markup in their own theme.

---

- Add a back-to-top button to long pages.
- Improve navigation on mobile where scrolling is tedious.
- Help visitors return to the top menu quickly.
- Show the button only after a set scroll distance.
- Choose whether the button sits on the left or right.
- Match the button's background color to a theme.
- Change the hover color of the button.
- Rename the button label from "Scroll up".
- Restrict the button to specific themes only.
- Enable the button on the front-end theme but not the admin theme.
- Improve usability on a long documentation page.
- Reduce swiping on long-form articles.
- Support readers of long policy or legal documents.
- Add a familiar UI convention without writing JavaScript.
- Improve a long product listing or archive page.
- Speed up or slow down the smooth scroll animation.
- Configure appearance centrally from one settings form.
- Add the control without touching theme templates.
- Help users on a long single-page site return to navigation.
- Provide a consistent scroll-to-top across a multi-theme site.
- Reduce friction on a long checkout or registration form.
- Set the scroll threshold higher on pages with a tall header.
- Give a mobile-first audience an easy way back to the top.
- Restyle the button by overriding `.scrollup` in a custom theme.
