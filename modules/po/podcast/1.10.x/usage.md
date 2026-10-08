Podcast lets you build a valid podcast RSS feed (iTunes/Apple Podcasts + Podcast Index namespaces) entirely with Views: it adds a Views feed **style** ("Podcast RSS Feed") and **row** ("Podcast Fields") plugin whose settings map your View's fields onto podcast/iTunes XML elements.

---

The module ships two Views plugins used together on a `feed` display: a style plugin `podcast_rss` (`Rss`, extending core Views `Rss`) that builds the channel-level XML, and a row plugin `podcast_rss_fields` (`RssFields`, extending core `RssFields`) that builds each `<item>`. Both use a shared `PodcastViewsMappingsTrait` to turn a selected View field into a keyed XML element (and to absolutise link/URL values). Instead of hard-coding data, you add ordinary Views fields (including Views' "Custom text" field for static values) and then, in the format settings, use select boxes to map each field to a channel property (title, description, copyright, `itunes:*`, `podcast:*` value/funding/locked, categories, owner name/email, image, etc.) or an item property (enclosure URL/length/type, `itunes:author/keywords/explicit/duration/summary/season/episode`, `podcast:chapters/transcript/soundbite/person`, guid, pubDate). The style plugin adds the `itunes`, `content`, `atom`, and `podcast` XML namespaces, parses hierarchical `itunes:category` values (`Category/Subcategory`, comma-separated), and derives an `<image>`/`link` from the iTunes image. Two Twig templates (`views-view-rss-podcast-feed`, `views-view-row-rss-podcast-feed`) render the feed, and `hook_preprocess` hooks serialize nested channel elements and wrap description/summary fields in CDATA. The copyright field uses a `select_or_other` widget so you can pick a View field or type a literal string — hence the dependency on the `select_or_other` module. There is no admin settings page (`configure` null) and no permissions; everything is configured on the View. A `post_update` hook migrated an older `copyright` option to `copyright_field`.

---

- Publish a podcast RSS feed from Drupal content (episodes as nodes) using only Views.
- Produce an Apple Podcasts / iTunes-compatible feed with the required `itunes:*` tags.
- Emit Podcast Index (`podcast:*`) tags like transcript, chapters, soundbite, person, funding.
- Map an audio file field to the episode `<enclosure>` (URL, length, MIME type).
- Set the show title, description, link, and lastBuildDate from View fields.
- Provide iTunes owner name/email and author for the feed channel.
- Mark the show or individual episodes explicit/clean via a mapped boolean field.
- Set an iTunes cover image for the show and per-episode images.
- Declare hierarchical iTunes categories (Category/Subcategory) from a field or custom text.
- Choose an episodic vs serial show type for iTunes.
- Add a per-episode transcript link with auto-detected MIME type (vtt/srt/json/html/plain).
- Add chapter data links (`podcast:chapters`) to episodes.
- Publish soundbite start/duration/description for episode highlights.
- List hosts/guests as `podcast:person` entries (comma-separated field).
- Set a copyright notice, choosing an existing field or typing a literal value.
- Emit `podcast:locked` to control whether other platforms may import the feed.
- Include Value-4-Value crypto payment info (`podcast:value` / valueRecipient) from fields.
- Set the feed language explicitly or fall back to the current interface language.
- Provide a `podcast:guid` for a globally unique podcast identifier.
- Set a new-feed-url when migrating the podcast to a different URL.
- Add funding/donation links (`podcast:funding`) with link text.
- Number seasons and episodes (`itunes:season`/`itunes:episode`) per item.
- Wrap description/summary output in CDATA automatically for safe HTML in the feed.
- Validate the resulting feed against Apple/Podcast Index validators before submission.
- Reuse existing content types and Views techniques — no bespoke entity or field required.
