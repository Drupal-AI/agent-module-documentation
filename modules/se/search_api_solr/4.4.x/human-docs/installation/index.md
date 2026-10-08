# Installation

## Requirements

- **Drupal core 11.3** (`core_version_requirement: ^11.3`).
- The **Search API** module (`drupal/search_api`, `^1.41`) and core's **Language**
  module.
- An **Apache Solr server** you can configure (self-hosted, SolrCloud, or a hosted
  provider). Solr 7–9 are directly supported; 3.6–6 require the
  `search_api_solr_legacy` submodule; Solr 10 support is experimental.
- PHP extensions **dom**, **json**, and **simplexml**.
- Several PHP libraries that Composer installs automatically: `solarium/solarium`,
  `composer/semver`, `maennchen/zipstream-php`, `laminas/laminas-stdlib`, and
  `consolidation/annotated-command`.

**Read the module's `README.md` before you start** — it covers Solr-side setup that
this page does not.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_solr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and the
required PHP libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV also offers a
> Solr add-on that's handy for local development.

## Enable the module

```bash
drush en search_api_solr -y
```

This enables Search API and Language as dependencies.

## Submodules

Search API Solr ships several optional submodules. Enable only what you need with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search API Solr Admin** | `search_api_solr_admin` | Create and administer Solr collections/cores and upload config sets from Drupal. |
| **Search API Solr Autocomplete** | `search_api_solr_autocomplete` | Solr-backed autocomplete/typeahead (works with the Search API Autocomplete module). |
| **Search API Solr Legacy** | `search_api_solr_legacy` | Support for older Solr versions (3.6–6.x). Enable only if your Solr is that old. |
| **Search API Solr Log** | `search_api_solr_log` | A fast, feature-rich replacement for Drupal's database log, backed by Solr. |
| **Search API Solr Devel** | `search_api_solr_devel` | Developer/debugging helpers for inspecting raw Solr requests and responses. |

For example, to add the admin helper:

```bash
drush en search_api_solr_admin -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and click **Add server**. If **Solr** appears
as an available backend, the module and its libraries are installed correctly.
Continue by creating a server, deploying the generated Solr config set, and adding
an index (see the "How to use it" section on the [overview page](../index.md)).
