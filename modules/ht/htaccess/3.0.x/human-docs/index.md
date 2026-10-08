# Htaccess — manual setup guide

**Htaccess** (`htaccess`) gives you a simple admin form for managing your site's
root `.htaccess` file from inside Drupal, instead of editing it over FTP or SSH.
Drupal ships a one‑size‑fits‑all `.htaccess` for Apache, but real sites often need
extra server‑side rules — custom redirects, security headers, caching or
compression tweaks, `FilesMatch` restrictions. This module lets you add those extra
Apache directives through the UI: it loads Drupal's official default `.htaccess`
content, lets you append your own configuration below it, and writes the combined
result to the docroot with one click. An option can keep the file in sync
automatically on every cron run.

The 3.x branch is a complete, modernised rewrite of the original module for Drupal
10 and 11, focused on safe, reliable management of the root `.htaccess`. It also
ships a companion sub‑module, **Robots.txt Utils**, which automatically deletes the
physical `robots.txt` file (on save and on cron) when the
[Robotstxt](https://www.drupal.org/project/robotstxt) module is enabled — so search
engines always read the dynamically generated version.

> **This is a powerful, sensitive tool — treat its permission as
> administrator‑only.** The form writes over your site's root `.htaccess`, the file
> that enforces core protections such as directory‑listing prevention and the rules
> that block web access to `*.yml`, `*.module`, `*.install`, and editor backup
> files. A bad or unparsable `.htaccess` can take the whole site offline (Apache
> returns HTTP 500 for the directory, including the admin page you'd use to fix it),
> and on Apache the extra‑directives field is inherently capable of changing how the
> server executes code. Give the `administer htaccess` permission only to people who
> are already full administrators, and be cautious on production. The
> [Configuration](configuration/index.md) page covers the safeguards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally enable the Robots.txt Utils sub‑module.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus the operational and security precautions.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Htaccess**
(`/admin/config/system/htaccess`), gated by the **`administer htaccess`**
permission.
