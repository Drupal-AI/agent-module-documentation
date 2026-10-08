# Installation

## Requirements

- **Drupal 11.1 or higher** (`core_version_requirement: ^11.1`).
- The **Pinto** module (`pinto`) and core's **Layout Discovery** module
  (`layout_discovery`) — both are dependencies and are handled automatically.
- Pinto's PHP requirement applies (PHP 8.2+), inherited through the `pinto`
  dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/pinto_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pinto, Layout
Discovery, and the underlying Pinto library, updating shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pinto_layout -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pinto_layout -y
```

Pinto and Layout Discovery are enabled automatically as dependencies.

## Allow the required Twig sandbox classes

Pinto Layout's region attributes are used inside Twig templates, so you must add the
relevant classes to the Twig sandbox allow-list in your site's `settings.php`:

```php
$settings['twig_sandbox_allowed_classes'] = [
  \Drupal\Core\Template\Attribute::class,
  \Drupal\pinto_layout\PintoLayout\Data\RegionAttributes::class,
];
```

Without this, layouts that reference `RegionAttributes` in their templates will fail
to render. (If your site already sets `twig_sandbox_allowed_classes` for other
reasons, merge these entries into the existing array rather than overwriting it.)

## Verify it worked

Define a Pinto object with `#[Region]` properties and its Twig template, add the
`settings.php` entries above, then clear the cache (`drush cr`). The object should now
appear as an available layout when you configure Layout Builder. If it does not,
re-check the region attributes and the Twig sandbox settings. See the [official
documentation](https://www.drupal.org/project/pinto_layout) for a full example.
