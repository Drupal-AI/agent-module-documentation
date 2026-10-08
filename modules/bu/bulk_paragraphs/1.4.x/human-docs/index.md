# Bulk Paragraphs — manual setup guide

**Bulk Paragraphs** (`bulk_paragraphs`) helps editors create many paragraph
items at once instead of adding them one at a time. If you build content out of
repetitive paragraphs — rows in a table, a stack of identical cards, a long list
of similar blocks — this module bulk-generates them for you, with default field
values that you set and, optionally, values that increment from one item to the
next.

The point is speed. Rather than clicking "Add paragraph" dozens of times and
filling in each one by hand, you tell the module how many you want and what the
starting values should be, and it produces them in one go. That makes building
long, repetitive paragraph-based content much faster.

Using the feature is gated by the **`use bulk paragraphs`** permission, so you
decide which roles get it. The module builds on the contributed
[Paragraphs](https://www.drupal.org/project/paragraphs) module and core's
Datetime module, and it runs on Drupal 10.2+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Paragraphs.

## Where it lives in the admin menu

Bulk Paragraphs has no settings page of its own. It works inside the content
forms where you already edit paragraph fields — any node or entity form that
includes a Paragraphs field. Once a role has the **`use bulk paragraphs`**
permission (granted at **People → Permissions**,
`/admin/people/permissions`), users with that permission get the bulk-generate
option when working with paragraphs.

## How to use it

1. Grant the **`use bulk paragraphs`** permission to the roles that should be
   able to mass-create paragraphs.
2. Edit any content that has a Paragraphs field.
3. Use the bulk option to generate several paragraph items at once, setting the
   default field values you want them to start with. Where a value can
   increment, each generated item steps the value up from the previous one — handy
   for numbered or sequential content.

Because the module only generates items into a form you are already editing,
nothing is saved until you save the host content as usual.
