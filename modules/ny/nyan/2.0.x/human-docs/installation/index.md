# Installation

## Requirements

- **Drupal 9.3+ or 10** (`core_version_requirement: ^9.3 || ^10`).
- A modern browser — the animation uses pure CSS and HTML5 audio, tested on recent
  Firefox and Chrome and expected to work on WebKit‑based browsers.

There are no module dependencies and no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/nyan -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nyan -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nyan -y
```

That is all it takes — every Drupal progress bar now uses the Nyan cat animation.
There is no required configuration.

## Verify it worked

Trigger any batch operation (for example, check for updates at **Reports →
Available updates**, or run a batch import) and confirm the progress bar shows the
Nyan cat animation instead of the standard bar. For a quick check without a real
batch, use the module's preview screen (Drupal 8+).
