# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **R installed on the web server** — the actual R statistical software, so the
  module has an interpreter to call. You will need the filesystem path to its binary.
- A text format that only **trusted** roles can use, on which you will enable the R
  filter (see the security note below).

There are no third‑party Composer or PHP library requirements for the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/r -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/r -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix. Note that R itself must also be present
> inside whichever environment runs the site.

## Enable the module

```bash
drush en r -y
```

## Turn on the filter (required)

The module does nothing until you enable its filter on a text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a format used **only by trusted roles**.
3. Enable the **R** filter and set the **path to the local R binary** in its
   settings.

> **Security:** enabling this filter lets anyone who can author in that format run R
> code on your server. Never enable it on a format available to untrusted or
> anonymous users.

## Verify it worked

In content using that trusted format, add a small block such as
`[R]print(1 + 1)[/R]` and view the page. If the output appears inline, R is installed
and the binary path is correct. If nothing renders, re‑check the R binary path in the
filter settings.
