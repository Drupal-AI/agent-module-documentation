CL Devel adds a Single-Directory-Component "Component Audit" page and per-component detail views so developers can see exactly what components the system has discovered and what each one resolves to.

---

CL Devel is a developer tool for people building Single Directory Components (SDC). It registers an admin "Component Audit" page under Configuration that walks every component the core SDC plugin manager has discovered (`plugin.manager.sdc`), shows each one as a card with its path, whether its default `*.twig` template is present, which JS/CSS assets it declares, and — for module-provided components — whether it has been forked (overridden) by another component that will render in its place. Each card links to a per-component detail page that renders the component's README (Markdown via `league/commonmark`), thumbnail, development status, slots, and prop schema. It ships two of its own SDC components (`component-details`, `image-with-fallback`) to build those pages, a `cl_label_with_link` theme hook, and a `hook_cl_component_audit_alter()` hook so other modules can add to the audit cards. Everything is read-only inspection gated behind the `administer site configuration` permission; there is no runtime behavior on the front end. It targets Drupal core `^10.3 || ^11` and, being a development aid (package `Components`), is meant for local/dev environments rather than production.

---

- Audit every SDC component the site has discovered from one page.
- See the on-disk path of each registered component.
- Confirm a component's default `<machine-name>.twig` template is actually present.
- List the JS and CSS assets a component declares in its `*.component.yml`.
- Detect that a module component has been forked/overridden by another component.
- Find out which component will actually render in place of a forked one.
- Spot a broken component whose metadata throws an `InvalidComponentException`.
- Open a per-component detail page for one component ID.
- Read a component's `README.md` rendered as HTML on its detail page.
- Inspect a component's prop schema and slot definitions in a table.
- Check a component's development `status` (experimental / stable / deprecated / obsolete).
- View a component's thumbnail (or a fallback placeholder when none exists).
- Debug a component that will not render by checking what the registry sees.
- Verify that a newly added component was picked up by the plugin manager.
- Teach a team how Drupal's SDC discovery and overriding works.
- Encourage adding `README.md` and `thumbnail.png` to every component.
- Extend the audit cards from another module via `hook_cl_component_audit_alter()`.
- Reuse the `image-with-fallback` SDC component in your own templates.
- Reuse the `cl_devel:component-details` component to render a component card.
- Link to an audit page from a support ticket when diagnosing component issues.
- Keep the module enabled only in development, disabled before a production release.
