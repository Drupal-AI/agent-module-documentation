# Installation

## Requirements

- **Drupal core ^11.4** (`core_version_requirement: ^11.4`).
- **PHP 8.3 or newer.**
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`,
  `^1`).
- The [Paragraphs EE](https://www.drupal.org/project/paragraphs_ee) module
  (`paragraphs_ee`, `^10.1`) — it provides the type‑picker modal this module
  auto‑opens.

No external APIs or extra JavaScript libraries are needed beyond what Paragraphs EE
already provides. Entity Browser is **not** required (though it can be part of a
create/reuse flow — the auto‑open setting is configured on the host form's
paragraphs widget, not on the browser).

> **Status note:** this project is **not (yet) covered by Drupal's security
> advisory policy**. Use accordingly until it opts into the security team process.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_ee_auto_open -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_ee_auto_open -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_ee_auto_open -y
```

The module creates no new content type. Its behaviour is off until you opt in a
field widget (see the main guide).

## Verify it worked

Go to a **Manage form display** that has a Paragraphs field using the Paragraphs EE
type picker, open the field's widget settings, and confirm an **Auto‑open EE type
picker** checkbox now appears. Tick it, save, then open a create form with that
field empty — the type picker should open automatically.
