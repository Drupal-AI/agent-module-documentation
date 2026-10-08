# Acquia CMS Place — manual setup guide

**Acquia CMS Place** (`acquia_cms_place`) ships a ready-made **Place content
type** — a location or venue — with its fields, form display, view displays,
pathauto pattern, and metatag defaults already built. It includes a postal
**address** field, a **telephone** field, and **geocoding** (so an address can be
turned into map coordinates). Enable it and the Place type exists, editor-ready,
without a site builder assembling any of it by hand.

It is one small piece of **Acquia CMS**, Acquia's Drupal distribution, assembled
from single-purpose modules like this one. The value and the limitation are the
same fact: this is *distribution configuration, not a generic feature*. It
encodes Acquia's opinions about what a Place should be and is designed to sit
alongside the rest of the Acquia CMS family, sharing their common layer
(`acquia_cms_common`). On an Acquia CMS site it is exactly right; on an unrelated
site it is a strong set of assumptions to take on. Other modules (Event, Person)
depend on Place, so it is often present as a foundation piece.

Because it is configuration, what it does is fixed by that config: it creates the
Place content type and wires its displays. Extending it means adding fields and
adjusting displays as you would with any content type. There is no settings form
of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the dependency chain it brings with it).

## Where it lives in the admin menu

This module has no configuration page of its own. Once enabled it adds a
**Place** content type:

- **Content → Add content → Place** (`/node/add/place`) to author a location.
- **Structure → Content types → Place**
  (`/admin/structure/types/manage/place`) to review or extend its fields, form
  display, and view displays.

## How to use it

Editors create locations from **Content → Add content → Place**, entering the
address, phone, and other details; geocoding turns the address into coordinates
for mapping. To change the model — add a field, adjust a display — edit the Place
content type under **Structure → Content types**, exactly as with any Drupal
content type; your changes export with the rest of your site configuration.
