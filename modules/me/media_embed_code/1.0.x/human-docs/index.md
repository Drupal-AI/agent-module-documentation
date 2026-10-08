# Media Embed Code — manual setup guide

**Media Embed Code** (`media_embed_code`) adds an "Embed Code" media type to
Drupal, giving editors a clean, reusable place to store third‑party script and
iframe snippets — social widgets, ad tags, tracking pixels, chat widgets, maps,
and similar embeds — as media entities instead of pasting raw markup into body
fields or templates. Once it is enabled, an editor can add an Embed Code item
through the standard Media Library, paste in the snippet, and then reference it
anywhere media is supported: media reference fields, Views, and the CKEditor 5
Media Library button in any text format.

Because the whole point of an embed snippet is to run, this media type renders
its stored value as **trusted, unsanitized markup** — that is what lets a
`<script>` or `<iframe>` actually work. The practical consequence is important:
anyone who can create or edit Embed Code media can execute arbitrary JavaScript
on every page where that item appears. Treat the ability to add these embeds the
same way you would treat the ability to deploy code, and grant the module's
"Create new media" and "Edit own/any media" permissions only to trusted,
administrative roles. There is one built‑in safeguard worth knowing about: inside
CKEditor 5's live preview, the module substitutes a safe thumbnail display rather
than running the embedded script in the editing surface.

It needs nothing beyond Drupal core — just the Media and Media Library modules —
and it works the moment you enable it, with no separate settings page to
configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media and Media Library.

There is **no configuration page** for this module. Setup happens entirely by
adding Embed Code media items and setting the right permissions, described below.

## Where it lives in the admin menu

Media Embed Code adds no settings form of its own. The Embed Code media type it
provides appears under **Structure → Media types**
(`/admin/structure/media`), and you create and manage individual embeds from the
**Content → Media** listing (`/admin/content/media`) or through the Media Library
wherever a media reference field or the CKEditor Media button offers it.

## How to use it

1. After enabling the module, the **Embed Code** media type is ready to use — you
   do not have to create it.
2. Go to **Content → Media → Add media → Embed Code**, or open the Media Library
   from a media reference field or the CKEditor 5 Media button, and choose Embed
   Code.
3. Paste the third‑party snippet (the `<script>` / `<iframe>` block the service
   gave you) into the embed field, give the item a recognizable name, and save.
4. Reference the saved item anywhere media is supported. Reusing the same media
   entity across pages means you can update the snippet in one place if the
   provider changes their code.

> **Restrict who can add embeds.** Under **People → Permissions**
> (`/admin/people/permissions`), the module exposes dynamically named
> permissions such as *Embed Code: Create new media* and *Embed Code: Edit
> own/any media*. Grant these only to roles you fully trust — an Embed Code item
> is stored, reusable JavaScript, so an untrusted editor could inject code that
> runs for every visitor. Remember too that a third‑party embed's script sees
> every visitor, so it is a privacy/consent question in the same way an analytics
> tag is.
