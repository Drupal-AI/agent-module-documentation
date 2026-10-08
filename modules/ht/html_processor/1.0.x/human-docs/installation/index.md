# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- A few small **Symfony and League Composer libraries**, which Composer installs
  automatically — no manual downloads. (The exact packages are listed in the
  module's `README.md`.)
- No other Drupal modules are required. HTML Processor works on any HTML string on
  its own; optional companions such as an HTML‑to‑Markdown loader or URL Fetcher
  (`url_fetcher`) pair naturally with it but aren't needed.

## Install with Composer

From the project root:

```bash
composer require drupal/html_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Symfony/League
libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_processor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_processor -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → HTML
Processor** — you should see the default‑pipeline settings form. For a functional
check, developers can inject `HtmlProcessorInterface` and call `process()` on a
sample of messy HTML, or run the module's Drush command, and confirm the output is
cleaned as expected. See [Configuration](../configuration/index.md) for what each
setting does.
