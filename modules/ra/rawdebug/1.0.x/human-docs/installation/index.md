# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependencies and no third-party PHP libraries.

> **Development only.** Set this up on development sites that are not publicly
> available. Do not use it on production — see the note on the
> [overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/rawdebug -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Because RawDebug is a development tool, you may prefer to
require it as a dev-only dependency (`composer require --dev drupal/rawdebug`) so
it is never installed on production builds.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rawdebug -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module (optional)

You do **not** have to enable the module to use its functions — including
`rawdebug.php` from `settings.php` is the recommended approach and works even
when modules aren't loading. If you do want the module's help text, enable it
with:

```bash
drush en rawdebug -y
```

## Set it up from settings.php

Follow the project's `README.md`: copy the `rawdebug.php` file into place and add
an include for it in your `settings.php`. This defines the debug helper functions
globally so they are available regardless of Drupal's bootstrap state.

## Verify it worked

Add a debug call such as `rawdebug('test', $someVar, dbt());` to a code path you
can trigger, then confirm the value and stack trace appear in the log file.
Remove any such calls before you deploy.
