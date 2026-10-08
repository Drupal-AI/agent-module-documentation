Design System adds an admin-toolbar link that opens your design system (or any configured URL) inside an iframe on a Drupal admin page, so editors and developers can view it without leaving the site.

---

The module is a thin convenience wrapper: it registers a single configurable URL (`design_system.settings:design_system_url`, defaulting to the internal path `internal:/storybook/`), exposes an admin route at `/admin/design-system` that renders that URL in a full-height iframe, and adds "Design System" entries to both the core administration menu and the admin toolbar. A settings form at `/admin/config/user-interface/settings` lets a site administrator set the URL (validated the same way core validates link fields, mapping schemeless paths to `internal:` URIs). A dedicated `access design system` permission controls who may view the embedded page, while editing the URL requires `administer site configuration`. Toolbar icon CSS is attached on every page, with an extra stylesheet loaded when the Gin toolbar is active. The module ships no entities, plugins, services, or Drush commands — just one controller, one form, config, permissions, menu links, and libraries.

---

- Give editors a one-click admin-toolbar link to your component library / design system.
- Embed a Storybook instance inside the Drupal admin without leaving the site.
- Surface a living style guide or "kitchen sink" page to content authors.
- Point the iframe at a Fractal, Pattern Lab, or Zeroheight URL for your team.
- Link to a hosted design-token or brand-guidelines page from the toolbar.
- Provide QA with quick access to a component gallery while reviewing content.
- Expose an internal `/storybook/` build served from the same Drupal site (default).
- Point to an absolute external URL (e.g. a design system hosted on another domain).
- Restrict who can see the design system by granting only `access design system`.
- Keep design-system access separate from configuration rights (edit needs `administer site configuration`).
- Add the toolbar shortcut for a subset of roles (designers, front-end devs).
- Use the internal-path form validation to link to any internal Drupal route or path.
- Show a shared component reference to distributed teams inside a familiar admin UI.
- Replace bookmarks-in-a-doc with a discoverable in-admin menu entry.
- Give the design-system link a distinct toolbar icon for both core and Gin toolbars.
- Onboard new team members by pointing them to the toolbar Design System link.
- Embed a static styleguide export hosted behind the same auth as the Drupal site.
- Link to a component documentation site during design-review workflows.
- Provide a stable in-admin entry point that survives design-system URL changes (config-driven).
- Swap the target between staging and production design-system builds by changing one config value.
