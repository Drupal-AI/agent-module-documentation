Development Assistant re-attaches the Browser Development compiled stylesheet on the front end so a site keeps rendering correctly after the heavier Browser Development module is uninstalled on production.

---

Development Assistant is a companion module to the [Browser Development](https://www.drupal.org/project/browser_development) project. Browser Development provides an in-browser authoring tool that generates a CSS file and stores its configuration in the site database; Development Assistant is the minimal runtime piece that keeps the generated presentation working without the full editor being present. Its single active behaviour is implemented in `development_assistant_page_attachments_alter()`: when the currently active theme is the site's configured default (front-end) theme, it attaches an `html_head` stylesheet `<link>` pointing at `/sites/default/files/browser-development/css/browser-development.css`. A `hook_module_implements_alter()` implementation re-orders the module's own `preprocess_html` hook to run last. The module also ships a `Settings` form class and a `FormsStorage` config helper, but neither is wired to a route in this release, so there is no configuration UI and no configuration is required to use it. Because Development Assistant defines no routes, no permissions, no services and makes no external requests, it is designed to be safely left enabled on production while Browser Development itself is removed there — reducing the attack surface and performance cost of shipping the authoring tool to a live environment.

---

- Keep a Browser Development front-end stylesheet loading after uninstalling the Browser Development editor on production.
- Separate the "authoring" concern (Browser Development, dev/stage only) from the "render" concern (Development Assistant, all environments).
- Attach `/sites/default/files/browser-development/css/browser-development.css` to pages served by the default theme.
- Ensure the compiled browser-development CSS is present on every front-end page render without re-enabling the editor.
- Reduce production attack surface by running only the lightweight render helper instead of the full Browser Development module.
- Reduce production performance overhead by omitting the editor UI and its assets from live requests.
- Add the browser-development stylesheet only on the front-end theme, leaving admin-theme pages untouched.
- Guarantee the stylesheet `<link>` is emitted late via `hook_module_implements_alter()` re-ordering of `preprocess_html`.
- Provide a drop-in runtime companion that requires no configuration after enabling.
- Enable the module with Composer plus Drush (`drush en development_assistant`) or the Extend UI.
- Uninstall Browser Development on production while retaining its visual output through this module.
- Maintain a consistent developer-authored look across environments that no longer run the editor.
- Serve as an example of splitting a heavyweight authoring module from a thin production render shim.
- Use as a small reference for `hook_page_attachments_alter()` conditional asset attachment in Drupal 9/10/11.
- Use as a reference for `hook_module_implements_alter()` hook-order manipulation.
- Deploy the same compiled CSS path across dev, stage and production without environment-specific config.
- Avoid loading the browser-development stylesheet on admin pages that use a separate admin theme.
- Ship a module that can be enabled and left in place with essentially zero maintenance.
- Provide continuity of front-end styling during a phased removal of the Browser Development tool.
