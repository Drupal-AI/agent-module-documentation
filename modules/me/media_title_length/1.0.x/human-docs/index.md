# Media Title Length — manual setup guide

**Media Title Length** (`media_title_length`) lets a site set the maximum length of
the media entity **name (title)** field. Drupal core caps the media name at 255
characters, which is too short for some sites — long document titles,
auto-generated names from bulk uploads or stock-image modules, or migrations that
carry titles longer than 255 characters. This module lets you raise (or lower) that
limit from a simple settings form.

What makes it more than a cosmetic setting is that it changes the limit in **two
places at once**: the media `name` base-field definition *and* the underlying
database column. When you save a new length, the module widens (or narrows) the
`varchar` column on both the `media_field_data` and `media_field_revision` tables —
and, if the Admin Audit Trail module is present, its reference column too — so the
field definition and the actual storage stay in sync.

One caution worth stating plainly: because this performs a live database schema
change, **increasing** the length is safe, but **shrinking** it below the length of
data you already store risks truncating existing media names. Choose a reduction
carefully.

It requires only core **Media** and supports Drupal 8.8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media dependency.
2. [Configuration](configuration/index.md) — set the media title length on the
   settings form.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Media Title Length settings**
(`/admin/mtl/config`), protected by the **modify title length** permission.
