# File linktext formatter — manual setup guide

**File linktext formatter** (`file_linktext_formatter`) solves one small,
specific annoyance: when you display a file field, Drupal normally uses the raw
filename as the clickable download link — something like
`report-final-v3.pdf`. This module lets you use the value of *another* text field
on the same entity as the link text instead, so visitors see a friendly label
like "2024 Annual Report" while the underlying file stays exactly as uploaded.

It does this by adding a single field formatter called **"Link text from field"**
for core File fields. Behind the scenes it works just like Drupal's generic file
formatter — it renders each file as a download link with the file's cache tags —
except the link text is pulled from a sibling one‑line text (`string`) field that
you choose. If no field is chosen, it quietly falls back to the normal filename,
so nothing breaks. The formatter is only offered on **single‑value** file fields.

There's nothing to configure globally and no permissions to grant: everything
happens on the **Manage display** tab of whatever content type, media type, or
paragraph carries the file field. The only dependency is core's **File** module,
and it runs on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

(There's no separate configuration page — this module has no settings form. You
set it up per field on **Manage display**, described below.)

## Where it lives in the admin menu

There is no admin settings page. The formatter appears as a display option
wherever you have a single‑value File field: **Structure → [your entity type] →
Manage display**.

## How to use it

1. First make sure the entity (content type, media type, paragraph, etc.) has
   both a single‑value **File** field and a one‑line **Text (plain)** / `string`
   field to supply the label — for example a "Document title" field.
2. Go to that bundle's **Manage display** tab.
3. Find the File field and set its **Format** to **"Link text from field"**.
4. Click the format's cog/gear icon to open its settings. Set **"Use field value
   as link text"** to the text field you want to use as the label (for example
   *Document title*), or leave it on **"Disabled"** to keep the default filename.
5. Save the display.

Now the file downloads exactly as before, but the visible link text comes from
your chosen field. A few things worth knowing:

- It only works on **single‑value** file fields — multi‑value file fields won't
  offer this formatter.
- The dropdown only lists **plain‑text (`string`) fields** from the same bundle,
  so pick or create an appropriate one‑line text field for the label.
- Because the label lives in a real content field, it's editable per item and can
  be translated if the source field is translatable — which also makes for more
  descriptive, accessible link text than an internal or hashed filename.
- You can mix and match per view mode: use the filename in one display and
  field‑based link text in another.
