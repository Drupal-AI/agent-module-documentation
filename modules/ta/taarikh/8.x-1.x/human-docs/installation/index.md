# Installation

## Requirements

- **Drupal 10.2, or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Datetime** module (`datetime`) — this is the only module dependency,
  and Drupal enables it automatically when you turn on Taarikh.
- The **jQuery Calendars** library by Keith Wood (used by the date entry widget).
  The module has been tested with version 2.1.0, though the latest release should
  also work. See the note below for pulling it in with Composer.

There are no PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taarikh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taarikh -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

### Adding the jQuery Calendars library

Taarikh's date entry relies on Keith Wood's jQuery Calendars library, which is not
on Packagist. To let Composer fetch it, add a `package` repository to your project
`composer.json` describing it as a `drupal-library`, then require it. Following the
module's own instructions, add this to the `repositories` section:

```json
{
  "type": "package",
  "package": {
    "name": "kbwood/jquery.calendars",
    "type": "drupal-library",
    "version": "2.1.0",
    "dist": {
      "url": "http://keith-wood.name/zip/jquery.calendars.package-2.1.0.zip",
      "type": "zip"
    }
  }
}
```

Then require it:

```bash
composer require kbwood/jquery.calendars
```

## Enable the module

```bash
drush en taarikh -y
```

## Verify it worked

Edit any content type (or other entity) that has a core **Date** field, open its
**Manage form display** tab, and confirm that *Taarikh date and time* now appears
as a widget option. On the **Manage display** tab, the matching *Taarikh date and
time* formatter should also be available. See the main
[guide](../index.md) for how to switch them on.
