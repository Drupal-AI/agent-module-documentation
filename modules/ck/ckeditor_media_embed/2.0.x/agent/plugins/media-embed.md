<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CKEditor 5 plugin, toolbar button & render filter

This module does **not** define any Drupal plugin *type*. It provides one CKEditor 5 plugin
definition plus a Filter plugin and a Field formatter plugin (instances of core types).

## CKEditor 5 plugin definition

`ckeditor_media_embed.ckeditor5.yml` → `ckeditor_media_embed_embed_media`:

- CKEditor plugins loaded: `mediaEmbed.MediaEmbedEditing`, `mediaEmbed.MediaEmbedUI`.
- Toolbar item: **`MediaEmbed`** (label "Insert media", shown as "Media embed").
- Editing library: `ckeditor_media_embed/media-embed`; admin library `ckeditor_media_embed.admin`.
- Allowed elements: `<figure>`, `<figure class>`, `<oembed>`, `<oembed url>`.

Add the button by editing the text editor at *Configuration → Content authoring → Text formats
and editors* (`/admin/config/content/formats`): drag **Media embed** into the Active toolbar for
a CKEditor 5 format, then save. The button only functions once the plugin JS is downloaded
(see [../drush/commands.md](../drush/commands.md)); if the JS is missing the module removes its
CKEditor plugins via `hook_ckeditor_plugin_info_alter()` and logs an error.

## What gets stored, and the filter that renders it

When an author inserts media, CKEditor saves an element like:

```html
<oembed url="https://www.youtube.com/watch?v=…"></oembed>
```

The stored `<oembed>` tag is turned into real embed markup **at render time** by the filter:

- Filter id: **`filter_ckeditor_media_embed`** — title *"Convert Oembed tags to media embeds"*,
  type `TYPE_TRANSFORM_REVERSIBLE`.
- It runs only when the text contains `<oembed`; it hands the text to the `ckeditor_media_embed`
  service (`processEmbeds()`), which fetches each URL from the configured provider and replaces
  the `<oembed>` node with a `<div class="embed-media embed-media--<type>-<provider>">` wrapping
  the returned HTML.

**You must enable this filter on the text format** (`/admin/config/content/formats/manage/<format>`)
or embeds never render. In `filter.format.<format>` config this is
`filters.filter_ckeditor_media_embed.status: true`.

## Filter ordering

Because it fetches remote HTML and injects it, keep it running before restrictive HTML filters
would strip the result, and ensure "Limit allowed HTML tags" (if used) permits the embed markup
(iframes/`figure`). The filter has no settings of its own (`settingsForm()` returns `[]`).
