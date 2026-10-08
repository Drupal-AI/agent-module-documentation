# Google Books — manual setup guide

**Google Books** (`google_books`) is a text‑format **input filter** that turns a
short bracketed tag inside your content into rich book data pulled from
`books.google.com`. An author writes something like `[google_books: <search> ]` in
a filtered text field, and on output the filter replaces it with book information —
title, author and other details, a cover image when one exists, and even the Google
Books preview reader for volumes with a full or partial preview.

It's a handy way to build bibliographies, reading lists, or book‑listing pages
without hand‑copying data. Because it works through Drupal's text‑format filter
system, you decide exactly which formats (for example *Full HTML* or *Basic HTML*)
may use it, and you control which data fields appear. The module depends only on
core's **Editor** module.

The Google Books search string is flexible — full‑text, author, ISBN and the other
identifiers Google supports all work. For heavier use you can supply a Google Books
API key to raise the daily request limit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the filter on a text format,
   choose which book fields to display, and (optionally) add an API key.

## Where it lives in the admin menu

Google Books has no settings page of its own. You configure it entirely on your
**text formats** at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), by enabling and configuring the *Google Books*
filter on the formats you choose.

## How to use it

Once the filter is enabled on a format, create a page or article using that format
and place a search string inside the tag, for example:

```
[google_books: isbn:9780262033848 ]
```

Save the content. If the filter is configured correctly you will see the book
information for the fields you chose to display. If a particular field does not
appear for a volume, it simply was not present in the data Google returned. Google's
[advanced book search](http://books.google.com/advanced_book_search) is a good way
to craft a search string, which you then copy between the brackets.
