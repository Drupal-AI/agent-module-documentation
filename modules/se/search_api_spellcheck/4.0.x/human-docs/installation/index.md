# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11.0`).
- The **Search API** module (`drupal/search_api`, `~1.35`) — pulled in automatically by
  Composer.
- Core's **Views** (`views`) and **Search API** (`search_api`) modules enabled.
- A **search backend that supports spellcheck** — in practice **Apache Solr** via the
  Search API Solr module. The feature produces no output on a backend that does not
  advertise the `search_api_spellcheck` feature (for example the core Database server),
  so make sure your index is served by Solr before you expect corrections to appear.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_spellcheck -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_spellcheck -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_spellcheck -y
```

There is no settings form to visit and nothing to configure globally. The next step is
to add one of the module's area handlers to a Search API view — see
[Configuration](../configuration/index.md).

## Verify it worked

After enabling, edit a Search API view and open the **Header** or **Footer** section:
clicking **Add** should now list **Search API Spellcheck "Did You Mean"** and
**Search API Spellcheck "Suggestions"** among the available handlers.
