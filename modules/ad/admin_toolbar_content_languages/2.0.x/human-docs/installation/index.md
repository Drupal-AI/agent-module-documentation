# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Admin Toolbar** (`admin_toolbar`) **and Admin Toolbar Tools**
  (`admin_toolbar_tools`) — both are required, and Composer pulls the Admin Toolbar
  project in for you.
- A multilingual site with more than one language configured, for the dropdown to be
  useful.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar_content_languages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Admin Toolbar project this module depends on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar_content_languages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable this module together with the two Admin Toolbar modules it needs:

```bash
drush en admin_toolbar admin_toolbar_tools admin_toolbar_content_languages -y
```

Drupal will refuse to enable `admin_toolbar_content_languages` unless both
`admin_toolbar` and `admin_toolbar_tools` are present, so enabling all three together
is the simplest approach.

There is no configuration form — once enabled, the language dropdown appears in the
Admin Toolbar's "add content" area for the content types it applies to.
