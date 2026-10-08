# Configuration

Once the module and your Solr backend are set up, day-to-day work happens in two
places: managing the list of synonyms, and exporting them to Solr.

## Manage synonyms

1. Log in as a user with permission to administer the synonyms.
2. Go to **Configuration → Search and metadata → SOLR Search Synonyms**
   (`/admin/config/search/solr-search-synonyms`).

This page lists your existing synonyms and spelling corrections and lets you add,
edit and delete them. Each entry defines a set of equivalent terms — for example
that "car" and "automobile" should match each other, or that a common misspelling
should still return the correct results. Because the synonyms are stored per
language, you manage them for the language you are targeting (for example
English).

## Export settings and cron

Under the synonym page, **Configuration → Search and metadata → SOLR Search
Synonyms → Settings** (`/admin/config/search/solr-search-synonyms/settings`)
controls exporting via Drupal cron. Enable export on cron here if you want your
synonym changes pushed to Solr automatically on each cron run, rather than
exporting by hand.

Remember that for synonyms to be applied *directly* in Solr, the Solr schema must
be prepared with the managed synonym filter and Solr restarted first (see
[Installation](../installation/index.md)); with that in place, each cron export
updates the synonyms in Solr successfully.

## Export to Solr with Drush

You can also export at any time from the command line. The export command is:

```bash
drush solr-search-synonym:export
```

(There are shorter aliases too: `drush ssolr-syn:export` and `drush ssolr-syn-ex`.)

It accepts options to choose the export plugin and language, for example:

- Export all English synonyms and spelling errors in the Solr format:
  `drush solr-search-synonym:export --plugin=solr --langcode=en`
- Export synonyms **directly into Solr** using the uploader plugin:
  `drush solr-search-synonym:export --plugin=solr_uploader --langcode=en`

After exporting, verify the behaviour by running a search on your site and
confirming that the synonymous terms now return each other's results.
