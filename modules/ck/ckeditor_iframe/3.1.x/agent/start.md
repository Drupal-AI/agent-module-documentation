<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ckeditor_iframe — agent start

Adds an **Iframe Embed** button to **CKEditor 5** so editors can insert/edit `<iframe>`
embeds in rich text. One Drupal CKEditor 5 plugin, `ckeditor_iframe_embed_iframeembed`
(JS plugin `iframeembed.IframeEmbed`), providing one toolbar item, `iframeEmbed`
(label "Iframe Embed"). No global admin page (`configure` is `null`) — it is turned on
per **text format** at `/admin/config/content/formats`, stored on the
`editor.editor.<format>` config entity. A per-format checkbox group ("Allowed optional
attributes") decides which iframe attributes are permitted and drives the allowed-HTML
filter automatically. (A legacy CKEditor 4 plugin also ships for the CKE4→CKE5 transition.)

- Add the Iframe Embed button to a format, pick allowed attributes, allowed-tags handling → [configure/text-format.md](configure/text-format.md)
- The plugin id, toolbar item, settings key, config schema, allowed-elements logic → [plugins/iframe-embed.md](plugins/iframe-embed.md)
