GeoIP Auto-Update keeps the MaxMind GeoLite2-Country database current by downloading it from MaxMind on Drupal cron, storing it in the private filesystem, and exposing a `local_private` GeoLocator plugin for the GeoIP module that reads from that location.

---

The module extends the [GeoIP](https://www.drupal.org/project/geoip) module (a hard dependency). On every `hook_cron` run its `GeoIpUpdaterService` issues a lightweight authenticated HEAD request to MaxMind's direct-download endpoint (`https://download.maxmind.com/geoip/databases/GeoLite2-Country/download?suffix=tar.gz`), compares the returned `Last-Modified` header against a value saved in state, and only downloads the `.tar.gz` archive when it is newer — so it does not burn MaxMind's daily download limit. A downloaded archive is extracted with `PharData`, the `.mmdb` file is copied to `private://GeoLite2-Country.mmdb`, and the new `Last-Modified` is recorded. Credentials (MaxMind Account ID + License Key) are entered on an admin settings form at `/admin/config/system/geoip/autoupdate` (gated by `administer site configuration`), which also has a **Download now** button that forces an immediate download bypassing the freshness check. The bundled `local_private` GeoLocator plugin subclasses GeoIP's `Local` plugin but points at the `private://` scheme, keeping the database out of the public web root; select it as the active GeoLocator on GeoIP's settings page. A `hook_requirements` implementation overrides GeoIP's status-page check so it reports the `private://` database (and its age) instead of falsely warning about a missing `public://` file. The module requires Drupal's private filesystem to be configured and the PHP `phar` extension for extraction.

---

- Keep the MaxMind GeoLite2-Country database automatically up to date without manual downloads.
- Store the GeoIP database in the private filesystem so it is never web-accessible.
- Check MaxMind for a newer database build on every cron run using a cheap HEAD request.
- Avoid exceeding MaxMind's daily download limit by only downloading when `Last-Modified` changes.
- Trigger an immediate on-demand database download from the admin UI ("Download now").
- Feed IP-based country geolocation to any module that consumes the GeoIP module's GeoLocator.
- Provide the `local_private` GeoLocator plugin as the active geolocation provider on the GeoIP settings page.
- Authenticate to MaxMind's R2 presigned-URL download infrastructure via HTTP Basic auth with redirect following.
- Report the correct database location and age on the site status/requirements page.
- Warn on the status page when the GeoIP database is more than a month old.
- Verify MaxMind credentials by clicking "Download now" and watching for a success message.
- Rotate a MaxMind license key by pasting a new value into the settings form (blank leaves the existing key untouched).
- Serve country restriction / geolocation features while satisfying MaxMind's licensing by refreshing GeoLite2 regularly.
- Use a private-filesystem GeoIP database on sites where the public directory is CDN-fronted or read-only.
- Integrate MaxMind geolocation on a site that runs cron regularly, with zero ongoing manual maintenance.
- Programmatically force a refresh from custom code via `geoip_autoupdate.updater`'s `forceUpdate()`.
- Read the currently installed database's `Last-Modified` timestamp via the updater service's `getLastModified()`.
- Support geolocation-driven content, redirects, or analytics that depend on an accurate country database.
