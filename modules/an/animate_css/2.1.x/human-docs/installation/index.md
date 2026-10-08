# Installation

## Requirements

Animate CSS needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **animate.css library file** itself, supplied by the Composer package
  `drupal-shimmy/animate.css` (version 4.1.1). This is declared as a requirement
  in the module's own `composer.json`, so installing the module with Composer
  pulls it in for you and places it at `web/libraries/animate.css/animate.css`.

There are no other module dependencies — it does not even require core's Toolbar
or any contrib module.

## Install with Composer

From the project root:

```bash
composer require drupal/animate_css -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it is what pulls in the bundled `drupal-shimmy/animate.css`
library so the stylesheet ends up under `web/libraries/`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/animate_css -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animate_css -y
```

That's all it takes. From this point the animate.css classes are loaded on every
page and ready to use — there is no configuration step.

## Verify it worked

Visit **Reports → Status report** (`/admin/reports/status`). You should see an
"Animate library — Installed" line. If instead it reports the library as *Not
installed*, the `animate.css` file did not land under `web/libraries/animate.css/` —
re-run the Composer command above (the library comes from the
`drupal-shimmy/animate.css` package) and clear caches.

To see it in action, add `class="animate__animated animate__bounce"` to any element
in a template or block and reload the page.
