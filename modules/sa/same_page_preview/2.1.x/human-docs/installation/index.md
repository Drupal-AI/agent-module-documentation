# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`) — **but not Drupal
  11.4**, on which this release fatals and cannot be enabled (see the warning below).

There are no dependent modules, no submodules, and no third-party PHP or JavaScript
library requirements.

> **Do not enable this version on Drupal 11.4.** The module's `PreviewPaneController`
> types its `formBuilder` property as `FormBuilderInterface`, while core's
> `NodePreviewController` (which it extends) declares it as the nullable
> `?FormBuilderInterface` in 11.4. PHP rejects the narrowed type and the class fatals
> **on load** — on a clean install this was severe enough that even
> `drush pm:uninstall` could not run, and the module had to be removed by editing
> `core.extension` directly. A site already running the module will break when core
> is updated to 11.4, not at install time. Stay on Drupal 10 or a pre-11.4 release
> until a fixed version is available.

## Install with Composer

From the project root:

```bash
composer require drupal/same_page_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/same_page_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

On a compatible core version (Drupal 10 or a pre-11.4 release):

```bash
drush en same_page_preview -y
```

## Verify it worked

Edit any node and press **Preview**. Instead of being taken to a separate full-page
preview, you should see the rendered node appear in a pane beside the edit form,
with your form still in place. If the site errors on enable, check your core
version — this release is incompatible with Drupal 11.4.
