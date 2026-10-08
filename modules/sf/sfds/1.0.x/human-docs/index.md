# Shared Field Display Settings — manual setup guide

**Shared Field Display Settings** (`sfds`) lets you define a field's display and form-
display settings once and share them across all instances of that field, so the same
field looks and behaves consistently wherever it appears. Instead of configuring a
field's formatter and widget separately on every bundle, you opt a field in to
sharing and let its display settings be tracked and applied from one place.

The sharing is opt-in per field, and you choose how broadly it applies — a single
**Global** default, or **Per bundle** where one bundle's settings become the shared
source. It's a site-building/theming convenience: it configures how fields are
displayed, with no content or access-control role of its own. It needs no other
modules and supports Drupal 10.2 and 11.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no central settings page; you turn sharing on from a field's own **storage
settings**. After enabling the module:

1. (Optional) Consult your site's field list at **Reports → Field list**
   (`/admin/reports/fields`) to see which fields are shared.
2. Edit the **storage settings** of the field you want to share. You'll find a new
   section labelled **Shared field display settings**.
3. Tick **Enable shared field display for this field**.
4. Choose the **Shared field display mode** — **Global** or **Per bundle**.
5. Select a bundle from the list to use *that* bundle's field display settings as the
   global default.
6. Save the storage settings.

From then on, the shared display settings are tracked and applied to the opted-in
field across its instances, keeping its display consistent.
