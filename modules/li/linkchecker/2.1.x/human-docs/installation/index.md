# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- A working **cron** setup — Link checker does its re‑checking on cron runs, so
  the reports stay up to date only if cron runs regularly. For internal‑link
  checks, cron must be able to reach your real public site URL, or those links may
  be reported broken incorrectly (see the module's README).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. The module uses Drupal core's HTTP client (Guzzle) to make its
requests.

## Install with Composer

From the project root:

```bash
composer require drupal/linkchecker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/linkchecker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkchecker -y
```

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`), decide who can do what:

- **Access broken links report** — see the site‑wide Broken links report.
- **Access own broken links report** — see a report limited to the user's own
  content (handy for giving editors visibility of just their pages).
- **Administer link checker** — reach the settings form and manage link data (an
  administrative permission).
- **Edit link checker link settings** — edit an individual link's settings.

From the command line, for example:

```bash
drush role:perm:add editor 'access broken links report'
```

## Verify it worked

Visit **Configuration → Content authoring → Link checker** — the settings form
should load. Then tick **Scan broken links** on a field that contains links, save
some content, and run cron. Broken links will begin to appear at **Reports →
Broken links**.
