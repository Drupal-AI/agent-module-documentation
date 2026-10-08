<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flickr Integration Suite connects Drupal to Flickr and offers three ways to surface photos: a configurable block, a field, and a text-format filter — with a Colorbox variant of the filter.

---

Flickr remains where a lot of institutional and community photography actually lives, particularly for museums, councils and clubs whose archive predates any Drupal site. Copying that into Drupal's media library duplicates storage and rights management; pointing at it keeps one source of truth. The suite gives three placement options because the right one depends on who is placing it: a block for a site builder, a field for a content model, a filter for an editor writing prose who wants a photoset inline.

The split into submodules is deliberate — enable only the placement you use, rather than carrying three integration points because one was needed. `flickr_integration_suite_filter_colorbox` extends the filter with lightbox display.

**Credential handling is done right.** `key:key` is a hard dependency and the API credentials are held as a Key entity rather than in configuration, so the value can come from an environment variable and never reaches a config export. That is the pattern to look for in any API integration and a good part of this suite are not.

Practical notes: a Flickr API key is rate-limited, so a page that renders many photosets should be cached rather than fetching per request; and photo licensing on Flickr varies per image, so displaying someone else's photostream is a rights question the module cannot answer for you.

---

- Display a Flickr photoset on a Drupal site.
- Place a Flickr block in a region.
- Add a Flickr field to a content type.
- Embed a photoset inline with a text filter.
- Open Flickr images in a lightbox.
- Keep photography in Flickr as the source of truth.
- Show an institution's archive without re-uploading it.
- Give editors an inline way to add photos.
- Enable only the placement method a site needs.
- Store the Flickr API key in a Key entity.
- Keep API credentials out of exported configuration.
- Cache Flickr output to stay within API rate limits.
- Show a photostream on a community site.
- Check photo licensing before displaying a stream.
- Configure the integration from one settings form.
- Audit which Flickr accounts a site displays.