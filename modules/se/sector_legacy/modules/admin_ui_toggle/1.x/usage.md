Admin UI Toggle provides a single Drupal block whose button hides or shows the admin UI chrome on the front end by toggling a body CSS class.

---

Admin UI Toggle (`admin_ui_toggle`) is a submodule of Sector Legacy that exposes one block plugin (`admin_ui_toggle`, admin label "Sector blocks - Admin UI toggle"). When placed, the block renders a small `<button>` inside a `.admin-ui-toggle` wrapper. Its attached JavaScript (`js/admin_ui_toggle.js`, a `Drupal.behaviors.admin_ui_toggle`) listens for clicks on the button and toggles the `admin-ui-hide` class on `<body>`, also flipping a `ui-is-hidden` class on the toggle itself so the button can show its current state. The module ships a small CSS component (`css/admin-ui-toggle.css`) and a Twig template (`admin-ui-toggle.html.twig`). It depends on core `block` and, for its library, on `core/jquery`, `core/jquery.once`, and `core/drupal`. It stores no data, defines no routes/permissions/config, and simply relies on theme CSS keyed off the `admin-ui-hide` body class to hide whatever admin decorations the theme chooses.

---

- Place the "Sector blocks - Admin UI toggle" block in a region to give editors a one-click show/hide of admin chrome while previewing a page.
- Let content editors see a page approximately as an anonymous visitor would, without logging out.
- Toggle the `admin-ui-hide` body class so theme CSS can hide admin-only decorations (edit tabs, contextual affordances, admin styling).
- Provide a persistent front-end preview affordance on Sector distribution themes.
- Give designers a quick way to check front-end layout without admin UI elements shifting the page.
- Pair with a Sector/Radix theme that defines the `.admin-ui-hide` styling rules.
- Use as a lightweight alternative to opening an incognito window for a rough front-end preview.
- Add the toggle to an admin-only region so only privileged users see the control.
- Demonstrate a minimal block plugin that attaches a behavior library (jQuery-based) in a Drupal 10/11 module.
- Reuse the CSS class contract (`admin-ui-hide` on body, `ui-is-hidden` on the toggle) in a custom theme.
- Enable independently of the other Sector Legacy submodules when only the toggle is wanted.
- Serve as a teaching example of `hook_theme()` with a `render element` and an attached library.
- Give editors a fast toggle during content review sessions or screenshots.
- Provide a front-end "focus mode" that removes admin visual noise.
- Combine with `sector_utils` and `sector_blocks` for the full legacy Sector editor experience.
