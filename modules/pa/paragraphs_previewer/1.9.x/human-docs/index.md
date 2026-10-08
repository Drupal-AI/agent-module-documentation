# Paragraphs Previewer — manual setup guide

**Paragraphs Previewer** (`paragraphs_previewer`) adds a **Preview** button to
every paragraph row on an entity edit form. Click it and a modal pops open showing
that single paragraph rendered with your site's front-end theme — even though the
paragraph (and the node around it) has not been saved yet. It saves editors the
tedious "save, view the page, go back, edit, save again" loop when they are
building a page out of many paragraphs.

The module works by replacing the standard Paragraphs field widget with its own
previewer version. Once you switch a field to the previewer widget, each paragraph
row gains the Preview button; clicking it opens a full-width, draggable, resizable
modal containing an iframe that renders just that one paragraph. Because the
preview reuses the front-end theme but strips away the page header, footer, and
surrounding blocks, editors see the paragraph's own markup on its own — great for
checking a hero, card, or callout before publishing, and for resizing the modal to
test responsive behaviour.

There is **no admin settings page**. You turn the previewer on per field (by
choosing its widget on *Manage form display*), and there is a single site-wide
option — which view mode the preview renders with — plus one permission that
controls who may open previews.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the preview permission.

## Where it lives in the admin menu

It has no page of its own. You enable it on the **Manage form display** tab of
whichever entity type holds your Paragraphs field — for example
`/admin/structure/types/manage/article/form-display` for the Article content
type. The one global option (preview view mode) is not exposed in the UI and is
set with Drush (see below).

## How to use it

### 1. Switch the field to the previewer widget

1. Go to the host bundle's **Manage form display** tab (e.g.
   `/admin/structure/types/manage/article/form-display`).
2. Find your Paragraphs field and change its **Widget** from *Paragraphs* to
   **Paragraphs Previewer**.
3. Click the gear/cog icon and set **Default edit mode** to **Closed** (so rows
   start collapsed and are previewed rather than expanded), then **Update**.
4. **Save**. The widget summary now shows `Previewer: Enabled`.

If you are on an older site still using the legacy *Paragraphs (previous)* inline
widget, there is a matching **Entity reference paragraphs previewer** widget so you
can keep that style and still get previews.

### 2. Grant the permission

The Preview button appears for everyone, but the modal only works for users with
the **View any paragraphs previewer** permission — without it the preview returns
a "403 Forbidden". Grant it to every role that edits paragraphs (see
[Installation](installation/index.md#grant-the-permission)).

### 3. (Optional) Choose the preview view mode

By default previews render with the **full** view mode. To use a more compact view
mode such as *teaser*, set it site-wide with Drush:

```bash
drush cset paragraphs_previewer.settings previewer_view_mode teaser -y
```

### Good to know

- The previewer widget only appears for actual Paragraphs fields (technically,
  `entity_reference_revisions` fields).
- The preview uses the front-end theme but strips page chrome, so a paragraph whose
  look depends on surrounding node markup may render slightly differently from the
  final page.
- The Preview button is hidden for rows marked for removal and for paragraphs the
  user has no permission to view.
