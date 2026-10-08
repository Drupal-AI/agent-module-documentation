# Media Entity Reference — manual setup guide

**Media Entity Reference** (`media_entity_reference`) provides a media type that
references other entities. In other words, it lets a media item wrap an entity
reference, so referenced content can be selected and reused through the familiar
media library and media reference workflow rather than through a plain entity
reference field. It depends on Drupal core's Media and Media Library modules and
runs on Drupal 10 and 11.

The practical use is to bring things that aren't files or embeds — other pieces of
content — into the media system, where editors already know how to search for,
pick, and reuse items via the Media Library. Because it is built on entity
reference, the referenced entities keep their own access rules: on display, a
visitor only sees what they are allowed to see. The module itself has no
access‑control role beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media and Media Library.

This module has no separate settings page. You set it up by creating a media type
that uses the reference source and pointing its reference field at the entities
you want to surface, described below.

## Where it lives in the admin menu

Media Entity Reference adds no admin settings form. The media types you create
with it appear under **Structure → Media types** (`/admin/structure/media`), and
individual reference media items are managed from **Content → Media**
(`/admin/content/media`) or through the Media Library.

## How to use it

1. **Create a media type that uses the reference source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), give it a name,
   and choose the reference **Media source** provided by this module. Save.
2. **Configure the reference field.** On the media type's **Manage fields** tab,
   set the source/reference field to point at the entity type (and, where
   applicable, the bundles) you want to be able to reference.
3. **Add items and reuse them.** Editors can now create media items that reference
   other entities, then pick them from the Media Library wherever media reference
   fields are used. On display, each referenced entity respects its own access
   rules.
