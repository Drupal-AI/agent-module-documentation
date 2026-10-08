# Installation

## Requirements

Linkit needs **Drupal 10.2 or newer** (it also supports Drupal 11 and 12). It has
**no other module dependencies** — nothing extra is pulled in — and no special PHP
extension requirements beyond what your Drupal version already needs. Linking inside
the WYSIWYG assumes you are using Drupal core's **CKEditor 5**, which ships with
Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/linkit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update anything it needs to
while resolving the package.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/linkit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkit -y
```

Once enabled, the profile admin screen appears under **Configuration → Content
authoring → Linkit**.

## Verify it worked

Log in as an administrator and go to `/admin/config/content/linkit`. You should see
the **Linkit profiles** page with an **+ Add profile** button. Enabling the module
also installs a ready-made **Default** profile, so you may see it listed here
already.

Next, head to [Creating a profile](../creating-a-profile/index.md) to build a
profile and switch it on in an editor.
