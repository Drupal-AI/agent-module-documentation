# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

There are no module dependencies and no external libraries to download.

## Install with Composer

From the project root:

```bash
composer require drupal/email_obfuscator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_obfuscator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_obfuscator -y
```

That is all that is required — obfuscation begins automatically on all non‑admin
output. See the [main guide](../index.md) for the optional `settings.php`
adjustments (route whitelisting and the `data-nosnippet` toggle).

## Verify it worked

Publish a page containing an email address, then view it as an anonymous visitor
and look at the page source. In a `mailto:` link the address should appear
reversed (rebuilt on interaction), and a plain‑text address should contain a
hidden `<span>` with filler characters in the middle. The address should still
read and behave correctly in the browser for a real visitor.
