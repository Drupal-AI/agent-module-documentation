# Acquia CMS Video — manual setup guide

**Acquia CMS Video** (`acquia_cms_video`) ships a ready-made **Video media type**
for Drupal, with its fields, form display, view displays and related configuration
already built. Enable it and editors have an editor-ready Video asset type from
the first minute — no need to hand-build the media type, wire up its widgets and
view modes, or set its pathauto and metatag defaults yourself.

It is part of the Acquia CMS distribution and is **configuration packaged as a
module** rather than a generic feature. It encodes Acquia's opinions about what a
Video should be and is designed to sit alongside the rest of the family, sharing
their common layer (**Acquia CMS Common**). On an Acquia CMS site it is exactly
right; on an unrelated site it is a usable starting point, but you take on the
whole content model and it expects its siblings to be present.

Because what it does is defined by that configuration, you extend it the same way
you would any media type — add fields and adjust displays on the Video type — and
it travels with a configuration export like any other content-type config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the media modules it requires.

## Where it lives in the admin menu

The module has no settings page of its own. Its result is a new media type you can
manage at **Structure → Media types → Video**
(`/admin/structure/media/manage/video`), and Video assets show up in the **Media**
library at **Content → Media** (`/admin/content/media`).

## How to use it

Enable the module and the Video media type is ready. Create a video the way you
create any media: go to **Content → Media → Add media → Video**, or pick Video
from the **Media Library** when filling a media field on a node. The form,
displays and defaults that come with the type handle the rest. To tailor it, edit
the Video type under Structure → Media types and add fields or tweak its displays
as you would any Drupal media type.
