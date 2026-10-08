# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Webform** module (`webform:webform`) — a hard dependency. The generator
  creates and updates Webform entities directly, so Webform must be installed and
  enabled.
- No third‑party Composer packages or external libraries of its own (Composer
  pulls in the Webform dependency automatically).
- Some content‑type field types only map meaningfully when their owning core
  module is enabled (for example Media or Link). Enable those field‑providing
  modules if you want their fields included.

## Install with Composer

From the project root:

```bash
composer require drupal/content_type_webform_creation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the required Webform module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_type_webform_creation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Webform (if it is not already) and this module together:

```bash
drush en webform content_type_webform_creation -y
```

## Grant access to the generator

The generator's steps require the core **Administer site configuration**
permission. At **People → Permissions** (`/admin/people/permissions`), grant it
to whichever roles should be able to generate or update webforms. This is a
high‑privilege permission, so keep it with trusted administrators.

## Verify it worked

Go to **Configuration → Content → Webform Generator**
(`/admin/config/content/webform-generator`). Pick a content type that has a few
fields, enter a title, select the fields, and step through to the preview — you
should see a summary table and a live rendering of the generated elements. Confirm
to create the webform; you will be redirected to its Edit page in the standard
Webform UI.
