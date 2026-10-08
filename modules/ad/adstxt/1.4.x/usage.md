ads.txt lets you manage the IAB `ads.txt` and `app-ads.txt` files for a Drupal site from the admin UI, serving them dynamically at `/ads.txt` and `/app-ads.txt` instead of static docroot files — useful especially in multisite setups where each site needs its own file.

---

The module stores two config values (`content`, `app_content`) in `adstxt.settings` and serves them from two open routes: `/ads.txt` (`AdsTxtController::build`) and `/app-ads.txt` (`AdsTxtController::buildAppAds`), both returning `text/plain` `CacheableResponse` objects. An admin settings form at `/admin/config/system/adstxt` (route `adstxt.admin_settings_form`, permission `administer ads.txt`) exposes two textareas for the file bodies and normalizes line endings to `\n` on save. Other modules can append lines programmatically via `hook_adstxt()` and `hook_app_adstxt()`, which receive a cacheable-metadata object and return arrays of extra lines that are merged, trimmed, and filtered; if the combined content is empty the controller returns a cacheable 404. On install, `hook_install()` seeds the config from the first readable candidate file (`DRUPAL_ROOT/ads.txt`, `sites/default/default.ads.txt`, or the module's shipped sample `ads.txt`). A runtime `hook_requirements()` errors if Clean URLs are disabled and warns if a physical `ads.txt` exists in the docroot (which the webserver would serve instead of the route). The shipped sample `ads.txt`/`app-ads.txt` contain only IAB placeholder example lines.

---

- Serve a site-specific `ads.txt` from `/ads.txt` without placing a file in the docroot.
- Serve `app-ads.txt` from `/app-ads.txt` for mobile/CTV app inventory authorization.
- Give each site in a Drupal multisite its own ads.txt via per-site config.
- Edit the authorized-sellers list through the admin UI instead of SSH/file edits.
- Declare DIRECT relationships with ad exchanges/SSPs (e.g. `greenadexchange.com, 12345, DIRECT, AEC242`).
- Declare RESELLER relationships for indirect supply paths.
- Add or update seller account IDs and TAG IDs as ad partners change.
- Import an existing docroot `ads.txt` automatically on module install.
- Programmatically inject ads.txt lines from another module via `hook_adstxt()`.
- Programmatically inject app-ads.txt lines via `hook_app_adstxt()`.
- Centralize ads.txt management for a distribution/install profile.
- Keep ads.txt under configuration management (it's a config object, exportable/overridable).
- Return a proper 404 when no ads.txt content is configured.
- Cache the ads.txt response and invalidate it when config or contributing modules change.
- Comply with IAB Authorized Digital Sellers requirements to reduce ad fraud.
- Roll out ads.txt changes across environments via config sync.
- Let a non-developer marketing/ops role (with the permit) update ad partners.
- Detect misconfiguration where a stale physical ads.txt shadows the dynamic route (requirements warning).
- Ensure Clean URLs are enabled so the `/ads.txt` route resolves (requirements error otherwise).
- Combine a base list in config with dynamically computed lines from custom code.
