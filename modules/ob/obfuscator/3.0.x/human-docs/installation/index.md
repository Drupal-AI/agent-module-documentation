# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third‑party Composer or PHP library requirements.
- The TRACE/TRACK hardening applies to **Apache** via `.htaccess`; on other web
  servers that portion does not apply, but the version‑ and asset‑stripping options
  still work.

## Install with Composer

From the project root:

```bash
composer require drupal/obfuscator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/obfuscator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en obfuscator -y
```

## Verify it worked

Open [Configuration](../configuration/index.md), turn on the options you want, and
save. Then check that a fingerprint is actually gone — for example, view the page
source of your home page and confirm the Drupal generator `<meta>` tag no longer
carries the version, or inspect the HTTP response headers with your browser's
developer tools (or `curl -I https://your-site`) and confirm the version no longer
appears in the `X-Generator` header.
