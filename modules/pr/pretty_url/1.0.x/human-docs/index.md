# Pretty URL — manual setup guide

**Pretty URL** (`pretty_url`) makes the URLs produced by **Views exposed filters**
clean and human-readable. By default, Drupal writes multi-value exposed filters —
especially taxonomy term filters — as array query syntax like
`?category[12]=12`, which is ugly, hard to read, and awkward to share. This module
turns that into a comma-separated, slug-based form such as:

```
?category=web-development,drupal
```

You enable it per filter, right in the Views UI, and it maps the readable slugs
back to taxonomy term IDs internally so Views still processes the request exactly
as it normally would. Backward compatibility with the default query format is
preserved, so existing links keep working.

The setup is done entirely in the **Views UI** with a checkbox on the exposed
filter — there is no separate settings page. See "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Scope and limitations:** Pretty URL currently supports **taxonomy** exposed
> filters only. Slug matching is based on taxonomy term names, with basic
> normalization for case and formatting differences. This module is not covered by
> Drupal's security advisory policy — review and test it before relying on it.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You turn it on per filter in
the Views UI, described below.

## Where it lives in the admin menu

Pretty URL adds no admin settings page. You use it from **Structure → Views**
(`/admin/structure/views`) when editing a view's exposed filters.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit the view whose exposed taxonomy filter you want to prettify, at
   **Structure → Views**.
3. Open the exposed **taxonomy** filter's settings. You will find a new checkbox,
   **"Enable pretty URL for this filter."** Tick it.
4. Save the view.

From then on, that filter reads and writes clean, comma-separated slugs (for
example `?category=web-development,drupal`) instead of the default array syntax,
while Views continues to process the underlying term IDs normally. A small
JavaScript integration keeps the behaviour consistent on the front end.
