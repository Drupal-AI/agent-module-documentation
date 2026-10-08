<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Version holds a manually-set site version, build number and description in config and surfaces them: on an admin-viewable page (`/site-version`), and optionally through a JSON API (`/site-version/json?api_key=...`). A "Host Auto Configuration" form can register this site's version endpoint with a remote host URL.

Use it to track and expose which version/build a given environment is running, for release management or external dashboards.

---

Install the module; on install it generates a random 32-char JSON API key, records the site UUID and a changed timestamp. Configure at Administration > Configuration > System > Site Version (`site_version.settings`, permission `site_version admin`): set version, build, description, and enable/disable the JSON API with its access key.

View the version table at `/site-version` (permission `site_version view`). The JSON endpoint at `/site-version/json` is technically `_access: TRUE` (anonymous) but returns data only when the JSON API is enabled AND the supplied `api_key` strictly matches the stored key; otherwise it returns an error object. The Host Auto Config form base64-encodes this site's endpoint link and `file_get_contents()`s an admin-entered host URL to register it.

---

- Record a human-set site version and build number.
- Add a free-text description of the release.
- Show version details on an admin page.
- Expose version details as JSON for tooling.
- Gate the JSON API behind a generated access key.
- Disable the JSON API by default.
- Store the site UUID for identification.
- Track a changed timestamp on each save.
- Include core version and site name in the payload.
- Register this site's endpoint with a remote host.
- Auto-enable the JSON API when configuring a host.
- Restrict configuration to `site_version admin`.
- Restrict the view page to `site_version view`.
- Regenerate/display the API link on the settings form.
- Run on Drupal 8, 9 and 10.
- Return structured error strings for disabled/empty/mismatched keys.
