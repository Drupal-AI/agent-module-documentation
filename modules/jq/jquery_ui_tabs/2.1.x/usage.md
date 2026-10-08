jQuery UI Tabs re-provides the jQuery UI Tabs widget as an asset library so themes and modules can keep using tabbed interfaces after jQuery UI was deprecated and removed from Drupal core.

---

Drupal core historically bundled the jQuery UI Tabs widget as part of `core/jquery.ui`, but jQuery UI is no longer maintained and was deprecated and removed from core, so any code that relied on the tabs widget would break. This small companion module restores exactly that one widget. It ships no PHP, no `*.module`, no `*.libraries.yml` and no configuration of its own; the actual library definition lives in the base `jquery_ui` module, which declares a `tabs` library on behalf of this module through its `hook_library_info_alter()` implementation (reading `jquery_ui.libraries.data.json`). The resulting library id you attach is `jquery_ui_tabs/tabs`. That library loads the minified `tabs-min.js` widget plus the base `tabs.css` theme file, and depends on `jquery_ui/widget`, `core/jquery`, and several internal jQuery UI helper libraries. The module itself only declares a Drupal dependency on `jquery_ui` (`>=8.x-1.7`) so the base assets and the alter hook are always present. There is no settings page, no permissions and no services — you install it, attach `jquery_ui_tabs/tabs`, and initialize `.tabs()` in your own JavaScript. The maintainers recommend migrating tabbed UIs off jQuery UI to a maintained alternative rather than adding new dependencies on it; this module exists to keep legacy code working during that transition.

---

- Restore the jQuery UI Tabs widget after upgrading to a Drupal core version where jQuery UI was removed.
- Attach `jquery_ui_tabs/tabs` to a render array so a page can build a tabbed interface.
- Replace an old `core/jquery.ui` tabs dependency with the `jquery_ui_tabs/tabs` library.
- Keep a legacy custom module that calls `.tabs()` working without patching it.
- Serve the jQuery UI Tabs base CSS theme (`tabs.css`) to style tab strips.
- Load the minified jQuery UI Tabs widget JavaScript (`tabs-min.js`) on demand.
- Declare a dependency on `jquery_ui_tabs/tabs` from your own module's `*.libraries.yml`.
- Add tabbed navigation to a custom Twig template that ships its own initializing JS.
- Provide the jQuery UI Tabs widget to a contrib module that split it out of core.
- Ensure the `jquery_ui/widget` factory is present as a transitive dependency of tabs.
- Avoid deprecation warnings by depending on `jquery_ui_tabs/tabs` instead of core jQuery UI.
- Build an accordion-like tabbed settings panel in a custom admin form's markup.
- Pin the jQuery UI Tabs widget as an explicit, contrib-maintained dependency in a distribution.
- Keep a legacy field widget or formatter that renders jQuery UI tabs functioning.
- Bridge a themed component during migration away from jQuery UI to a modern tabs library.
- Attach tabs assets conditionally only on the routes/pages that actually render tabs.
- Guarantee a consistent vendored jQuery UI Tabs version (1.13.2) across a multisite platform.
- Supply the tabs widget to a custom JavaScript behavior that enhances server-rendered markup.
- Let a theme depend on `jquery_ui_tabs/tabs` so its tabbed regions render correctly.
- Reintroduce tabbed help or documentation panels that previously used core jQuery UI.
