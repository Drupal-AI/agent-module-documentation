# Filelist formatter — manual setup guide

**Filelist formatter** (`filelist_formatter`) adds a field formatter — labelled
simply **"List"** — for core **file** fields. Instead of core's default file table
or plain links, it renders each attached file as an item in an ordered (`<ol>`) or
unordered (`<ul>`) HTML list, and can optionally show each file's size next to its
link. It is the tidy way to present downloads or attachments as a clean bulleted or
numbered list.

The formatter respects the file field's own display and description settings: it
uses each file's description as the link text when the field has descriptions
enabled, and otherwise falls back to the filename. When you turn on **Show
filesize** it appends a human‑readable size to each item.

It is purely a **display formatter** — no admin pages, no routes, no permissions,
no stored state of its own. File access stays governed entirely by core File. You
configure it per view mode on a field's *Manage display* tab. Filelist formatter
targets **Drupal 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
set it up on a field's display, described in "How to use it" below.

## Where it lives in the admin menu

Filelist formatter adds no admin page. You use it entirely from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage display**, by
choosing the **List** format for a file field.

## How to use it

1. Go to the **Manage display** tab for the bundle that has your file field — for
   example **Structure → Content types → Article → Manage display**.
2. Find your **file** field and set its **Format** to **List**.
3. Click the gear/settings icon next to the format to open its three options:
   - **List type** — choose **Unordered list (`ul`)** for bullets or **Ordered
     list (`ol`)** for numbers.
   - **List classes** — optional CSS classes added to the generated list, so you
     can style it from your theme.
   - **Show filesize** — tick this to append each file's human‑readable size after
     its link.
4. Click **Update**, then **Save** the display.

Your file field will now render as a bulleted or numbered list on that view mode.
Toggle the filesize display and list type independently per view mode, and style
the list through the class setting plus theme CSS.
