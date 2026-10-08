Superfish turns any Drupal menu into a multi-level dropdown/flyout navigation block using the jQuery Superfish plugin, with extensive per-block styling and behavior options.

---

Superfish provides a **Superfish block** (a block plugin derived per menu, like core's menu blocks) that renders a chosen menu as an animated, multi-level dropdown or fly-out navigation. Each block instance has a rich configuration form covering starting level and depth, horizontal/vertical/navbar menu types, built-in styles, hover/animation speed and delay, drop shadows, arrows on parent items, and slide-in effects. It integrates the Superfish jQuery library's add-ons — Supposition (keeps sub-menus on screen), hoverIntent (smarter hover detection), and a comprehensive Touchscreen mode with breakpoints and user-agent detection for mobile/responsive behavior. The markup is rendered through overridable Twig templates (`superfish.html.twig`, `superfish-menu-items.html.twig`), so themers can fully customize output. Configuration is stored per block instance (`block.settings.superfish:*`) and is exportable as config. It ships a menu-tree manipulator for translated menu links and a hook to alter the tree manipulators used. The external JS/CSS comes from the `lobsterr/drupal-superfish` library installed via Composer. It has no global admin page — you configure it when placing or editing a Superfish block.

---

- Turn a main menu into a horizontal dropdown navbar.
- Build a vertical multi-level sidebar menu with flyouts.
- Create a navbar-style menu with dropdown sub-items.
- Show deep menu hierarchies as nested fly-out panels.
- Limit the menu to start at a given level (e.g. show only sub-menus).
- Cap the number of levels displayed with a depth setting.
- Add hover arrows to parent menu items.
- Apply drop shadows to sub-menus.
- Tune animation speed and mouse hover delay.
- Add a slide-in effect to opening sub-menus.
- Keep off-screen sub-menus in view with jQuery Supposition.
- Use hoverIntent for smoother, less twitchy hover behavior.
- Enable touchscreen support for mobile dropdowns.
- Set a breakpoint to switch behavior on small screens.
- Detect specific user agents for touch handling.
- Pick a built-in visual style for the menu.
- Expand all menu items regardless of active trail.
- Render a secondary/footer menu as a dropdown block.
- Deploy menu block styling between environments as config.
- Support translated menu links in multilingual sites.
- Customize the menu markup via overridable Twig templates.
- Place multiple differently-configured Superfish blocks per menu.
- Provide accessible keyboard-friendly dropdown navigation.
- Alter the menu tree manipulators via a hook in custom code.
