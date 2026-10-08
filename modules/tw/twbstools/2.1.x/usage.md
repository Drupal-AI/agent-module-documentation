Bootstrap tools (twbstools) is a companion for the Bootstrap 5 theme that adds a single-page **style guide / cheatsheet** at `/styleguide`, rendering every Bootstrap 5 component on one page so editors and developers can see the theme's markup and classes at a glance.

---

The module exposes one route, `twbstools.styleguide.render` at path `/styleguide` (permission
`access content`), handled by `StyleguideController::render()`. The controller reads the bundled static
Bootstrap 5 cheatsheet (`resources/cheatsheet/index.html`, a saved copy of getbootstrap.com's
cheatsheet example), rewrites the absolute example URL to a relative one, parses it with `Html::load()`
+ `DOMXPath`, extracts the `<aside>` navigation and the `.bd-cheatsheet` block, and returns them as
`#markup` (`Markup::create()`) with the `twbstools/twbstools.cheatsheet` asset library attached. That
library pulls `resources/cheatsheet/index_files/cheatsheet.css` + `cheatsheet.js` and **depends on the
Bootstrap 5 theme's `bootstrap5/bootstrap5-js-latest` library**, so the theme must supply Bootstrap for
the page to look right. A menu link under *Configuration → Development* and a local task point at the
page. The rendered HTML is a **static, module-bundled document** (not user input). The module ships no
config, schema, permissions, entities, plugins, or Drush; its `.info.yml` declares no dependencies but
the cheatsheet library is only satisfied when the Bootstrap 5 theme is installed.

---

- Preview all Bootstrap 5 components (buttons, alerts, cards, forms, etc.) on one page at `/styleguide`.
- Give front-end developers a quick reference for the classes available in the Bootstrap 5 theme.
- Show content editors what styled components look like before using them in CKEditor/content.
- Sanity-check that the site's Bootstrap 5 assets are loading correctly (styles render on the page).
- Use as a living design reference during theme development.
- Copy component markup patterns from the cheatsheet into templates or content.
- Verify color, spacing, and typography utilities render as expected in the current theme.
- Onboard new team members to the project's Bootstrap 5 component set.
- Confirm a Bootstrap version/theme upgrade didn't visually break core components.
- Provide a shared, in-site style reference instead of linking out to getbootstrap.com.
- Demonstrate responsive behavior of Bootstrap components by resizing the styleguide page.
- Reach the guide via the *Configuration → Development → Styleguide* admin menu link.
- Keep a QA/design checkpoint page available on any environment with the module enabled.
- Reference form control, table, and navigation styling while building custom components.
- Check utility classes (badges, list groups, progress bars) in the actual theme context.
