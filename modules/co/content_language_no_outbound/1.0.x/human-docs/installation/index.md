# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A multilingual setup: core's **Language** module (and typically **Content
  Translation**) configured, since this module provides a *content‑language*
  negotiator.
- No third‑party Composer or PHP library requirements.

This release is a release candidate (1.0.0‑rc2); test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/content_language_no_outbound -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_language_no_outbound -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_language_no_outbound -y
```

## Turn on the negotiator

Enabling the module makes the negotiator *available* but does not activate it. Finish
setup from the core language settings:

1. Go to **Configuration → Regional and language → Languages → Detection and
   selection**.
2. Under **Content language** detection, enable **"Content language (no outbound)"**.
3. **Disable** the core **"Content language"** method — running both at once is not
   supported.
4. Save the configuration.

## Verify it worked

Load a translated node page with a `?language_content_entity=<langcode>` query
parameter and confirm the content language is detected as expected. Then check the
links rendered on the page — the `language_content_entity` parameter should **not**
be appended to any of them, and your language switcher should continue to change only
the interface language.
