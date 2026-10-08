# Acquia CMS Page — manual setup guide

**Acquia CMS Page** (`acquia_cms_page`) ships a ready-made, **unstructured Page
content type** — for landing pages and other free-form content — with its fields,
form display, view displays, pathauto pattern, and metatag defaults already
built. Enable it and the Page type exists, editor-ready, without a site builder
assembling any of it by hand.

It is one small piece of **Acquia CMS**, Acquia's Drupal distribution, assembled
from single-purpose modules like this one. The value and the limitation are the
same fact: this is *distribution configuration, not a generic feature*. It
encodes Acquia's opinions about what a Page should be and is designed to sit
alongside the rest of the Acquia CMS family, sharing their common layer
(`acquia_cms_common`). On an Acquia CMS site it is exactly right; on an unrelated
site it is a strong set of assumptions to take on. Enabling it pulls in
`acquia_cms_image` (and, through it, the common layer).

Because it is configuration, what it does is fixed by that config: it creates the
Page content type and wires its displays. Extending it means adding fields and
adjusting displays as you would with any content type. There is no settings form
of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the dependency chain it brings with it).

## Where it lives in the admin menu

This module has no configuration page of its own. Once enabled it adds a **Page**
content type:

- **Content → Add content → Page** (`/node/add/page`) to author a page.
- **Structure → Content types → Page**
  (`/admin/structure/types/manage/page`) to review or extend its fields, form
  display, and view displays.

## How to use it

Editors create Pages from **Content → Add content → Page** for free-form landing
content. To change the model — add a field, adjust a display — edit the Page
content type under **Structure → Content types**, exactly as with any Drupal
content type; your changes export with the rest of your site configuration.
