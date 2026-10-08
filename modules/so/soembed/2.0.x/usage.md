<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple oEmbed is a text-format filter that turns a bare media URL on its own line into an embedded player or card via the oEmbed protocol — paste a YouTube link and it becomes a video, with no media entity to create.

---

oEmbed is the standard by which a provider answers "given this URL, give me embed markup", and it is what makes pasting a link Just Work on most modern platforms. Drupal supports oEmbed through the media system, which is the right architecture for assets an editor manages deliberately, but heavier than needed when the requirement is simply that a pasted link renders. This module takes the lighter path: a single text filter (`filter_soembed`) that finds standalone URLs — or, optionally, URLs anywhere in the text — and replaces each with rich media, delegating the actual resolution and fetch to Drupal core Media's oEmbed services (provider repository, URL resolver, resource fetcher) and rendering video/rich results inside core's oEmbed iframe. Because it is a filter, it applies at render time to every piece of content in that text format, including content that predates the filter and content arriving through an API. You enable and order it per text format (before "Convert URLs into links"), set a maximum embed width, choose block or inline matching, and — with the optional `oembed_providers` module — restrict which provider buckets a format may use. It depends on core `media` and spans `^9.5 || ^10 || ^11`.

---

- Turn a pasted YouTube link into a player.
- Embed rich media by URL with no markup.
- Let editors embed without creating a media entity.
- Apply embedding at render time across a format.
- Cover content imported from another system.
- Embed a tweet or social post by link.
- Reduce editor training on embeds.
- Handle embeds entirely within a text format.
- Embed a map or a presentation by URL.
- Support pasted links inside comments.
- Render embeds consistently through core's oEmbed iframe.
- Add embedding to a legacy content set retroactively.
- Configure embedding per text format.
- Set a maximum width for embedded media.
- Match URLs inline when the WYSIWYG stores body on one line.
- Restrict embedding to selected providers via oembed_providers buckets.
- Embed a podcast or audio player by link.
- Embed content from many oEmbed providers at once.
- Keep unrecognized URLs displaying as plain links.
