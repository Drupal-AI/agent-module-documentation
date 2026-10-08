# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Push Framework** module (`push_framework`) — the delivery layer these
  templates feed.
- The **DANSE** module (`danse`) — supplies the notification context that drives
  template resolution.
- A **patch** to Push Framework may be required; check the module's
  [project page](https://www.drupal.org/project/push_framework_templates)
  (it references a Push Framework merge request) before relying on it.
- Optionally, the [Token](https://www.drupal.org/project/token) module, which adds
  a token browser to the template form.

Both `danse` and `push_framework` are pulled in automatically as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/push_framework_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in DANSE and Push Framework.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/push_framework_templates -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en push_framework_templates -y
```

## Verify it worked

1. Go to **Configuration → Push Framework Templates**
   (`/admin/config/push-framework-templates`) and confirm you can add a template.
2. Create a simple catch-all template with an event key like `create`, then
   trigger a matching notification and confirm the templated subject and body are
   used in the delivered message.
