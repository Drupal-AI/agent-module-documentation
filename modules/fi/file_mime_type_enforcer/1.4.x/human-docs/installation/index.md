# Installation

## Requirements

File MIME Type Enforcer needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **File** and **System** modules.
- The PHP **fileinfo** extension, which is what detects a file's content-based
  MIME type. You can check whether it is installed with:

  ```bash
  php -m | grep fileinfo
  ```

## Install with Composer

From the project root:

```bash
composer require drupal/file_mime_type_enforcer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_mime_type_enforcer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_mime_type_enforcer -y
```

## Verify it worked

Visit **Configuration → Media → File MIME Type Enforcer**
(`/admin/config/media/file-mime-type-enforcer`) — you should see the settings
form. As a quick functional check, try uploading a file whose extension does not
match its content (for example a text/HTML file renamed to `.png`); in strict mode
the upload should be rejected. Then set up your allowed mappings in
[Configuration](../configuration/index.md).
