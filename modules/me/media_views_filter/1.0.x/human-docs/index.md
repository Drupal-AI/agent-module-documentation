# Media Views Filter — manual setup guide

**Media Views Filter** (`media_views_filter`) fixes a small but genuinely annoying
gap in Drupal's media administration: the difference between a **media entity's
name** and the underlying **file's name**. Core's media content view (at
`/admin/content/media`) lets you filter only by the media name, while the files
view (`/admin/content/files`) lets you filter by file name but gives you no way to
edit the associated media. So when a content editor remembers a file was called
`spring-campaign-hero.jpg` but not what the media item was titled, neither view
helps. This module adds a Views **text filter that searches media name *and* file
name (and media image alt text) together**, so editors can find media by whatever
they happen to remember.

Alongside the combined filter, it provides two Views **fields** for transparency:
one that displays the **file name/path** and one that displays the **image alt
text**. Adding these to your view makes it obvious to editors why a given result
matched the search.

The module has **no permissions, no routes, and no settings page** of its own — it
supplies Views plugins that you wire up by editing a media view. It works on
Drupal 9, 10 and 11, has no module dependencies beyond core Views and Media, and
is currently a release candidate (1.0.0‑rc1). The `OHSU` package name marks it as
a module released from an institution's own site work.

> **Tip.** The media library modal is itself a view (`media_library`), so the
> filter and fields here can be placed there too — which is where editors do most
> of their searching.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Views and Media.

There is **no configuration page** for this module — it has no settings form. You
enable its filter and fields by editing a media view, described in "How to use it"
below.

## Where it lives in the admin menu

Media Views Filter adds no admin settings page. You configure it from the Views UI
at **Structure → Views**, editing a media view (for example
`/admin/structure/views/view/media`).

## How to use it

To swap in the combined filter:

1. Go to **Structure → Views** and edit a core media view, for example at
   `/admin/structure/views/view/media`.
2. Under **Filter criteria**, click **Add**, tick **"Media name/file name"**, and
   click **Add and configure filter criteria**.
3. Tick **"Expose this filter to visitors, to allow them to change it"**, then
   click **Apply**.
4. **Remove** the original **"Media: Name"** filter (the new one replaces it).
5. **Save** the view, then visit its path — you can now filter by media name, file
   name, and image alt text from one box.

Optionally, add the supporting fields so the results explain themselves:

1. Edit the same view and, under **Fields**, add the **"File name"** field
   (**Add** → tick it → **Add and configure fields** → **Apply**).
2. Repeat to add the **"Alt text"** field if you want it visible.

> If you use configuration synchronisation, remember to **export configuration**
> after editing the view so your changes are captured.
