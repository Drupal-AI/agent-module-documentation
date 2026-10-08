# Siwecos — manual setup guide

**Siwecos** (`siwecos`) connects your Drupal site to the SIWECOS website
security-scanning service and surfaces the resulting security score and report
inside the Drupal back end. SIWECOS was a German government-sponsored project
offering a set of scanners for common website security vulnerabilities, with
recommendations (for example, on Content-Security-Policy headers) for hardening
your setup.

Using credentials you store in the module, Siwecos logs in to the service,
registers and verifies your site's own domain (via a `siwecostoken` meta tag and
response header), triggers scans, and renders the score plus each scanner's
findings on an admin report page. It also provides a **Siwecos seal** trust-badge
block you can place to show a verification badge that links back to siwecos.de.
The scanned domain is locked to your own site's host, so the module can only ever
scan your own site — there is no way to point it at another server.

> **Important — this service is being discontinued.** The module's own project
> page advises disabling and uninstalling it, because the SIWECOS service is shut
> down. This module is marked unsupported and obsolete. Treat this guide as
> reference for an existing installation rather than a recommendation to adopt it
> on a new site.

A couple of caveats worth knowing before you enter credentials: the settings route
requires a permission (`administer siwecos configuration`) that the module never
actually defines, so in practice only user 1 (the superuser) can reach the
settings form. There is also no support for sites behind `.htpasswd` or otherwise
not publicly reachable, since the scanners need to reach your site from outside.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your SIWECOS credentials and
   view the report.

## Where it lives in the admin menu

- **Settings:** **Configuration → System → Siwecos**
  (`/admin/config/system/siwecos`) — where you enter your account email and
  password. In practice only user 1 can open this form, because of the missing
  permission noted above.
- **Report:** **Reports → Siwecos** (`/admin/reports/siwecos`) — where the
  security score circle and per-scanner findings are rendered.
