# Acquia CMS Document — manual setup guide

**Acquia CMS Document** (`acquia_cms_document`) ships a ready-made **Document
media type** — for downloadable documents such as PDFs — with its fields, form
display, view displays, and related configuration already built. Enable it and
the Document media type exists, editor-ready, without a site builder assembling
any of it by hand.

It is one small piece of **Acquia CMS**, Acquia's Drupal distribution, assembled
from single-purpose modules like this one. The value and the limitation are the
same fact: this is *distribution configuration, not a generic feature*. It
encodes Acquia's opinions about what a Document should be and is designed to sit
alongside the rest of the Acquia CMS family, sharing their common layer
(`acquia_cms_common`). On an Acquia CMS site it is exactly right; on an unrelated
site it is a strong set of assumptions to take on — usable as a starting point,
but you inherit the whole model, and it expects its siblings to be present.

Because it is configuration, what it does is fixed by that config: it creates the
Document media type and wires its displays. Extending it means adding fields and
adjusting displays as you would with any media type, and it travels with a config
export like any other configuration. There is no settings form of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

This module has no configuration page of its own. Once enabled it adds a
**Document** media type, found in the usual core Media locations:

- **Content → Media → Add media → Document** (`/media/add/document`) to upload a
  document.
- **Structure → Media types → Document**
  (`/admin/structure/media/manage/document`) to review or extend its fields,
  form display, and view displays.

## How to use it

Editors upload documents from **Content → Media → Add media → Document**, and the
resulting media can be referenced from any media-reference field. To change the
model — add a field, adjust a display — edit the Document media type under
**Structure → Media types**, exactly as with any Drupal media type; your changes
export with the rest of your site configuration.
