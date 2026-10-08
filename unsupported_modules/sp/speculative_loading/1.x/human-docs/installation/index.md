# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **System** module (always present).
- No additional PHP or library requirements.

The **BigPipe** core module is a recommended (not required) companion for
progressive page rendering. The feature only takes effect in Chromium-based
browsers (Chrome, Edge, Opera) that support the Speculation Rules API; other
browsers ignore it harmlessly.

## Install with Composer

From the project root:

```bash
composer require drupal/speculative_loading -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/speculative_loading -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en speculative_loading -y
```

That is all it takes — the module works immediately with its default settings,
automatically adding the speculation-rules markup to standard front-end pages. No
further setup is required unless you want to tune the behaviour (see
[Configuration](../configuration/index.md)).

## Verify it worked

Browse your site in a Chromium-based browser (Chrome or Edge). Navigation to
likely-next pages should feel noticeably faster. You can also open the browser's
developer tools to confirm speculation rules are being added to the page markup.
