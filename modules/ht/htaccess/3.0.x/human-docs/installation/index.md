# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **Apache** web server for the generated directives to take effect — `.htaccess`
  is an Apache mechanism. (On Nginx or other servers the file is ignored by the web
  server.)
- A **writable docroot** if you want the module to write the file. On a read‑only
  production docroot the write step fails safely — the read/preview half still
  works, but you won't be able to save changes to disk.

There are no other Drupal module dependencies and no third‑party Composer or PHP
library requirements. The optional Robots.txt Utils sub‑module only does something
useful when the separate **Robotstxt** module is enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/htaccess -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/htaccess -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htaccess -y
```

## Sub-module — Robots.txt Utils (optional)

If you use the **Robotstxt** module to serve a dynamic `robots.txt` and want to
guarantee no stale physical `robots.txt` file interferes, enable the companion
sub‑module. It deletes the physical file on save and on cron:

```bash
drush en htaccess_robotstxt_utils -y
```

(Enable it from **Extend** if you're unsure of the exact machine name — it's listed
under the Htaccess package as *Robots.txt Utils*.)

## Verify it worked

Log in as an administrator and go to **Configuration → System → Htaccess**
(`/admin/config/system/htaccess`). You should see a read‑only preview of Drupal's
default `.htaccess` content and a field for your extra directives. Before saving
anything, read [Configuration](../configuration/index.md) — this module writes your
live `.htaccess`, so it's worth understanding the safeguards first.
