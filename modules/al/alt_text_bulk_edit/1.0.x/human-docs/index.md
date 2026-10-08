# Alt text bulk edit — manual setup guide

**Alt text bulk edit** (`alt_text_bulk_edit`) is an editor tool for reviewing and
fixing the **alternative text** on many image media items at once. Good alt text
matters for accessibility and for SEO, but correcting it one media item at a time
is slow — this module gathers your image media into a single editable table so you
can work through them quickly.

On its admin page it lists image media with an editable alt-text box and a small
thumbnail preview next to each, so you can see the image while you write its
description. Alongside the in-page table it offers a **CSV round-trip**: export the
current alt text to a spreadsheet, edit it there, then re-import — with a
confirmation step that shows you the changes before anything is saved. Updates are
applied through Drupal's Batch API, so even a large media library processes without
timing out, and you get a count of how many items were updated (or failed) at the
end.

Every screen in the module is gated by core's **update any media** permission —
the normal capability for an editor who is allowed to change media. There are no
anonymous or public endpoints. Because that permission grants write access to
every media item, only grant it to trusted editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## Where it lives in the admin menu

The tool lives under your media content area at
**`/admin/content/media/alt-text`**. From there the export, import, and
confirmation screens are reached as you work.

## How to use it

1. Grant **update any media** to the roles that should be allowed to do this
   (**People → Permissions**), then log in as such a user.
2. Go to **`/admin/content/media/alt-text`**. You'll see a table of image media,
   each with a thumbnail and an editable alt-text field.
3. **Edit inline:** type new alt text directly in the table and save. Changes are
   applied in a batch, and you'll see how many items were updated.
4. **Or use the spreadsheet workflow:**
   - **Export** the current alt text to a CSV file.
   - Edit the alt-text column in your spreadsheet program.
   - **Import** the revised CSV. A **confirmation** screen shows the changes for
     review, and only when you confirm does the batch apply them.

The module writes to each media item's configured source image field, so it
respects how each media type is set up.
