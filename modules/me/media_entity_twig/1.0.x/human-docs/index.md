# Media Entity Twig — manual setup guide

**Media Entity Twig** (`media_entity_twig`) provides a media source whose content
is a rendered **Twig template**. It lets you add Twig templates, content, and
components as media items that can be reused anywhere you can add media — so an
interactive component you have built can be featured and reused just like an image
or a video. It is aimed at theme developers, frontend engineers, and site builders
who want "Twig things" to live in the media system, and it targets Drupal 10.3 and
newer.

When you enable it, a new **Twig** media type is created automatically, complete
with a default Twig field, and you can customise or add fields on it like any other
media type. From then on, editors can add media of type Twig alongside the usual
image and video types, and the rendered template output appears wherever the media
is displayed.

There is an important trust boundary to respect. Because these media items render
Twig, they can contain markup and template logic — so the ability to create or
edit Twig media is effectively the ability to introduce template code. Restrict
that ability to trusted site builders and theme developers, the same people you
would trust with the theme layer, and don't hand it to general content editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its
   `twig_field` dependency) with Composer and enable it.

This module has no central settings page. The Twig media type is created for you on
enable; you customise it through the standard media type field UI, described below.

## Where it lives in the admin menu

Media Entity Twig adds no admin settings form. The **Twig** media type it creates
appears under **Structure → Media types** (`/admin/structure/media`); you customise
its fields at `/admin/structure/media/manage/twig/fields`. Individual Twig media
items are managed from **Content → Media** (`/admin/content/media`) or through the
Media Library.

## How to use it

1. After enabling the module, go to **Structure → Media types**
   (`/admin/structure/media`) and confirm the new **Twig** media type is present.
   A default Twig field is added for you automatically.
2. Customise or add fields on the type at
   `/admin/structure/media/manage/twig/fields` if you need more than the default.
3. Add Twig media from **Content → Media → Add media → Twig**, providing the
   template/markup for the item, and save.
4. Reference the media anywhere media is supported — media reference fields, the
   Media Library, and CKEditor — to reuse your component across the site.

> **Restrict who can create Twig media.** Under **People → Permissions**
> (`/admin/people/permissions`), grant the module's Twig media create/edit
> permissions only to trusted site builders and theme developers. A Twig media
> item can contain template logic, so treat this like access to the theme layer.
