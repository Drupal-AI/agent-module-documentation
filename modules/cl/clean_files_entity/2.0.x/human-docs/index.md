# Clean Files Entity — manual setup guide

**Clean Files Entity** (`clean_files_entity`) is a housekeeping module: it finds
files in your files directory that nothing references any more and **deletes** them,
running automatically on cron. It exists because Drupal's file storage only ever
grows. Core does collect *temporary* files after six hours, but only when their
reference count reached zero — and files referenced by a deleted revision, an
unpublished translation, a replaced paragraph, or a rolled-back migration stay
**permanent and unreferenced forever**. On a site with a few years of editorial
history that can be a great deal of dead weight, occupying the filesystem, every
backup, and the time it takes to sync an environment. A periodic cleanup pass is
genuinely useful maintenance.

Because this module **deletes data**, the cautions are the substance of using it,
not an afterthought:

- **"No longer used" is a judgement, and Drupal's usage tracking is incomplete.** A
  file referenced only from a body field's HTML, from a configuration object, from a
  custom database table, or by an external system linking to its URL, has a usage
  count of zero and is **not actually unused**. Those are exactly the files this
  cleanup can wrongly remove.
- **Take a backup first, and start small.** Configure a low limit and watch what
  gets removed before trusting it with a large run. Treat a *large* deletion list as
  a warning sign that something isn't tracking usage — not as a big win.
- **It selects files by folder (and effectively by naming), which is a blunt
  instrument.** A folder chosen to catch generated derivatives can also contain
  real uploads that share the location.
- **Deleting a file breaks every existing link to it**, including links in emails
  already sent and documents already circulated — which the usage table cannot know
  about.

It has no configuration form and no permissions of its own; you configure it
entirely in `settings.php` (see below). Version **2.0.0**, core `^10 || ^11`, in
the Media package. The project is maintained by Ukrainian developers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set it up in `settings.php`.

There is **no configuration page** for this module — it is configured through
`settings.php`, described under "How to configure it" below.

## How to configure it

All configuration lives in your site's `settings.php`. You tell the module which
folders to scan and how many files to process per cron run. For example:

```php
$config['clean_files_entity'] = [
  'folders' => [
    'public://node_images/',
  ],
  'max' => 100,
];
```

- **`folders`** — the list of stream-wrapper folder paths the cleanup scans (for
  example `public://node_images/`). Only files in these folders are candidates for
  deletion, so scope this deliberately and narrowly.
- **`max`** — the maximum number of files to process in a single cron run. Keep this
  low while you are still confirming the module only removes what you expect.

The cleanup then runs automatically on cron. Because cron does the deleting, the
safe way to try it is: back up, set a small `max`, point `folders` at one
well-understood directory, run cron once, and check exactly which files disappeared
before widening the scope.
