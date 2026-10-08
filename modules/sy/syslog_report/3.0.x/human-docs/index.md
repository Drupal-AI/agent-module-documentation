# Syslog Report — manual setup guide

**Syslog Report** (`syslog_report`) gives you an admin screen for reading the log
records your site writes to **syslog** — for example the file at `/var/log/syslog` —
instead of the database. When you run Drupal's core Syslog module for performance
(rather than Database Logging), you lose the familiar in-browser log view; Syslog
Report brings a viewing-and-filtering interface back, so privileged users can review
the syslog file from the admin UI.

It depends on core's **Syslog** module and on the jQuery UI Accordion module, and it
provides its own permission to gate who may see the report. There is no settings
form to fill in — once enabled and permission is granted, you read the logs from the
report screen. One filtering detail worth knowing: the filter text is
**case-sensitive**. There are no submodules.

A security point to keep in mind: **log records can contain sensitive data** — file
paths, IP addresses, user actions, and occasionally values from requests. This
report surfaces that content in the browser, so grant its permission strictly to
trusted administrators and make sure reading syslog through Drupal does not expose
those logs to anyone beyond the admins who should see them. Beyond that permission,
the module plays no content or access-control role. Note also that it is not covered
by the security advisory policy.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the viewing permission.

## How to use it

Syslog Report has no configuration form. After you enable it and grant its
permission to the right roles at **People → Permissions**
(`/admin/people/permissions`), the report becomes available in the admin interface,
where those users can view and filter the syslog records. Remember the filter is
case-sensitive. As the module's own guidance says, read its README before you start,
and prefer core Syslog over Database Logging for the performance benefit this
workflow is built around.
