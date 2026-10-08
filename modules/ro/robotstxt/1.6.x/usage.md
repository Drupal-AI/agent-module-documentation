RobotsTxt generates your site's `robots.txt` dynamically and lets you edit its contents from the Drupal admin UI, which is especially useful on multisite installs where a single physical file can't differ per site.

---

Normally `robots.txt` is a static file sitting in the docroot, shared by every site on a multisite codebase. RobotsTxt replaces that with a dynamic route: it registers a controller at `/robots.txt` that serves a `text/plain` response built from configuration stored per site. Site admins edit the file body in a simple textarea at Admin → Configuration → Search and metadata → RobotsTxt (route `robotstxt.admin_settings_form`), gated by the `administer robots.txt` permission. The content is stored in the `robotstxt.settings` config object (key `content`), so it is exportable and deployable like any other configuration. Other modules can append lines to the output by implementing `hook_robotstxt()` — for example a sitemap module adding its `Sitemap:` line. Responses are cached with a `robotstxt` cache tag that is invalidated whenever the settings are saved. For the dynamic route to actually be reached you must delete (or rename) the physical `robots.txt` that ships in Drupal's docroot, otherwise the web server serves the static file first. The module also ships Drupal 6/7 migration definitions for importing legacy robots.txt settings.

---

- Edit robots.txt from the admin UI without shell/FTP access.
- Serve a different robots.txt for each site in a multisite install.
- Block crawlers from admin, user, or search paths with `Disallow:` rules.
- Allow specific paths while disallowing a parent directory.
- Add a `Sitemap:` line pointing to your XML sitemap.
- Target rules to specific bots via `User-agent:` blocks.
- Deploy robots.txt content between environments as exportable config.
- Disallow all crawling on a staging/development site.
- Let a module inject robots.txt lines programmatically via `hook_robotstxt()`.
- Add crawl-delay directives for aggressive bots.
- Keep robots.txt under configuration management / version control.
- Restrict editing to trusted roles with the `administer robots.txt` permission.
- Migrate robots.txt settings from a Drupal 6 or 7 site.
- Centralize robots.txt maintenance for site editors instead of developers.
- Quickly toggle indexing rules for a marketing campaign or launch.
- Prevent duplicate-content crawling of faceted/parameterized URLs.
- Expose a canonical sitemap reference for search engines.
- Provide per-environment robots.txt using config splits.
- Add comments documenting why particular paths are blocked.
- Ensure crawler rules survive core updates that would overwrite a static file.
