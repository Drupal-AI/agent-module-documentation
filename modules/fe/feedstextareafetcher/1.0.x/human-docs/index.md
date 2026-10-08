# Feeds Textarea Fetcher — manual setup guide

**Feeds Textarea Fetcher** (`feedstextareafetcher`) adds a *fetcher* plugin to the
[Feeds](https://www.drupal.org/project/feeds) module that lets you type or paste
your import source directly into a textarea when you create a feed — no file upload,
no remote URL. It's ideal when you have a small amount of data to import and want to
edit the source right there on the site.

Under the hood it extends Feeds' own Upload fetcher, so it inherits much of that
fetcher's behavior. When you add or edit a feed with this fetcher, a text box
appears; whatever you enter is saved as a `.txt` file on the filesystem, and it's
that file the import reads (and that you edit when you come back to the feed). On
the Feed type you can specify the directory where the saved file is stored.

Because the operator pastes the data in by hand and nothing is fetched from a remote
URL, this fetcher has no server-side request forgery (SSRF) surface — the import is
processed under the normal Feeds privileges.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Feeds.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. You select the fetcher (and its storage directory) on each Feed
type, as described below.

## Where it lives in the admin menu

Feeds Textarea Fetcher adds no admin page of its own. You use it from a Feed type at
**Structure → Feed types** (`/admin/structure/feeds`), where it appears in the
**Fetcher** list.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Feed types** and add a new Feed type, or edit an existing
   one.
3. Change the Feed type's fetcher to the textarea fetcher. Optionally set the
   **directory** where the pasted source will be saved as a `.txt` file.
4. Set the parser and processor on the same Feed type as usual, then create a feed
   of that type. When you add or edit the feed, paste or type your source into the
   text box and run the import.
