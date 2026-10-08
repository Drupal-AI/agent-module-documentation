# Easy Breadcrumb — manual setup guide

**Easy Breadcrumb** (`easy_breadcrumb`) replaces Drupal's core breadcrumb with a
configurable, **path-based** trail. Instead of the minimal breadcrumb core produces,
it builds one crumb per segment of the current URL (using the path alias) and, by
default, appends the **current page title** as the last crumb — so visitors get a
complete `Home › Section › Page` trail with no per-page setup. It works out of the
box the moment you enable it, and it needs no modules beyond core.

Everything is tuned from a single settings form with dozens of options: whether to
include a **Home** segment (and what to call it), whether to append the page-title
segment (and render it as a link), how segment text is **capitalized**, the
**separator** drawn between crumbs, and which **paths** are hidden from the trail.
This guide is written for a **human** clicking through the admin UI, step by step
with screenshots. If you want terse, token-cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

![The Easy Breadcrumb settings form](images/settings.png)

## Where it lives in the admin menu

Easy Breadcrumb adds one configuration page:

- **Configuration → User interface → Easy Breadcrumb**
  (`/admin/config/user-interface/easy-breadcrumb`)

That page has two tabs: **Settings** (all the options covered in this guide) and
**Translate easy breadcrumb** (for translating labels on multilingual sites).
Access to the form is gated by the **administer easy breadcrumb** permission.

## Contents

1. [Installation](installation/index.md) — install Easy Breadcrumb with Composer,
   enable it, and make sure the breadcrumb block is placed in your theme.
2. [Configuration](configuration/index.md) — walk through the key settings: the Home
   segment, the page-title segment, capitalization, the separator, and hidden paths.
