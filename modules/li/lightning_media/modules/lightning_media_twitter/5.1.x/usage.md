<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Twitter is the Lightning Media component that installs a **Tweet** media type on top of the contrib Media Entity Twitter module, gives it live previews and a "paste a URL" media-library form, and overrides the tweet template so embedded tweets show a visible placeholder inside CKEditor.

---

`hook_media_source_info_alter()` takes the `twitter` media source provided by `media_entity_twitter` and adds three things to its plugin definition: an `input_match` array (constraint `TweetEmbedCode`, field types `string` and `string_long`) so `MediaHelper` can recognise a pasted tweet URL, `preview => TRUE` so Lightning Media's `MediaForm` renders a live preview while the editor types, and `forms.media_library_add => AddByUrlForm::class` so the core media library gets an "Add via URL" step. It then swaps the source class for `Drupal\lightning_media_twitter\Plugin\media\Source\Twitter` via `Override::pluginClass()`. The module also ships its own `media-entity-twitter-tweet.html.twig` and a `hook_theme_registry_alter()` that repoints the `media_entity_twitter_tweet` theme hook at this module's `templates/` directory, plus a preprocess hook that injects Media Entity Twitter's Twitter icon as a `placeholder` variable — so an embedded tweet is visible in the editor even before the Twitter script runs. Validation is handled by `TweetEmbedCodeConstraint` / `TweetEmbedCodeConstraintValidator`. All configuration is in `config/install/` (not optional): the `media.type.tweet` type using the shared `embed_code` string field, the `field_media_in_library` boolean, and default/embedded/thumbnail/media_library displays.

---

- Add a ready-made Tweet media type in one `drush en`.
- Let an editor paste a tweet URL and see a live preview before saving.
- Add a tweet to the media library through the "Add via URL" form.
- Embed a tweet in an article body through the media library.
- Show a recognisable placeholder for embedded tweets inside CKEditor.
- Curate a set of tweets as reusable media entities rather than pasted markup.
- Reference tweets from a "social wall" paragraph or Layout Builder block.
- Build a Views listing of Tweet media for a campaign page.
- Validate a pasted tweet URL with the `TweetEmbedCode` constraint before saving.
- Hide unapproved tweets from the media library with `field_media_in_library`.
- Give tweets an `embedded` view display for in-body rendering.
- Give tweets a `thumbnail` view display for the media library grid.
- Restrict tweet creation to a communications role with `create tweet media`.
- Include tweets in a media slideshow with Lightning Media Slideshow.
- Track which article embedded which tweet via Entity Usage.
- Replace an ad-hoc "paste the Twitter embed code" text field with a proper media entity.
- Reuse the same tweet across several pages without duplicating markup.
- Override the tweet template further in your own theme, building on this module's version.
- Keep the tweet's canonical URL in the shared `embed_code` field so it can be re-rendered later.
- Translate the media item's name while keeping one shared embed code.
- Use `MediaHelper::getBundlesFromInput($url)` to detect that a pasted string is a tweet.
- Audit embedded tweets by querying media entities of the `tweet` bundle.
- Add a tweet-only media reference field to a content type.
- Swap the Twitter source for a fork by chaining another `Override::pluginClass()` call.
