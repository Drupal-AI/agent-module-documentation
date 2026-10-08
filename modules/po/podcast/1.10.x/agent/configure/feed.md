# Building a podcast feed View and mapping fields

There is no global settings page. Everything is configured on a Views **feed** display.

## Build the View

1. Structure → Views → **Add view**; base = the content type holding episodes. Page/Block
   optional. Save and edit.
2. On the View, **Add → Feed**. This creates a feed display.
3. **Format → Show** → **RSS Feed** → select **Podcast RSS Feed** (style `podcast_rss`).
4. **Format → Show** (row) → select **Podcast Fields** (row `podcast_rss_fields`).
5. Add ordinary Views **fields** for every piece of data (title, body, audio file URL,
   pub date, image, etc.). Use Views' **Custom text** field for static/literal values
   (e.g. a fixed category string) that you then map below.
6. Map fields using the select boxes in the style/row settings (below).
7. Set the feed **path** (Feed Settings → path, conventionally ending `rss.xml`). Save.

Mapping works by picking, for each podcast property, which View field supplies its value
(`buildElementFromOptions()` reads the selected field id per row). `- None -` leaves a
property out.

## Channel (show) mappings — style `podcast_rss`

Stored under `display_options.style.options`.

- **Required selects:** `title_field`, `link_field`, `lastBuildDate_field`.
- **Text inputs:** `generator` (default "Podcast module for Drupal"), `language`
  (ISO-639, e.g. `fr-ca`; falls back to current interface language).
- **Optional field selects:** `description_field`, `itunes:explicit_field`,
  `itunes:owner--name_field`, `itunes:owner--email_field`, `itunes:author_field`,
  `itunes:summary_field`, `itunes:keywords_field`, `itunes:image_field`,
  `itunes:category_field`, `itunes:new-feed-url_field`, `podcast:guid_field`,
  `podcast:funding_field`, `podcast:funding_text_field`, `podcast:license_field`,
  `podcast:medium_field`, `podcast:locked_field`.
- **`itunes:type`** select: `episodic` (default) or `serial`.
- **`copyright_field`** uses a `select_or_other_select` widget — pick a View field **or**
  type a literal copyright string (this is why `select_or_other` is required).
- **Value-4-Value payments** (`podcast:payments` details group, all field selects):
  `podcast:value_type_field`, `podcast:value_method_field`, `podcast:value_suggested_field`,
  `podcast:value_recipient_name_field`, `podcast:value_recipient_type_field`,
  `podcast:value_recipient_address_field`, `podcast:value_recipient_split_field`.

Notes:
- `itunes:category` values are parsed as `Category/Subcategory`, comma-separated for
  multiples (`processCategories()`), emitting nested `<itunes:category>` tags.
- The iTunes image is absolutised against the current host and also drives a channel
  `<image>` element and a derived `<link>`.
- `podcast:locked` emits its value lowercased with the owner email as the `owner` attribute.

## Item (episode) mappings — row `podcast_rss_fields`

Stored under `display_options.row.options`.

- **Audio enclosure** (`enclosure_field_options` details): `enclosure_field_url`
  (**required**), `enclosure_field_length`, `enclosure_field_type` (MIME). Emitted as
  `<enclosure url length type>`.
- **iTunes selects:** `itunes:author_field`, `itunes:keywords_field`,
  `itunes:explicit_field` (true/false), `itunes:duration_field`, `itunes:summary_field`,
  `itunes:image_field`, `itunes:season_field`, `itunes:episode_field`.
- **Podcast Index selects:** `podcast:chapters_field` (JSON chapters URL),
  `podcast:transcript_field` (transcript URL — MIME auto-detected from extension:
  html→text/html, vtt→text/vtt, json→application/json, srt→application/x-subrip,
  else text/plain), `podcast:soundbite_start_field`, `podcast:soundbite_duration_field`,
  `podcast:soundbite_description_field`, `podcast:person_field` (comma-separated → one
  `<podcast:person>` per name).
- Inherited core RssFields options (title/link/description/creator/date/guid) still apply;
  `link_field` values must start with a leading slash (they are absolutised).

## Validate

Test the feed path in a validator such as <https://podba.se/validate/> or Apple Podcasts
Connect before submitting to directories.
