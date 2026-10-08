# Configuration

All of Responsive menu's behaviour is stored in one place, and there are no
sub-entities to manage. Open the settings form at **Configuration → User
interface → Responsive menu** (`/admin/config/user-interface/responsive-menu`).
You need the **Administer site configuration** permission.

Remember that the form only *configures* the menus — nothing shows on the page
until you place the two blocks (see the end of this page).

## Choosing your menus

- **Horizontal menu** — the machine name of the menu rendered by the horizontal
  block on wider screens (default `main`).
- **Off-canvas menu(s)** — the menu(s) that feed the slide-in mobile panel
  (default `main`). You can list several menu machine names separated by commas
  and their trees are merged in order — handy for combining, say, a main menu and
  an account/utility menu into one mobile menu.
- **Horizontal menu depth** — how many levels deep the horizontal menu shows
  (1–9, default 9). The mobile off-canvas menu always shows every level.
- **Horizontal wrapping element** — whether the horizontal block is wrapped in a
  `nav` or a `div`.

## The breakpoint (where mobile switches to desktop)

- **Use breakpoint** — when on (default), the horizontal menu appears past a
  breakpoint and the burger icon shows below it. Turn it off to serve the mobile
  off-canvas menu at every screen size.
- **Horizontal breakpoint** — choose the breakpoint (by label) at which the
  horizontal menu takes over. The available choices come from your default
  theme's breakpoints. Selecting one through the form automatically stores the
  matching media query and generates a small breakpoint CSS file.

## Off-canvas panel appearance

- **Position** — where the panel slides in from: **left**, **right**, or
  **contextual** (left for left-to-right languages, right for right-to-left).
- **Theme** — the mmenu panel style: **light**, **dark** (default), **black**, or
  **white**.
- **Page dim** — dim the page behind the open panel: **none**, **page colour**
  (default), **white**, or **black**.
- **Drag to open** — enable a swipe/drag gesture so mobile users can drag the
  menu open.
- **Modify viewport** — when on (default), the viewport meta tag is rewritten as
  the menu opens, which fixes a Chrome mobile rendering quirk.

## CSS and theme wrappers

- **Include CSS** — load the module's bundled stylesheet (default on). Turn it off
  to style the menu entirely from your own theme.
- **Allow admin** — also load the responsive menu on admin-theme pages, not just
  the front end.
- **Admin wrapper** / **Theme wrapper** — mmenu needs a single wrapping element
  around the page. These options inject a page-wrapper div into the admin theme
  and/or your front-end theme for themes that lack one. (The admin wrapper option
  only appears when *Allow admin* is on.)
- **Bootstrap compatibility** — when on (default), makes a Bootstrap 4 navbar's
  menu icon open the off-canvas menu instead of the navbar's own collapse.
- **Polyfills** — load mmenu's polyfills for Internet Explorer 11 support.

## Superfish (optional horizontal-menu enhancement)

These apply only if you installed the Superfish library:

- **Superfish** — apply Superfish hover/flyout behaviour to the horizontal menu.
- **Delay** — milliseconds a submenu stays open after the mouse leaves (default
  300).
- **Speed in / Speed out** — fade-in and fade-out timing in milliseconds (default
  100 each).
- **HoverIntent** — use the HoverIntent plugin so submenus only open on a
  deliberate pause.

## Editing with Drush

Because everything lives in the single `responsive_menu.settings` config object,
you can also read and write settings from the command line:

```bash
drush cget responsive_menu.settings                 # show all settings
drush cset responsive_menu.settings off_canvas_menus main -y
```

## Place the two blocks

Config alone renders nothing. Go to **Structure → Block layout** and place:

- **Responsive menu mobile icon** — the burger toggle that opens the off-canvas
  panel.
- **Horizontal menu** — the horizontal drop-down bar (only visible past your
  chosen breakpoint).
