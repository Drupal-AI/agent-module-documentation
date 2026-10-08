# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **Vendor Stream Wrapper** module (`vendor_stream_wrapper`) — required.
- The **`maximebf/debugbar`** Composer package — the PHP Debug Bar library that
  does the actual rendering. Installing the module with Composer (as below) pulls
  this in automatically, which is why Composer installation is strongly
  recommended.

## Install with Composer

From the project root:

```bash
composer require drupal/debugbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Vendor Stream
Wrapper module, the `maximebf/debugbar` library, and any shared dependencies.
Installing with Composer is important here — it's what makes the underlying Debug
Bar library available.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/debugbar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en debugbar -y
```

Drupal will enable Vendor Stream Wrapper as a dependency if it isn't already on.

> **Development only.** Enable this on local or staging environments and keep it
> off in production — the bar exposes settings, request variables, and exceptions.

## Submodule: Debug Bar Twig

To add a Twig pane to the debug bar for inspecting template rendering, enable the
bundled submodule:

```bash
drush en debugbar_twig -y
```

## Verify it worked

Load any page on your site. The debug bar should render at the bottom of the
window, with tabs for Drupal log messages, GET/POST variables, site settings, the
route name and parameters, and exceptions. There is nothing further to configure —
if the bar appears, you're done.
