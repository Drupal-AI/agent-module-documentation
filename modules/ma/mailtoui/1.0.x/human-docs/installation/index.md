# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, PHP libraries, or third-party dependencies — the MailtoUI
  JavaScript library is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/mailtoui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mailtoui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailtoui -y
```

The module attaches its JavaScript to every page as soon as it is enabled. There
is nothing to configure.

## Verify it worked

Add the `mailtoui` class to a `mailto:` link on any page — for example
`<a class="mailtoui" href="mailto:hello@example.com">Contact us</a>` — then load
that page as a visitor and click the link. Instead of the browser trying to open
a desktop mail client, the Mailto UI modal should appear with webmail and
copy-address options.
