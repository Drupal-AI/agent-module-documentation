Adds a toggleable "visually impaired" (low-vision) version of a Drupal site: a block button switches the visitor to a high-contrast/large-text theme via a cookie, matching the accessibility-version requirement of Russian legislation (GOST).

---

The module ships two blocks — "Visually Impaired block" (`visually_impaired_block`) and "Normal block" (`normal_block`) — each rendering a single submit button. Clicking the visually-impaired button runs `VISpecialForm`, which sets a `visually_impaired=on` cookie; the normal button (`VINormalForm`) sets `visually_impaired=off`. A theme negotiator (priority 10, `applies()` always TRUE) then serves the theme chosen on the settings form whenever that cookie is `on` and the current route is not an admin route. The chosen theme machine name is stored in config `visually_impaired_module.visually_impaired_module.settings:visually_impaired_theme` (edited at `/admin/config/user-interface/visually_impaired_module`, permission `administer site configuration`). Because the switch is cookie-based and pages are cached, the module replaces core's `http_middleware.page_cache` service with its own `MyCache` subclass (via a `ServiceProvider`) that folds the `visually_impaired` cookie value into the page-cache ID, so cached HTML is varied per on/off state. It also attaches a small CSS library on every page and depends on core `page_cache`. There is no dedicated permission and no Drush; the intended companion is the separate `visually_impaired_theme` project (the actual low-vision theme), though any enabled theme can be selected.

---

- Add a one-click "switch to visually impaired version" button to a site's header or sidebar.
- Provide a legally-required low-vision site version (Russian GOST / accessibility law) on a public site.
- Let visitors toggle back to the normal site version with a companion "Normal version" button block.
- Serve a dedicated high-contrast, large-text theme to low-vision users while keeping the default theme for everyone else.
- Persist a visitor's accessibility preference across pages using the `visually_impaired` cookie.
- Keep the admin UI on the normal/admin theme even while a visitor has the visually-impaired version enabled.
- Select which enabled theme is used as the visually-impaired version from a simple settings dropdown.
- Pair the module with the `visually_impaired_theme` project for a ready-made GOST-compliant theme.
- Vary Drupal's anonymous page cache by accessibility state so cached pages stay correct for both versions.
- Render the toggle as an image button or a text button (per-block "Block style" setting).
- Expose the accessibility switch as a placeable block anywhere the Block layout allows.
- Give anonymous (not-logged-in) users an accessibility version without requiring an account.
- Meet public-sector / government site accessibility-version mandates with a lightweight, config-only setup.
- Offer a "special version" button styled with the `itemprop="copy"` marker used by some accessibility validators.
- Switch the whole front-end theme without touching per-user account settings.
- Provide an accessibility toggle that works with Drupal's standard block visibility conditions.
- Combine the visually-impaired theme with the site's normal navigation and content unchanged.
- Deploy an accessibility-version feature that requires no custom code, only block placement and a theme choice.
