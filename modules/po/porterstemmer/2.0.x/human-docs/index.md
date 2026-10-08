# Porter-Stemmer — manual setup guide

**Porter-Stemmer** (`porterstemmer`) improves English-language searching in
Drupal's core **Search** module by reducing words to their root "stem". With it
enabled, "blogging", "blogs", and "blogger" all collapse to "blog", so a search for
one variant matches content containing the others. It implements the well-known
Porter2 (Snowball English) algorithm in pure PHP, and will automatically use the
faster PECL `stem` extension instead if that happens to be installed (the output is
identical).

The module does exactly one thing: it stems English text both when content is
indexed and when a search query is parsed, so the indexed terms and the query terms
line up. Non-English content is left untouched. There is genuinely nothing to
configure — enabling the module *is* the setup.

Note that this affects **core Search** only. If you use Search API, that has its own
stemming processors and does not need this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no configuration, no permission, and no admin page.

1. Make sure core's **Search** module is enabled and you have a search page set up.
2. Enable Porter-Stemmer.
3. **Re-index your site's content** so existing content is stored with stems — go
   to **Configuration → Search and metadata → Search pages** and rebuild the index
   (or run cron to let indexing catch up). New and updated content is stemmed
   automatically from then on.

After the index is rebuilt, English searches will match across grammatical
variations without any synonym lists.

### For developers

The stemming algorithm is also available to custom code as a static call, so you
can stem English text yourself without going through Search:

```php
use Drupal\porterstemmer\Porter2;

$stem = Porter2::stem('blogging'); // 'blog'
```
