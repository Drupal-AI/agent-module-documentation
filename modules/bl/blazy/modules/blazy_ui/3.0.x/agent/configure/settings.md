# Blazy UI settings

- Route: `blazy.settings` — path `/admin/config/media/blazy`.
- Form: `Drupal\blazy_ui\Form\BlazyConfigForm`.
- Permission: `administer blazy` (marked `restrict access: true`).
- Writes config object `blazy.settings` (schema defined in the base `blazy` module).

Notable settings (defaults in `blazy/config/install/blazy.settings.yml`):
- `admin_css` — enable admin CSS tweaks.
- `fx` — blur/LQIP effect id.
- `one_pixel`, `placeholder` — placeholder strategy.
- `use_oembed`, `privacy_consent` — remote media handling.
- `blazy.offset`, `blazy.loadInvisible`, `blazy.container` — loader tuning.
- `io.rootMargin`, `io.threshold`, `io.unblazy`, `io.disconnect` — IntersectionObserver.
- `nojs.lazy`, `nojs.polyfill`, `nojs.promise`, `nojs.raf` — no-JS fallbacks.

These become the defaults for every Blazy field formatter, the `blazy_filter` text filter, and
Blazy Views plugins. Export as regular config (`drush config:export`).
