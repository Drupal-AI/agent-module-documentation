# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`key`) — used to store your ScreenshotOne API and secret keys
  securely.
- A **ScreenshotOne account** — the external service that captures the screenshots.
  You can test 100 screenshots for free.
- To actually generate screenshots you need a module that consumes the service.
  Currently that is the **AI Automator** submodule of the
  [AI module](https://www.drupal.org/project/ai), so install the AI module if you
  want the automated link-to-image workflow.

There are no extra PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/screenshot_one -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/screenshot_one -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en screenshot_one -y
```

## Verify it worked

Go to `/admin/config/screenshot-one/settings`. You should see the settings form
where you enter your ScreenshotOne API and secret keys. Once your keys are saved,
see [Configuration](../configuration/index.md) for wiring the AI Automator to fill
an image field from a link.
