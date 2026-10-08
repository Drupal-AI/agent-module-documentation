# Installation

## Requirements

- **Drupal 11.4 or 12** (`core_version_requirement: ^11.4||^12`).
- Core's **Language** (`language`) and **System** (`system`) modules — Language is
  enabled as a dependency.
- A **multi‑domain, multilingual setup**: this module only makes sense when each
  language is served from its own domain and language is detected via the URL.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/i18n_sso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/i18n_sso -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en i18n_sso -y
```

This also enables core Language if it isn't already on.

## Configure language detection by domain

There is no settings form for this module — its behaviour is driven by your
language configuration. Make sure **URL‑based language detection with a
per‑language domain** is set up at **Configuration → Regional and language →
Languages → Detection and selection**, and that every domain is served over
**HTTPS**. See [How it works and how to set it up](../index.md#how-it-works-and-how-to-set-it-up)
for the details and the security rules.

## Verify it worked

Log in on your default language domain (e.g. `example.com`), then visit a page on
a sibling language domain (e.g. `example.es`) that would normally give you a 403.
The module should log you in on that domain automatically and reload the page. If
instead you see a message asking you to log in on the default domain, confirm you
were logged in there and that both domains are correctly listed in your
language‑domain configuration.
