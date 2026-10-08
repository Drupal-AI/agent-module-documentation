# Acquia CMS Image — manual setup guide

**Acquia CMS Image** (`acquia_cms_image`) ships a ready-made **Image media
type** — for image assets — with its fields, form display, view displays, and
related configuration already built, including a **focal point** for smart
cropping and **IMCE** file browsing. Enable it and the Image media type exists,
editor-ready, without a site builder assembling any of it by hand.

It is one small piece of **Acquia CMS**, Acquia's Drupal distribution, assembled
from single-purpose modules like this one. The value and the limitation are the
same fact: this is *distribution configuration, not a generic feature*. It
encodes Acquia's opinions about what an Image should be and is designed to sit
alongside the rest of the Acquia CMS family, sharing their common layer
(`acquia_cms_common`). On an Acquia CMS site it is exactly right; on an unrelated
site it is a strong set of assumptions to take on. Several other Acquia CMS
modules (Place, Page, DAM) depend on Image, so it is often present as a
foundation piece.

Because it is configuration, what it does is fixed by that config: it creates the
Image media type and wires its displays. Extending it means adding fields and
adjusting displays as you would with any media type. There is no settings form of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

This module has no configuration page of its own. Once enabled it adds an
**Image** media type:

- **Content → Media → Add media → Image** (`/media/add/image`) to upload an
  image.
- **Structure → Media types → Image**
  (`/admin/structure/media/manage/image`) to review or extend its fields
  (including the focal point), form display, and view displays.

## How to use it

Editors upload images from **Content → Media → Add media → Image**, set the focal
point so automated crops stay centered on the subject, and the resulting media
can be referenced from any media-reference field. To change the model, edit the
Image media type under **Structure → Media types**, exactly as with any Drupal
media type; your changes export with the rest of your site configuration.
