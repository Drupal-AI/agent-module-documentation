Environment Link fixer strips mapped/production domain names from absolute links and images so URLs become relative and resolve on the current environment.

---

Environment Link fixer helps keep content portable across environments (production, staging, local) when authors paste absolute URLs that hard-code a specific hostname. Rather than mapping one domain to another, it removes the matched domain from `<a href>` and `<img src>` targets, turning `https://www.example.com/page` into `/page`, so the link resolves against whichever site is currently serving the page. It works in three places that share one set of helper functions: a text-format filter that rewrites filtered HTML output, a link field widget that trims the current base URL host when a link field is saved, and a link field formatter that can force configured "local" domains to relative at display time. Domain mappings live in a single config object edited at `/admin/config/system/env_link_fixer`, in the format `hostname|domain,domain`, and can be extended or turned off per environment from `settings.php`. The module is intended as a site-building and deployment aid; it adds no entities, services or Drush commands.

---

- Strip a hard-coded production domain from body links so staging copies do not link back to production.
- Convert absolute in-content links to relative so they follow the current environment automatically.
- Rewrite `<img src>` URLs that point at a mapped domain so images load from the current site.
- Apply the `env_link_fixer_strip_domain` text filter to a rich-text format used for body/long-text fields.
- Use the link field widget so absolute URLs on the site's own domain are stored relative when editors save.
- Use the link field formatter to force matched local domains to relative only at render time (leaving stored data intact).
- Set the formatter's per-field "local domains" list to override the site-wide mapping for one field.
- Map several source domains for one hostname (for example `www.example.com,example.com`).
- Define a general site-wide mapping in config and let filter/formatter fall back to it when no per-instance list is set.
- Add developer-specific local domains from `settings.php` via `$settings['env_link_fixer_custom_mappings']` without touching exported config.
- Disable all module logic on production with `$settings['env_link_fixer_disabled'] = TRUE;` so production output is untouched.
- Keep migrated or imported content working after moving it between environments with different hostnames.
- Normalize links pasted by editors from the live site's front end back into relative internal links.
- Preserve query strings and fragments when the formatter converts an absolute URL to an internal one.
- Skip routed/internal links in the formatter so only genuine external-looking absolute URLs are touched.
- Gate mapping administration behind the `administer env_link_fixer settings` permission.
- Configure everything from one settings form under Configuration -> System.
- Combine the filter (for WYSIWYG content) with the widget/formatter (for link fields) for full coverage.
- Support Drupal 8, 9, 10 and 11 from a single 1.0.x release.
- Use it to reduce manual find-and-replace of domains during environment refreshes.
- Avoid absolute-URL "leakage" where a lower environment references assets or pages on production.
