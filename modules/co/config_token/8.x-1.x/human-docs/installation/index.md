# Installation

## Requirements

- **Drupal 8 and newer** (`core_version_requirement: >=8`), including Drupal 10 and
  11.
- Core's **Filter** module (`filter`).
- The **Token** module (`token`).
- The **Token Filter** module (`token_filter`) — lets tokens render inside filtered
  text.

There are no third‑party PHP library requirements. This is the 8.x‑1.7 release.

## Install with Composer

From the project root:

```bash
composer require drupal/config_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token and Token
Filter dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_token -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_token -y
```

## Verify it worked

As an administrator, add a custom token with a machine name and a value, then use it
somewhere tokens are supported (for example `[config_token:your_token]` in body text
with the Token Filter applied) and confirm it renders the configured value. Running
`drush cex` afterwards should show your token stored as configuration in the sync
folder.
