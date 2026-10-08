<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
oEmbed Thumbnail Chooser rewrites the thumbnail URL that YouTube and Vimeo return, stepping down from the highest resolution to whatever actually exists, so remote video media get a usable, sharp poster image.

---

Core's oEmbed media source takes whatever thumbnail the provider hands back: for YouTube that is `hqdefault`, a 480×360 image that looks soft in any modern layout, and for Vimeo a small `295x166` variant. Higher resolutions exist — YouTube's `maxresdefault` and `sddefault`, Vimeo's `1280` and `960` — but only for some videos, with no advance indication of which. The module implements the only reliable strategy: **try, and fall back.** It hooks `hook_oembed_resource_data_alter()`, rewrites the size token in `$data['thumbnail_url']` to the largest option, requests it with `\Drupal::httpClient()->get()`, and on any `RequestException` steps down to the next size and finally keeps the original; on the Vimeo success paths it also updates the reported `thumbnail_width`/`thumbnail_height` so downstream image styles work from accurate dimensions. Everything else passes through unchanged — only YouTube and Vimeo URLs are touched, and non-video providers are ignored. Two things are worth knowing before you rely on it. First, **cost**: each oEmbed resource fetch now performs up to two additional synchronous outbound HTTP requests, inside the request that creates or refreshes the media, using a full `GET` (not a lightweight `HEAD`) with no explicit timeout — so it inherits the site's default Guzzle timeout, which adds up on a bulk import of remote videos. Second, **compatibility**: stock Drupal core does not actually invoke `hook_oembed_resource_data_alter()`, so as the project page notes the module depends on the core patch from issue **#3042423**; without that patch the module installs but does nothing. Install it with `composer require drupal/oembed_thumbnail_chooser` and enable it with `drush en oembed_thumbnail_chooser` (it depends on core Media). There is no configuration, no settings form, and no permissions — enabling it is the whole setup.

---

- Get a high-resolution YouTube thumbnail (`maxresdefault`/`sddefault`).
- Get a high-resolution Vimeo thumbnail (`1280`/`960`).
- Avoid soft poster images on video cards.
- Fall back automatically when `maxresdefault` does not exist.
- Keep accurate thumbnail dimensions for image styles.
- Improve remote video presentation in a grid or listing.
- Alter oEmbed resource data with a single hook.
- Leave non-YouTube, non-Vimeo providers untouched.
- Budget for up to two extra HTTP requests per video.
- Watch import time on bulk remote-video creation.
- Check the site's default Guzzle timeout before mass imports.
- Confirm the core patch from issue #3042423 is applied.
- Verify the hook actually fires on your core version.
- Re-save media to refresh existing thumbnails.
- Use larger image styles on video posters.
- Avoid upscaling a 480×360 thumbnail in CSS.
- Confirm the provider actually offers a larger thumbnail.
- Keep media thumbnails consistent across a listing.
- Install with Composer and enable with Drush — no config needed.
- Depend only on core Media, nothing else.
