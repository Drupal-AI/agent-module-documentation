DDECK PWA layers a mobile navigation bar, iOS home-screen meta tags, Apple splash screens and theme-based manifest icons on top of the contrib PWA module.

---

DDECK PWA is a UI and iOS enhancement companion to the PWA module (`pwa:pwa`). It does not implement a manifest or service worker itself — those stay with PWA — but it improves how a Drupal site behaves once installed to the iOS/Android home screen. It renders a fixed-bottom, mobile-only Bootstrap navigation bar (back, forward, home, reload) as a Single Directory Component, using the browser Navigation API where available and falling back to `window.history`. It injects the Apple `apple-mobile-web-app-*` meta tags (including a configurable app title) and `apple-touch-startup-image` splash-screen `<link>`s for the full set of current iPhone/iPad resolutions, but only for splash images the active theme actually ships under `<theme>/pwa/splash_screens/`. It also implements `hook_pwa_manifest_alter()` to swap the PWA manifest icons for theme-provided icons found under `<theme>/pwa/icons/`. The module assumes the theme provides Bootstrap 6 utility classes (fixed-bottom, spinner-border, d-flex, etc.) for its markup. A single admin form at `/admin/config/services/ddeck-pwa` exposes just two options: the iOS app title and a toggle for the navigation bar.

---

- Give an installed-to-home-screen Drupal site a native-feeling bottom navigation bar on phones.
- Add iOS-specific meta tags so a Drupal site launches full-screen (standalone) from the iOS home screen.
- Configure the title iOS shows under the home-screen icon via the "Apple mobile web app title" setting.
- Fall back to the PWA module's application name automatically when the DDECK title is left empty.
- Serve Apple splash / launch screens for iPhone and iPad at the correct device resolutions and pixel ratios.
- Ship per-theme splash screens by dropping PNGs into `<theme>/pwa/splash_screens/` (only present files are linked).
- Override the PWA manifest icons with brand icons supplied by the active theme under `<theme>/pwa/icons/`.
- Keep manifest, service worker and theme colors managed centrally by the PWA module while customizing only the iOS/UI layer.
- Toggle the navigation bar on or off site-wide without uninstalling the module.
- Provide back/forward controls that respect the browser Navigation API history stack when supported.
- Disable the back button at the first history entry and the forward button at the last, updating live on navigation.
- Offer a Home button that returns users to the site root and a Reload button that refreshes the current page.
- Show a full-screen loading spinner overlay during page transitions for a more app-like feel.
- Special-case Safari/iOS loader behavior (bind link clicks) versus Chrome/Android (beforeunload/load/pageshow events).
- Restrict the navigation bar and loader to small viewports only (Bootstrap `d-flex md:d-none`), leaving desktop untouched.
- Render the navigation as a reusable SDC (`ddeck_pwa:ddeck_pwa_navigation`) that embeds the loader component.
- Attach the whole navigation block via `hook_preprocess_html()` into `page_bottom` when the toggle is on.
- Restrict configuration to trusted staff with the dedicated `administer ddeck pwa` permission.
- Manage the iOS app title and navigation toggle as exportable config (`ddeck_pwa.settings`) for deployment across environments.
- Integrate with a Bootstrap 6-based theme to match the site's existing button and color utility classes.
- Serve as a starting point for a bespoke PWA shell UI that a theme or subtheme can extend.
