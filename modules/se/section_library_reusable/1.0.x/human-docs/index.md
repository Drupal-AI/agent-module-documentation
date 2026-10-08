# Section library reusable — manual setup guide

**Section library reusable** (`section_library_reusable`) extends the
**Section Library** module by letting you store a Layout Builder section as a
genuinely *reusable* block rather than a one-off copy. It adds a **"reusable"
checkbox** to Section Library's **"Add to library"** form. When you tick that box,
the selected section is saved as a reusable **block content** entity, and your
original section is replaced with a lightweight wrapper section that links to that
shared block.

The benefit is single-source reuse: because the section becomes one reusable
block, placing it in several layouts references the same block content, so editing
it in one place updates it everywhere it appears — instead of maintaining separate
copies. It builds directly on top of Section Library and depends on it. It is a
site-building / content-display convenience and has no access-control role.

The module works by adding to an existing form, so there is no separate settings
screen to configure — once it and Section Library are enabled, the extra checkbox
simply appears when you add a section to the library. It supports Drupal 9, 10,
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Section Library.

## How to use it

Wherever Section Library gives you an **"Add to library"** action on a Layout
Builder section, you will now see a **reusable** checkbox on that form. Check it
before saving to store the section as a reusable block; leave it unchecked to keep
Section Library's normal behavior. Once saved as reusable, the section is a shared
block you can place again in other layouts, and updates to it propagate to every
placement.
