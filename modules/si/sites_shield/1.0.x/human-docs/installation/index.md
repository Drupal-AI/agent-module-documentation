# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2 || ^12`).
- The **Sites** module (`sites`) enabled — Sites shield builds directly on the
  per-site context that Sites provides, so it cannot work without it.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sites_shield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sites_shield -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sites_shield -y
```

If the Sites module is not already on, enable it too (`drush en sites -y`).

## Turn on the shield for a site

There is no central settings form. Edit any site managed by the Sites module,
find the **Sites shield** section on the site edit form, and enter a username and
password. Save, and that site immediately starts prompting visitors for those
credentials. To lift the shield again, clear the username and save.

If you want certain trusted roles to skip the prompt, grant them the **Skip
sites_shield auth** permission at **People → Permissions**.

## Verify it worked

Open the shielded site in a private/incognito browser window (or log out first).
You should be met with a browser Basic-Auth dialog before any page loads; entering
the username and password you set lets you through, and the wrong credentials keep
you out with a 401 response.
