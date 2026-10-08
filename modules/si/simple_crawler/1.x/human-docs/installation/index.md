# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **consumer** for the crawler. On its own the module only exposes a service and
  an AI Automator type — nothing happens until something calls it. In practice that
  means either:
  - the **AI Automator** submodule of the [AI module](https://www.drupal.org/project/ai),
    if you want to use it through the UI on a link field; or
  - your own custom module code calling the `simple_crawler.crawler` service.
- No extra PHP libraries beyond what Drupal already ships (it builds on
  Guzzle/cURL, which core provides).

## Install with Composer

From the project root:

```bash
composer require drupal/simple_crawler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_crawler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_crawler -y
```

## Wire it up to a consumer

To use it through the AI Automator:

1. Install and enable the AI module and its AI Automator submodule.
2. Create (or reuse) a content type or entity type with a **link field** and a
   **formatted long‑text** field.
3. On the long‑text field, tick the **AI Automator** checkbox and configure it to
   use Simple Crawler.
4. Create an entity of that type, fill in a link, and save — the long‑text field is
   populated with the scraped page.

To use it from code, call the `simple_crawler.crawler` service as shown in the main
guide.

## A safety check before production

Because the module makes your server fetch URLs, confirm before you rely on it that
any URLs coming from user‑editable fields are validated or allow‑listed, that cURL
keeps TLS certificate verification enabled, and that only trusted operators can
trigger crawls. Test on non‑production first.
