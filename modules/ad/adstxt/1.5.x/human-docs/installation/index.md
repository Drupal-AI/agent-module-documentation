# Installation

## Requirements

ads.txt is self‑contained. It needs:

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11.0 || ^12`).
- **Clean URLs enabled.** The `/ads.txt` and `/app-ads.txt` routes cannot resolve
  without them — the module's status report will raise an **error** if they're off.

There are no module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/adstxt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/adstxt -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adstxt -y
```

On install, the module seeds its content from the first readable of a docroot
`ads.txt`, a `sites/default/default.ads.txt`, or its own shipped sample file (the
sample contains only IAB placeholder example lines). Once enabled, edit the content
at **Configuration → System → ads.txt** — see
[Configuration](../configuration/index.md).

## Grant the permission

The module defines one permission, **Administer ads.txt**, required to edit the
files through the admin form. Grant it to the roles that manage your ad partners.

> **Watch out for a physical file.** If a real `ads.txt` file exists in your
> docroot, most webservers serve that file from disk and bypass the module's route
> entirely. The module's status report warns you when it detects this — remove the
> physical file so the dynamic route is used.
