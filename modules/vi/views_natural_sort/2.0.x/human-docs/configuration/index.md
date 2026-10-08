# Configuration

Views Natural Sort works out of the box for node titles, and you turn it on for a
given listing by choosing the natural sort inside a View (see
[How to use it](../index.md#how-to-use-it)). This page covers the **settings form**
— which controls *how* strings are normalized before they're sorted — and how to
**rebuild the index**.

## Open the settings form

1. Log in as a user with the **Administer views** permission.
2. Go to **Structure → Views → Settings → Natural Sort**, or navigate directly to
   `/admin/structure/views/settings/views_natural_sort`.

All values are stored in the `views_natural_sort.settings` config object, so you can
also set them with Drush or export them.

## The transformation settings

Sorting reads a precomputed, transformed copy of each string (stored in the
`views_natural_sort` index table), not the live title. The settings form controls
the pipeline of transformations that produces that copy. Each can be toggled on or
off, and most take a list of things to strip:

- **Words to filter from the beginning** — leading articles stripped from the
  *start* of the string. Default list: **The, A, An, La, Le, Il** (comma-separated
  in the UI). This is what makes *The Hobbit* sort under H.
- **Words to filter from anywhere** — filler words removed wherever they appear.
  Default: **and, or, of**.
- **Symbols to filter** — punctuation/symbols ignored when sorting. Default:
  `#"'\()[]` (entered as a single unseparated string, not a list).
- **Numbers** *(enabled by default)* — encodes embedded numbers so they sort
  numerically, handling leading zeros, decimals, thousands separators, and negative
  numbers. This is what makes *Model 2* sort before *Model 10*.
- **Sort days of the week** *(disabled by default)* — a day-of-week ordering
  option. Note: in this release the day-of-week transformation is a placeholder and
  leaves the string unchanged, so enabling it has no practical effect yet.

## Reindex batch size

- **Items per batch** (`rebuild_items_per_batch`, default **100**) — how many
  entities are processed per batch step during a rebuild. Lower it if a rebuild is
  timing out on a large site; raise it to finish faster on a fast server.

## Saving triggers a reindex

Because the stored, sortable values depend on these settings, **saving the form
also rebuilds the index** so existing content is re-transformed to match your new
rules. You don't need a separate rebuild after changing settings here.

## Setting values with Drush

```bash
drush cget views_natural_sort.settings
drush cset views_natural_sort.settings rebuild_items_per_batch 250 -y
drush cset views_natural_sort.settings transformation_settings.days_of_the_week.enabled true -y
```

## Rebuild the index

The index is normally kept current automatically — a row is written whenever an
entity is saved and removed when it's deleted. You should rebuild manually in two
cases: **after a bulk import** (content added without going through normal saves),
and **after changing transformation settings outside this form**. To rebuild:

- In the UI: on the settings form, expand the **"Incase of Emergency"** section and
  click **Rebuild Index**.
- There is **no Drush command** for the rebuild; it runs as a batch from that
  button (or programmatically via the module's service).

Until a rebuild finishes, some rows may still sort by their old transformed values.
