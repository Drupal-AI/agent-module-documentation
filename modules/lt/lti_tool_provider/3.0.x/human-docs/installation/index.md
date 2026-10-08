# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Options** module (`options`).
- The **[Key](https://www.drupal.org/project/key)** module (`key`), used to store
  LTI consumer credentials securely. Composer pulls it in as a dependency.
- The PHP **`ext-oauth`** extension (the OAuth PECL extension). **This is a hard
  requirement of 3.0.0** — `composer require` will fail on an image that doesn't
  have it.

## Add the OAuth PHP extension first

Because `ext-oauth` is required, make sure it's present before (or as part of)
installing. In DDEV, add it to the web image and restart:

```bash
ddev config --webimage-extra-packages='php${DDEV_PHP_VERSION}-oauth'
ddev restart
```

On other hosting, install the OAuth PECL extension through your platform's usual
mechanism and confirm it's loaded (`php -m | grep -i oauth`).

## Install with Composer

From the project root:

```bash
composer require drupal/lti_tool_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Key
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lti_tool_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lti_tool_provider -y
```

## Submodules — enable only what your integration needs

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Provision** | `lti_tool_provider_provision` | Creates (or loads) local Drupal accounts automatically on launch, and can provision a default entity type. |
| **Roles** | `lti_tool_provider_roles` | Maps LTI roles (e.g. `Instructor`, `Learner`) onto Drupal roles. **A privilege decision — map carefully.** |
| **Attributes** | `lti_tool_provider_attributes` | Maps LTI launch data (profile attributes) onto Drupal user fields. |
| **Content** | `lti_tool_provider_content` | Redirects a launch to specific content, linking a course link to a Drupal page. |

Enable them individually, for example:

```bash
drush en lti_tool_provider_provision lti_tool_provider_roles -y
```

## Verify it worked

Confirm the module and any submodules are enabled, then open the LTI
administration area (see [Configuration](../configuration/index.md)) and register
a test consumer. The real test is a launch from your LMS: configure the tool link
in the LMS with your site's launch URL and the consumer key/secret, then click it
as a student and confirm you land on the right page already authenticated.
