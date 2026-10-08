<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alpha Pagination Sample View (alpha_pagination_sample_view) — agent index

Optional submodule of **Alpha Pagination** that installs one example View demonstrating the A-Z
paginator. No code — config only.

- **Version:** 3.0.1 · **Core:** `^9 || ^10 || ^11` · **License:** GPL-2.0-or-later
- **Depends on:** `views`, `alpha_pagination`.
- **Parent:** [`../../../../agent/start.md`](../../../../agent/start.md).

## What it installs

`config/install/views.view.alpha_pagination_sample.yml` — a View named `alpha_pagination_sample`:

- Base table `node_field_data`; filters to published (`status = 1`) **article** nodes.
- Fields: `title` (link to entity) and `body` (trimmed summary).
- **Header:** `Global: Alpha Pagination` handler (`plugin_id: alpha_pagination`), source field `title`,
  link path `[alpha_pagination:path]/[alpha_pagination:value]`, "All" item shown, individual numeric
  items (`paginate_view_numbers: 1`) before the letters with a `-` divider.
- **Contextual filter** on `title` with `glossary: true`, `limit: 1`, `case: upper`,
  `default_argument: all` (exception value `all`) — the glossary letter the paginator links to.
- **Page display** `page_1` at path `/alpha-pagination-sample`; access `perm: 'access content'`.

## Operate

`drush en alpha_pagination_sample_view`, then browse `/alpha-pagination-sample`. Create article content
(e.g. with Devel) so letters activate. Delete the imported View if you only wanted it as a reference.
No routes/permissions/services/schema of its own.
