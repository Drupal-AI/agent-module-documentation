# Configuration

There are two ways to run the fix: from an individual field's settings (handy right
when you enable translation on that field) or from the bulk admin form (for
repairing many entities at once). Both do the same thing — copy the reference value
from each entity's original translation into its other translations.

> Take a database backup before a large run, and remember the bulk form isn't
> behind a dedicated permission, so run it only as a trusted administrator.

## Option A — from a field's settings

Use this when you're enabling translation on a reference field and want to backfill
its existing translations in the same step:

1. Edit the entity-reference field on the relevant bundle (Structure → *the entity
   type* → *Manage fields* → the field).
2. Enable **"Users may translate this field."**
3. In the **"Entity reference field translation synchronizes"** fieldset, tick
   **"Synchronize existing translations with original value."**
4. Optionally tick **"Overwrite existing translated value with original value"** —
   this resynchronizes *every* existing value, not just the empty ones. Leave it
   unticked to fill only the empty translations.
5. Save the field settings. The synchronization runs for that field.

## Option B — the bulk admin form

Use this when several fields, or several bundles, need repairing at once:

1. Go to **Configuration → Development → Entity Reference Field Translation
   Synchronize** (`/admin/config/development/ereftras`).
2. Choose the **entity type** (for example Content/node, or Taxonomy term).
3. Choose the **bundle** — the selectors are AJAX-driven, so the available bundles
   and fields update as you pick.
4. Select one or more **translatable entity-reference fields** to synchronize.
   Limiting the run to just the fields you need avoids touching unrelated data.
5. Optionally tick the **overwrite / "synchronize non-empty values too"** option to
   overwrite all values rather than filling only the empty ones.
6. Submit. The module loads all entities of that bundle and runs a **Batch API**
   process, copying the source value into each translation and saving the changed
   translations — safe for large content sets because it runs in batches.

## What happens afterward

Once a run completes, the translated entities point at the same referenced targets
as their source language again. You can re-run the process later (for example after
importing more untranslated reference data) as often as needed.
