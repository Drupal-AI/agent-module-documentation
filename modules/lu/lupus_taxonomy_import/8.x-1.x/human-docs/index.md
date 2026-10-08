# Taxonomy Import — manual setup guide

**Taxonomy Import** (`lupus_taxonomy_import`) loads taxonomy terms from a **CSV
file**, hierarchy and all, so a vocabulary of a few hundred terms arrives in one
upload instead of one form submission at a time. Vocabularies routinely turn up
as a spreadsheet — a product classification from a supplier, a subject taxonomy
from a standards body, a location list from someone's export — and typing them in
by hand is nobody's idea of a good afternoon, while reaching for the Migrate
system to load a flat list is a lot of apparatus for a one‑off job. This module
sits neatly in that gap: upload a CSV and get terms.

It supports **hierarchical** import (nested parent/child terms) as well as flat
lists, and you can set custom field values on the terms as part of the import. If
your vocabulary is missing a field that your CSV references, add that field to the
vocabulary first — otherwise the column is simply ignored. To help you get the
shape right, the module serves **downloadable example CSV files** for both flat
and hierarchical imports directly on its import page.

Access is granted by the core **Administer taxonomy** permission *or* by the
module's dedicated **`import taxonomy csv`** permission — which is the genuinely
useful part of the design, because you can let a data‑entry person load
vocabularies without also handing them the power to restructure the site's
taxonomy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the import permission.

There is **no settings form** for this module — the entire interface is the
import page itself, described in "How to use it" below.

## Where it lives in the admin menu

The import page sits at **Configuration → Content authoring → Taxonomy CSV
import** (`/admin/config/content/taxonomy/csv_import`).

## How to use it

1. Install and enable the module, then grant yourself the **`import taxonomy
   csv`** permission (or use an account with **Administer taxonomy**) — see
   [Installation](installation/index.md).
2. Go to `/admin/config/content/taxonomy/csv_import`.
3. Download one of the **example CSV files** on that page (flat or hierarchical)
   to see the exact column layout the importer expects.
4. If any term field you want to populate does not yet exist on the target
   vocabulary, **add that field first** — otherwise its column is ignored.
5. Prepare your CSV in the same shape, choose the target vocabulary, upload, and
   run the import.

> **Two practical tips.** First, **test what happens when you re‑run an import**
> before you rely on it — whether a second run updates matching terms or creates
> duplicates changes how you fix a corrected spreadsheet, and it is far easier to
> check on a copy of the site than to clean up afterwards. Second, CSV exported
> from a spreadsheet carries the usual hazards — character encoding, a stray
> byte‑order mark (BOM), or quoted fields that contain the delimiter — so a failed
> import is more often the file than the module.
