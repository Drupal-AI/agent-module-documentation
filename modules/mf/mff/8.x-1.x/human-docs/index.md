# Media File Formatters — manual setup guide

**Media File Formatters** (`mff`) adds display formatters for **file media
entities**, giving you more control over how file media render than core provides
out of the box. Core's file media rendering is fairly limited; this module fills the
common gaps — for example rendering a download link using the media entity's own
name, or displaying just the file's description.

Specifically, it provides two formatter behaviours:

- **Use the media "Name" field as the link text** instead of the file description,
  so your download links read the way you want.
- **Render the file's "Description" only, with no link** — handy in Views when you
  want to display a file field's description without creating a separate field.

When you use the Name field as the link text, the Description can still be shown
separately in a template with `{{ file._referringItem.description }}`. It is a
display-layer module with no security surface — it changes how existing,
access-controlled file media render, not what is accessible. It has no module
dependencies and works from Drupal 8.8 through 11.

> **Note:** the option to open a document in a new window requires a core patch —
> see core issue [#2727281](https://www.drupal.org/project/drupal/issues/2727281)
> (comment 43).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — you select the formatter on a field's Manage
display, described in "How to use it".

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → *(entity type)* →
Manage display** (or a Views field's formatter settings), where its formatters
appear as options for a file media field.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** of the entity/view mode that renders your file media
   field (for example a media reference field, or a file field on a media entity).
3. Set the field's format to the Media File Formatters option you want — using the
   media **Name** as the link text, or rendering the **Description** only with no
   link.
4. Save. To show the description alongside a Name-based link, add
   `{{ file._referringItem.description }}` in the relevant template.
