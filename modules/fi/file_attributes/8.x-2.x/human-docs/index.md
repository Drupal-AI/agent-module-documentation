# File attributes — manual setup guide

**File attributes** (`file_attributes`) lets editors add custom **HTML anchor
attributes** to the links Drupal renders for file-field downloads — things like
`target="_blank"`, `rel="nofollow"` or `rel="noopener"`, the HTML5 `download`
attribute, and custom CSS classes. If you have an entity with a file field and you
want that file rendered as a link carrying extra attributes, this is the module for
it.

It extends the core File field non-destructively. Rather than a new field type, it
adds an `options` (attributes) property to the existing `file` field, so it works
with your existing file uploads — no re-upload needed. It ships two pieces you wire
up on a field: a **widget** that gives editors form controls for entering attributes
per file item, and a **formatter** that renders each file as a link with those
attributes applied to the anchor tag. It supports both single- and multi-value file
fields, generates absolute file URLs, and can use the file's description as the link
text.

It has no module dependencies beyond core's file/field support.

> **Compatibility note:** this release declares support for **Drupal 9.3+ and 10**
> (`core_version_requirement: ^9.3 || ^10`). It does not declare Drupal 11 support,
> so check the project page for a newer release before using it on Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings form**. You configure it per field on the entity's
**Manage form display** and **Manage display** pages — see "How to use it" below.

## Where it lives in the admin menu

File attributes adds no admin configuration page. You use it entirely from
**Structure → *(entity type)* → Manage form display** (for the widget) and
**Manage display** (for the formatter) of a content type or other fieldable entity
that has a file field.

## How to use it

1. On the entity's **Manage form display** (for a content type: **Structure →
   Content types → *(type)* → Manage form display**), set your file field to use the
   **File attributes** widget. This exposes form controls where editors enter the
   attributes (such as `rel`, `target`, `download`, or CSS classes) for each file
   item.
2. On **Manage display**, set the same field's format to the **File attributes**
   formatter. Now the file is rendered as a link with the stored attributes applied
   to its anchor tag.
3. Create or edit content, upload (or keep) a file, and fill in the attributes you
   want on the widget. The rendered download link will carry them — for example
   opening in a new tab or forcing a download — with no custom theme or template
   required.
