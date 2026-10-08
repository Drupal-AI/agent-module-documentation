# Images Import — manual setup guide

**Images Import** (`images_import`) bulk-imports images onto existing content by
reading a **CSV file**. Instead of opening each node, user, or other entity and
uploading a picture by hand, you prepare one spreadsheet that says which image
belongs to which entity, upload it, and the module attaches (or replaces) the
images for you. For a content team facing a large image set — after a migration,
a rebrand, or a batch of product photos — that turns a day of clicking into a
single upload.

The CSV is straightforward. You provide an `entity_title` column and an
`image_url` column; the module matches each row to the entity by its title and
fetches the image from the URL. If matching by title is ambiguous, you can add an
`entity_id` column and it will match on the entity ID instead. The module handles
the whole download-and-attach step itself, so you do **not** need to copy image
files onto the server beforehand — pointing at a URL is enough. It works with
both core **image** fields and **media** reference fields, can import single or
multiple images per entity, and can also remove existing images.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — nothing to configure up front.
You use it through its import screen, described in "How to use it" below.

## Where it lives in the admin menu

The module adds an import interface for uploading your CSV. Access to it is
controlled by a permission the module provides, so grant that permission (under
**People → Permissions**) to the roles that should be allowed to run imports
before pointing editors at the screen.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)), and
   grant the import permission to the appropriate role.
2. Prepare a CSV with an **`entity_title`** column and an **`image_url`** column,
   one row per image. Add an **`entity_id`** column instead of (or alongside)
   the title if you want to match on ID.
3. Open the module's import screen and upload the CSV.
4. The module downloads each image from its URL and attaches it to the matching
   entity's image or media field. It can create multiple images per entity, and
   can remove existing images where your data calls for it.

> **Security note.** This module is **not covered by the Drupal security
> advisory policy**, so weigh that before using it on a production site, and only
> grant its import permission to trusted editors — an import fetches files from
> whatever URLs the CSV contains.
