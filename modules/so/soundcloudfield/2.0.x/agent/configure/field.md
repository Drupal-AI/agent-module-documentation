# SoundCloud Field — field type, widget, formatters

No admin settings page. Add a field of type **SoundCloud** on *Manage fields*, pick the
widget on *Manage form display*, and choose one of four formatters on *Manage display*.

## Field type `soundcloud`

- Class `SoundCloudItem`. One property `url` (`uri`), DB column `url` varchar **2048**,
  nullable. `default_widget = soundcloud_url`, `default_formatter = soundcloud_default`.
- Constraint: a `Length` max of 512 and a widget-level regex
  `@^https?://(api\.|.?)soundcloud\.com/([^"\&]+)@i` (invalid values are rejected on submit
  with "Please provide a valid SoundCloud URL.").

## Widget `soundcloud_url`

- Renders a `#type => url` element (`#maxlength` 2048). One setting: `placeholder_url`
  (example text shown in the empty input). Single-cardinality fields are wrapped in a fieldset.

## Formatters

| Formatter id | Label | How it renders |
|---|---|---|
| `soundcloud_default` | Default (PHP-based) | Server-side Guzzle GET to `https://soundcloud.com/oembed?...&url=<encoded>`; decodes the oEmbed JSON, rewrites the `<iframe>` width/height and query params from settings. `#allowed_tags => ['iframe']`. On request failure prints "content … is not available, or it is set to private." |
| `soundcloud_js` | Javascript | Attaches libraries `soundcloudfield/soundcloud_sdk` (external SDK from `connect.soundcloud.com/sdk/sdk-3.3.2.js`) + `soundcloudfield/soundcloudfield_init` (`js/soundcloudfield.js`); passes per-item settings to `drupalSettings.soundcloudfield[<cleanCssId>]` and renders theme `soundcloudfield_js_embed`. |
| `soundcloud_link` | Link to SoundCloud URI | `#type => link` to the URL. Settings: `trim_length` (default 80), `rel` (`nofollow`), `target` (`_blank`). |
| `soundcloud_url` | Raw output of SoundCloud URI | Emits the URL string as markup. |

## Player settings (both player formatters)

Defaults come from `defaultSettings()` and constants in `soundcloudfield.module`
(`SOUNDCLOUDFIELD_DEFAULT_WIDTH = 100`, HTML5 height `166`, sets height `450`, visual height `450`):

| Key | Default | Meaning |
|---|---|---|
| `soundcloud_player_type` | `classic` (default fmt) / `visual` (js fmt) | Classic compact vs. large visual player. |
| `soundcloud_player_width` | `100` | Width in **percent**. |
| `soundcloud_player_height` / `soundcloud_player_classic_height` | `166` | Classic player height for single tracks. |
| `soundcloud_player_height_sets` | `450` | Height used when the URL is a set/playlist. |
| `soundcloud_player_visual_height` | `450` | Visual player height (`300`/`450`/`600`). |
| `soundcloud_player_color` | `ff7700` | Accent color (hex, no `#`). |
| `soundcloud_player_autoplay` | off / on | Autoplay on load. |
| `soundcloud_player_showartwork` | off/on | Show artwork. |
| `soundcloud_player_showcomments` | on | Show comments. |
| `soundcloud_player_hiderelated` | off | Hide related tracks. |
| `soundcloud_player_showteaser` | on | Show SoundCloud overlays. |
| `soundcloud_player_showuser` | on | Show user info. |
| `soundcloud_player_showplaycount` | off | Show play count. |

Set/track detection: for the classic player the URL path is parsed; if the third path
segment is missing or `sets`, the "height for sets" is used, otherwise the single-track height.

## Notes for agents

- The **default** formatter needs outbound HTTP from the web server to soundcloud.com at
  render time; the **javascript** formatter needs the visitor's browser to reach the
  SoundCloud CDN. No API key is required (public oEmbed).
- Field/widget/formatter settings are stored under the usual
  `field.storage_settings.soundcloud`, `field.widget.settings.soundcloud_url`, and
  `field.formatter.settings.soundcloud_default` config schema keys.
