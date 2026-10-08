# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Canvas** module (`drupal/canvas`).
- This is a **1.0.0‑beta1** developer release.

> **Check your Canvas version before installing.** Canvas Override extends
> Canvas's component tree loader class. In **Canvas 1.8.0** that class is `final`,
> and PHP will refuse to load a subclass of it — a fatal error at class‑load time
> that stops the container from building and takes the site and Drush down.
> Neither module caps the other in Composer, so the incompatible combination can
> be installed by accident. Confirm which Canvas release this override was written
> for, and pin your `canvas` version to match, before enabling it.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies. Because Composer does not prevent the incompatible Canvas pairing
described above, review the resolved `canvas` version afterwards.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_override -y
```

If enabling triggers a *"cannot extend final class"* fatal, your Canvas version is
incompatible: remove the module (`composer remove drupal/canvas_override`), clear
it from configuration if needed, and rebuild the cache to recover the site.
