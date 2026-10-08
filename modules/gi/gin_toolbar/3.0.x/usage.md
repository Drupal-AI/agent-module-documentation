Gin Toolbar is a helper module that brings the styled Gin administration toolbar/navigation into the front end of your site so logged-in users see the Gin-themed admin toolbar everywhere, not just on admin pages.

---

The Gin admin theme restyles Drupal's backend, but because admin themes cannot fully control the toolbar that appears on front-end (non-admin) pages, Gin needs this companion module to render its toolbar consistently across the whole site. Gin Toolbar hooks into Drupal's theme system — overriding the `toolbar`, `menu__toolbar`, `navigation`, and `top_bar` templates and re-pointing them at its own copies via `hook_theme_registry_alter()` — and attaches Gin's CSS/JS libraries (base, accent, init, dark mode, and the classic/horizontal/new toolbar variants) through `hook_page_attachments_alter()`. It reads the active Gin theme settings (accent color, focus color, dark mode, high-contrast mode, toolbar variant) and exposes them as `data-` attributes and `drupalSettings` so the front-end toolbar matches the backend exactly. It also supports Drupal's newer Navigation module and the experimental "new" navigation, reorganizes toolbar tabs (moving search to the front and the user menu to the end), and adds active-trail highlighting to the administration tray via a custom render callback and menu active-trail service. The module only activates when Gin (or a Gin subtheme) is set as the admin or default theme and the user has the `access toolbar`/`access navigation` permission, so it is inert for anonymous visitors on non-Gin sites. It requires no configuration of its own — all appearance options come from the Gin theme's settings. In short, it is the glue that makes the Gin toolbar a site-wide experience rather than an admin-only one.

---

- Show the Gin-styled admin toolbar on front-end pages for logged-in editors.
- Keep the toolbar visually consistent between backend and frontend.
- Carry Gin's accent color into the front-end toolbar via `data-gin-accent`.
- Carry Gin's focus color into the front-end toolbar via `data-gin-focus`.
- Enable Gin dark mode on front-end pages for authenticated users.
- Apply Gin high-contrast mode site-wide.
- Use the classic vertical Gin toolbar variant across the site.
- Use the horizontal Gin toolbar variant across the site.
- Adopt the experimental "new" Drupal navigation styled by Gin.
- Integrate with core's Navigation module for the left sidebar menu.
- Style the maintenance page with Gin's look while the site is offline.
- Provide a Gin-styled top bar (Drupal 11 top bar) on the front end.
- Show active-trail highlighting in the administration menu tray.
- Support deep admin menu trees when Admin Toolbar is installed (configurable depth).
- Move the toolbar search tab to the start of the toolbar.
- Move the user account tab to the end of the toolbar.
- Add per-item icon classes to toolbar menu links.
- Push the Configuration and Help menu items to the end of the admin menu.
- Render the user picture/avatar in the toolbar via a lazy builder.
- Add an "edit" shortcut for the current entity from the toolbar.
- Apply Gin styling to CKEditor via injected editor CSS.
- Apply Gin styling to modal dialogs, AJAX, and the Media Library.
- Style Workbench Moderation's toolbar with Gin.
- Wrap node preview forms in Gin's layout container.
- Load a custom `gin-custom.css` override file automatically when present.
- Remove core's redundant toolbar requirement warning.
- Give a Gin subtheme the same site-wide toolbar treatment as Gin itself.
- Present a secondary front-end toolbar when enabled in Gin settings.
