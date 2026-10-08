<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dropfort Update is an outbound client that periodically POSTs this site's requirements/status report and core Update project data to a Dropfort instance for centralized fleet monitoring.

---

Dropfort Update connects a Drupal site to a Dropfort instance (default `https://api.dropfort.com`) so update and health information can be reviewed centrally instead of per-site. On cron (at most hourly), when the settings form is saved, and when modules are installed or uninstalled, the module builds a payload from core's `system.manager` requirements list and core Update's `update_calculate_project_data(update_get_available())`, then POSTs it as JSON to `<dropfort_url>/api/v1/site/<site_key>/status`. Sending is a no-op until a site key, status auth token, and Dropfort URL are configured. The single admin route is the settings form; there is no inbound/callback route. It depends only on core `update`, stores its settings in the `dropfort_update.settings` config object, and records the last successful send time in state (`dropfort_update.last_status`), which `hook_requirements()` surfaces on the site status report.

---

- Report available module/theme updates from many sites to one Dropfort dashboard.
- Push the site's core requirements/status report to Dropfort for health monitoring.
- Monitor a fleet of Drupal sites for pending security releases centrally.
- Configure the Dropfort connection at `/admin/config/services/dropfort_update`.
- Enter the site key issued by the Dropfort site interface.
- Enter the status auth token (password field) that authenticates reports.
- Point the module at a self-hosted Dropfort instance via the Dropfort URL field.
- Send an immediate status report by saving the settings form.
- Let cron send an update report automatically (throttled to once per hour).
- Trigger a report automatically when modules are installed or uninstalled.
- Check the "Dropfort Update Connection" line on `/admin/reports/status` for last-sent time.
- Detect failed connections via the status report warning when a send errors.
- Restrict who can change the connection with the "administer dropfort update" permission.
- Force a fresh core update calculation when cached update data is empty.
- Retry sooner when core update data is still pending/not-fetched at report time.
- Keep the settings form under Configuration → services in the admin menu.
- Centralize release-information filtering through the Dropfort service.
- Run the reporting cron after core's update cron via module weight ordering.
- Report only over HTTPS (the outbound URL is protocol-filtered to https).
- Integrate a Drupal site into a Dropfort/Coldfront Labs managed-services workflow.
