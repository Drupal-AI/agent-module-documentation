# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Filter** (`filter`) module — provides the text-filter system.
- The contrib **jQuery UI stack**, because jQuery UI was removed from Drupal core.
  All three are hard dependencies and the module cannot be enabled without them:
  - **jQuery UI** (`jquery_ui`, version 8.x-1.7 or newer),
  - **jQuery UI Accordion** (`jquery_ui_accordion`, version 2.1 or newer),
  - **jQuery UI Tabs** (`jquery_ui_tabs`, version 2.1 or newer).

There are no third-party PHP library requirements. Composer resolves the jQuery UI
contrib modules for you.

> **Note on maturity and longevity:** the packaged release is `2.0.0-beta1`, and
> jQuery UI is end-of-life upstream. Prefer this for migrating existing
> heading-structured content rather than for new builds.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
jQuery UI contrib dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the filter along with the jQuery UI stack:

```bash
drush en jquery_ui jquery_ui_accordion jquery_ui_tabs jquery_ui_filter -y
```

## Turn the filter on for a text format

Enabling the module does nothing until you switch the filter on for a text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose a format (for example *Full HTML*) and click **Configure**.
3. Under **Enabled filters**, tick **jQuery UI accordion and tabs widgets**.
4. Save the format.

Optionally review the module-wide defaults at
`/admin/config/content/jquery_ui_filter`. There are no submodules.
