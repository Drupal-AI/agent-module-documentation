AOS JS UI adds an admin interface for the AOS JS module: global AOS settings (version, load method, page visibility) plus a CRUD list of animation "selectors" that bind AOS options to CSS selectors so you can animate elements without editing markup.

---

Enabling this submodule takes over asset attaching from the base `aosjs` module. Its `hook_page_attachments()` reads the `aosjs.settings` config to decide whether to load AOS at all (`load`), which version (`v2`/`v3`) and method (`local`/`cdn`), and on which pages (a path-list with show/hide visibility, plus an `?animate=no` query escape hatch via `_aosjs_ui_check_url()`). Configured animation targets are stored in a dedicated `aos` database table (schema in `aosjs_ui.install`: `aid`, `selector`, `label`, `comment`, `changed`, `status`, and a serialized `options` blob) and managed through forms at `/admin/config/user-interface/aosjs` — add, edit, duplicate, delete, plus a global settings form and a defaults form. All routes are gated by the single `administer aos js` permission. On each request the module loads enabled rows via the `aosjs.animate_manager` service (`AosJsManager`), unserializes each row's options with `allowed_classes => FALSE`, and exports them to the page as `drupalSettings.aosjs.elements[<aid>] = {selector, ...options}` alongside the chosen version/library, then attaches its own `aos-init` library. The admin pages also render a live sample preview. Default settings ship in `config/install/aosjs.settings.yml` (fade-up animation, 120px offset, 400ms duration, `ease` easing, an admin/edit-path exclusion list). A companion `aosjs_animatecss` submodule swaps the animation option set for Animate.css.

---

- Attach AOS animations to CSS selectors without touching any markup or templates.
- Manage a list of animation rules (add / edit / duplicate / delete) from the admin UI.
- Enable or disable an individual animation rule via its `status` flag.
- Choose AOS v2 or v3 site-wide from the settings form.
- Load AOS from a local `libraries` copy or from a CDN (the `method` setting).
- Turn off module-managed AOS loading entirely with the `load` setting.
- Restrict AOS to specific pages, or exclude pages, with the path-visibility list.
- Exclude admin/node-edit/user-edit paths from animations (shipped defaults).
- Let visitors disable animations per-request with `?animate=no`.
- Set global default animation, offset, delay, duration, easing, and anchor placement.
- Configure advanced AOS options (once, mirror, mutation observer, debounce/throttle delays, class names).
- Preview a chosen animation live on the admin settings page.
- Give a selector a human-readable label and comment for maintainability.
- Search/filter the selector list by selector or label (`AosJsManager::findAll()`).
- Programmatically read enabled animations via the `aosjs.animate_manager` service.
- Grant the `administer aos js` permission to a trusted role to delegate animation management.
- Bind different AOS options (delay, duration, easing) to different page regions.
- Migrate the module: settings live in `aosjs.settings`, targets in the `aos` DB table.
- Combine with `aosjs_animatecss` to use Animate.css effects in the same UI.
- Localize animations automatically to the site's active AOS version library.
