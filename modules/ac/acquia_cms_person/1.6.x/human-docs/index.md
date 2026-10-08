# Acquia CMS Person — manual setup guide

**Acquia CMS Person** (`acquia_cms_person`) ships a ready-made **Person content
type** — a structured representation of people associated with a website or
organization, such as staff or author profiles — with its fields, form display,
view displays, pathauto pattern, and metatag defaults already built. Enable it
and the Person type exists, editor-ready, without a site builder assembling any
of it by hand.

It is one small piece of **Acquia CMS**, Acquia's Drupal distribution, assembled
from single-purpose modules like this one. The value and the limitation are the
same fact: this is *distribution configuration, not a generic feature*. It
encodes Acquia's opinions about what a Person should be and is designed to sit
alongside the rest of the Acquia CMS family, sharing their common layer
(`acquia_cms_common`). On an Acquia CMS site it is exactly right; on an unrelated
site it is a strong set of assumptions to take on. Enabling it pulls in
`acquia_cms_place` and `scheduler` (and, through Place, the rest of the chain).

Because it is configuration, what it does is fixed by that config: it creates the
Person content type and wires its displays. Extending it means adding fields and
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
**Person** content type:

- **Content → Add content → Person** (`/node/add/person`) to author a profile.
- **Structure → Content types → Person**
  (`/admin/structure/types/manage/person`) to review or extend its fields, form
  display, and view displays.

## How to use it

Editors create profiles from **Content → Add content → Person**. Because it
depends on Scheduler, Person content can also be scheduled for publish/unpublish.
To change the model — add a field, adjust a display — edit the Person content
type under **Structure → Content types**, exactly as with any Drupal content
type; your changes export with the rest of your site configuration.
