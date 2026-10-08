<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Useit Drupal Info reports the site's Drupal version, PHP version and full project inventory (each project's installed and latest version, plus its update status) to an administrator-configured destination URL on cron, for external monitoring.

---

Useit Drupal Info is a lightweight "phone-home" reporter for sites managed centrally. On every cron run its `useit_drupal_info_cron()` hook calls a single service (`UseitDrupalInfoService::checkAndSendData()`) that uses Drupal's Update Manager (`update_get_available()` / `update_calculate_project_data()`) to compute the installed and recommended versions and update status of core and every project, adds the PHP version, site name and base URL, and POSTs the whole payload as JSON to the URL you configured. An optional API key is sent in an `X-Drupal-Key` header, and a cron interval (Always, 3h, 6h, 12h, daily, weekly) throttles how often the POST fires — the last-sent time is kept in state (`useit_drupal_info.cron_last`). All of this is opt-in and admin-controlled: the destination URL, API key and interval live on one settings form at `/admin/config/system/post_destination_settings`, gated by the `administer site configuration` permission. The module depends on the core Update Manager and Automated Cron modules. Because the payload describes exactly which modules and versions the site runs, point it only at a monitoring endpoint you operate or trust, and prefer an HTTPS destination so the report is not sent in the clear.

---

- Report the site's Drupal core version to a central monitor.
- Report the PHP version running the site.
- Send the full installed-project inventory (each project's installed version).
- Send each project's recommended and latest available version.
- Report each project's update status (current / outdated / needs update).
- Feed an agency dashboard that tracks many client sites.
- Automate periodic version reporting via cron.
- Throttle reports to daily, weekly, or every few hours.
- Send reports on every cron run when the interval is set to "Always".
- Authenticate to a protected receiving endpoint with an API key header.
- Include the site name and base URL so the monitor can identify the source.
- Point the report at your own SaaS monitoring backend.
- Centralize "which sites need updates" reporting across a fleet.
- Use an HTTPS destination so the report is not transmitted in cleartext.
- Restrict who can change the destination and key via the admin permission.
- Configure everything from one settings page, no code required.
- Check the last-sent timestamp shown on the settings form.
- Reset reporting cadence without redeploying code.
- Track update status trends over time on the receiving side.
- Integrate Drupal update data with an external ticketing or alerting system.
- Keep the API key private by leaving the field blank to retain the saved value.
- Disable the module when central reporting is no longer needed.
- Rely on core's Update Manager data rather than a custom scanner.
- Run alongside Automated Cron so reports fire without an external cron trigger.
