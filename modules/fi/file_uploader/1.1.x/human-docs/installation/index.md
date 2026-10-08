# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core only — there are no third-party Composer or PHP library requirements.

Remember this is a **framework**: on its own it gives you an upload element and
endpoint, not a ready-to-use widget. Plan to install an integration module (or build
one) as well.

## Install with Composer

From the project root:

```bash
composer require drupal/file_uploader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_uploader -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_uploader -y
```

## Add an integration module

The framework becomes useful once you add a front end. The most common choice is
**File Uploader by Uppy**:

```bash
composer require drupal/file_uploader_uppy -W
drush en file_uploader_uppy -y
```

That gives you an actual field widget (drag-and-drop, progress, previews, resumable
uploads) to select on your file fields' **Manage form display**. Alternatively, build
a custom integration by extending the framework's widget base and implementing an
uploader plugin — the `file_uploader.api.php` file documents the contract.

## Verify it worked

After enabling File Uploader plus an integration module, go to an entity type's
**Manage form display**, and confirm the integration's upload widget (for example
*File Uploader by Uppy*) is available to select on a file field. The framework
itself has no screen of its own to check.
