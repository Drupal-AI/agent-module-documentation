PWA Extras adds Apple/iOS-specific PWA metadata — apple-touch-icons, status-bar styling, a pinned-tab mask color and add-to-home-screen splash icons — on top of the base PWA module.

---

Because iOS Safari does not fully honour the standard web app manifest, this submodule injects the Apple-specific `<meta>`/`<link>` tags a Drupal PWA needs on iOS. Its settings live in the `pwa_extras.settings.apple` config object, edited at `/admin/config/pwa/pwa_extras` (route `pwa_extras.settings`, permission `administer pwa` from the base module). You can enable: apple **touch icons** (`touch_icons` checkboxes, including a masked pinned-tab icon whose color is `mask_color`), Apple **meta tags** (`meta_tags` — web-app-capable, status-bar-style, app title), the status-bar **color** (`color_select`: `default` / `black` / `black_translucent`), and a set of **home-screen splash icons** (`home_screen_icons` for various iPhone/iPad sizes). `pwa_extras_page_attachments()` renders the chosen tags into the page head (helper functions `pwa_extras_apple_touch_icons()`, `pwa_extras_apple_meta_tags()`, `pwa_extras_apple_home_screen_icons()`, `pwa_extras_tag_list()`). It depends on the base `pwa` module and adds no permissions of its own.

---

- Provide an apple-touch-icon so the site's home-screen icon looks right on iOS.
- Add a pinned-tab (Safari) mask icon and set its color via `mask_color`.
- Emit `apple-mobile-web-app-capable` so iOS launches the site full-screen.
- Set the iOS status-bar style to default, black, or black-translucent.
- Set the iOS web-app title shown under the home-screen icon.
- Add splash-screen images for various iPhone/iPad sizes on launch.
- Make a Drupal PWA behave like a native app specifically on Apple devices.
- Complement the standard manifest (base pwa) with Apple-only tags iOS requires.
- Brand the pinned-tab icon color to match the site theme.
- Enable only the specific Apple meta tags a project needs via checkboxes.
- Configure everything from one form at /admin/config/pwa/pwa_extras.
- Improve the installed-app appearance on iPhones and iPads.
- Toggle status-bar transparency for an immersive iOS app feel.
- Ship the Apple PWA configuration (`pwa_extras.settings.apple`) as exported config.
- Pair with pwa_a2hs and pwa_service_worker for a full app-like iOS experience.
