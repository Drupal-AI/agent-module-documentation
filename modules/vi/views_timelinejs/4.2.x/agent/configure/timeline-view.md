# Build a TimelineJS View & set the library location

## Select the style on a View

1. Create/edit a View of the content you want (e.g. base table *Content*).
2. Add the **fields** you'll map (a date field is essential; also title/body/image as needed).
3. Set **Format → TimelineJS** (style plugin id `timelinejs`). The style *uses fields* and has
   **no row plugin**, so slide content comes entirely from the mapped View fields.
4. In the style settings, configure the three sections below.

Config lands in the View at
`display.<display>.display_options.style` → `type: timelinejs` with
`options: { timeline_config, additional_config, timeline_fields }`.

## Field mappings (`timeline_fields`) — Start date is required

Each is the machine name of a field you added to the View (or empty for none):

| Key | Purpose | Notes |
|---|---|---|
| `start_date` | **Required.** Slide/era start. | Must render a PHP-parseable date string; unparseable rows are skipped. |
| `end_date` | Slide/era end. | Required for `era` rows. |
| `display_date` | Text shown instead of start/end. | |
| `headline` | Slide headline. | HTML allowed. |
| `text` | Slide body text. | HTML allowed. |
| `media` | Media URL / blockquote / iframe. | Image fields handled specially (raw URL extracted from markup). |
| `credit` / `caption` / `thumbnail` | Media credit, caption, timenav thumbnail. | |
| `background` | Background image URL. | Image-field markup handled specially. |
| `background_color` | CSS color (hex or keyword). | |
| `group` | Groups events into lanes. | |
| `type` | Selects the entity type per row. | See below. |
| `unique_id` | Stable per-slide id (for hash bookmarks). | |

**Row `type` semantics** (value comes from the mapped Type field):
- empty / any other value → **event slide** (default)
- `title` or `timeline_title_slide` → the single **title slide** (a later one overwrites earlier)
- `era` or `timeline_era` → an **era** band (needs both start and end dates, else skipped)

If `start_date` is not mapped, the style renders nothing and shows a warning.

## Presentation options (`timeline_config` + `additional_config`)

Map onto TimelineJS settings: `font`, `width` (default `100%`), `height` (default `40em`),
`hash_bookmark`, `scale_factor` (default 2), `timenav_position` (bottom/top), `timenav_height`,
`timenav_height_percentage`, `timenav_mobile_height_percentage`, `timenav_height_min`,
`start_at_end`, `language` (empty = site language if TimelineJS supports it). Extra option
`additional_config.start_at_current` opens the timeline on the slide nearest today (overrides
`start_at_end`, and is translated internally to TimelineJS `start_at_slide`).

## Library location (site-wide setting)

Where the TimelineJS3 assets load from. Config object `views_timelinejs.settings`, key
`library_location`; settings form at route `views_timelinejs.admin`
(`/admin/config/development/views-timelinejs`, permission `administer site configuration`).

Allowed values:
- `cdn` — Knight Lab CDN, latest (not recommended)
- `cdn_3.9.7` — CDN pinned to 3.9.7
- `cdn_3.8.18` — CDN pinned to 3.8.18
- `local` — local copy; the library MUST live in `libraries/timeline3` (adds a `script_path` option)

Shipped default (config/install): `library_location: cdn`. Set via drush:

```bash
drush cset views_timelinejs.settings library_location cdn_3.9.7 -y
drush cget views_timelinejs.settings library_location
```
