# Link Formatter Query Fix — manual setup guide

**Link Formatter Query Fix** (`link_formatter_query_fix`) provides a patched
version of core's Link field formatter that corrects how query strings are
rendered. Core's default Link formatter had a bug where query parameters could be
duplicated in the output; this module ships a drop‑in formatter — **Link (query
duplication fix)** — that renders links with query strings correctly.

It is a focused bug‑fix module. The stored field value is never changed; only the
display output is corrected, and the module has no effect on access or content.
You select the fixed formatter on a link field's display, and it renders in place
of core's built‑in Link formatter.

Worth knowing: the underlying core issue was fixed in **Drupal 10.2.3**. If your
site is on that version or newer, core already renders link query strings
correctly and you generally do not need this module — it exists chiefly for sites
on older releases that cannot yet upgrade.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and
   select the formatter.

There is **no configuration page** for this module. You choose the fixed
formatter per link field on **Manage display**, described below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from **Structure → Content
types → *(your type)* → Manage display**, where you pick the **Link (query
duplication fix)** formatter for a link field.

## How to use it

1. Enable the module and rebuild the cache (`drush cr`).
2. Go to the **Manage display** page for a content type (or other entity) that
   has a link field.
3. In the **Format** column for that link field, choose **Link (query duplication
   fix)** and save.

The link now renders with its query string handled correctly, without touching
the stored value.
