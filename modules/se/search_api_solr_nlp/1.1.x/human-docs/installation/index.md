# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Search API Solr** (`search_api_solr`), with a working Solr server. The default
  Solr distribution already contains the OpenNLP libraries this module relies on.
- The ability to **provide or upload your own Solr config set** to your Solr
  server — your hosting provider must allow this.

There are no PHP library requirements beyond what Composer pulls in (see below).

## Install with Composer

**You must install this module via Composer**, because Composer pulls in the
pretrained OpenNLP language models — a set of models for different languages
sourced from apache.org. From the project root:

```bash
composer require drupal/search_api_solr_nlp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **The first download takes a while.** Composer is not fast at fetching these
> model files, so the very first install may take noticeably longer than usual —
> that is expected, not an error. The files are cached afterwards.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr_nlp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_solr_nlp -y
```

## Deploy the config set to Solr

Once the module is enabled, the Solr config sets that Search API Solr generates
will automatically include all the required OpenNLP files. Regenerate and upload
that config set to your Solr server as you normally would for Search API Solr, then
reindex.

> **Using Solr Cloud?** You may need to raise a ZooKeeper buffer limit to handle
> the larger config set. One way is to set the environment variable:
>
> ```
> SOLR_OPTS=$SOLR_OPTS -Djute.maxbuffer=50000000
> ```

## Verify it worked

After deploying the config set, the new NLP fulltext field types (for example the
"nouns" type) should be available when you configure fields on a Search API Solr
index. Using one of these types on a text field is how you start filtering content
for nouns, named entities and the like.
