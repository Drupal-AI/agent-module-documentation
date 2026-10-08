# Garden Gnome Package — manual setup guide

**Garden Gnome Package** (`garden_gnome_package`) publishes interactive panoramas
and object movies created with **Garden Gnome Software's Pano2VR and Object2VR**.
You export a package from Pano2VR or Object2VR, upload that package archive to a
field on your content, and the module unpacks it and embeds the appropriate
interactive viewer — a 360° panorama or a rotatable object movie — right in the
page.

It works as a **field type** (GgnomeField) with a matching **field formatter**
(GgnomeFieldFormatter). When you save a package file, the module unzips it into a
directory under the public files scheme, reads its `gginfo.json` (or legacy player
files) to detect whether it is a Pano2VR or Object2VR export, copies the correct
player into a versioned public directory, and renders the viewer with options such
as preview‑only, autoplay, a play button, and a starting node/view. A small
settings form lets you set site‑wide defaults such as the preview icon. It depends
on core's Field, Media, and System modules.

> **Security note — restrict who can upload packages.** Because the module extracts
> uploaded ZIP archives directly into the **web‑accessible public files
> directory**, uploading a package is a sensitive operation. Only grant the ability
> to create/edit package field values to **trusted editors**, and make sure your
> server does not execute PHP from the files directory. Treat uploaded packages the
> way you would any archive extracted onto a public web path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — the site‑wide defaults form, plus how
   to add and display a package field.

## Where it lives in the admin menu

The site‑wide settings form is at **Configuration → Media → Garden Gnome Package**
(`/admin/config/media/garden_gnome_package`), gated by the **Administer site
configuration** permission. You add the field itself on an entity's **Manage
fields** screen and configure its display on **Manage display**.

## How to use it

1. In Pano2VR or Object2VR, **export a package** for your panorama or object movie.
2. Add a **Garden Gnome Package** field to a content type at **Structure → Content
   types → *(type)* → Manage fields**, and set the display formatter on **Manage
   display** (see [Configuration](configuration/index.md)).
3. Create or edit content, **upload the package archive** into the field, and save.
   The module unpacks it and embeds the viewer.
4. Reuse the same package across multiple nodes if you like — player assets are
   versioned per package automatically.
