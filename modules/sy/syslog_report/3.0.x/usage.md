<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Syslog Report provides an admin UI to view syslog log records.

---

Syslog Report **shows syslog records in the admin UI** — an interface to view the log records written to syslog
(rather than the database), for reviewing site logs. It depends on core Syslog and the jQuery UI Accordion module,
and provides its own permissions.

Use it to view syslog logs in Drupal. It is an administration/logging tool. Security note: **log records can contain
sensitive data** (paths, IPs, user actions, occasionally values) — so gate this report strictly to trusted admins
(its permission), and ensure reading syslog from Drupal doesn't expose logs beyond intended admins. It has no
content or access role beyond its permission. Configure the syslog report.

---

- View syslog log records.
- Show logs written to syslog.
- Review site logs in admin.
- Depend on core Syslog + jQuery UI Accordion.
- Provide its own permissions.
- Serve administration/logging.
- EXPOSE log records that can contain sensitive data (paths/IPs/actions).
- Gate the report strictly to trusted admins.
- Not expose logs beyond intended admins.
- Have no content/access role beyond permission.
- Configure the syslog report.
- Handle syslog reporting.
- View logs.
- Configure the report.
- Show logs.
- Handle the logs.
- Read syslog.
- Review logs.
- Restrict the report.
- Provide syslog viewing.
