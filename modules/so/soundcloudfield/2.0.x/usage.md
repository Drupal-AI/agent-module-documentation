SoundCloud Field adds a dedicated `soundcloud` field type for storing a SoundCloud track or set (playlist) URL and rendering it as an embedded player.

---

The module defines one field type (`soundcloud`, a single `url` varchar column up to 2048 chars, validated against a `soundcloud.com` URL pattern), one widget (`soundcloud_url`, an HTML5 URL input with an optional placeholder), and four formatters. `soundcloud_default` (PHP-based) does a server-side Guzzle request to SoundCloud's oEmbed endpoint (`https://soundcloud.com/oembed`) and rewrites the returned iframe with your width/height/color/visual settings. `soundcloud_js` attaches the SoundCloud JS SDK (loaded from `connect.soundcloud.com` CDN) plus `js/soundcloudfield.js` and renders the player client-side via the `soundcloudfield_js_embed` theme hook. `soundcloud_link` renders a plain link to the URL (with trim length, `rel=nofollow`, new-window options) and `soundcloud_url` outputs the raw URL text. Player options (classic vs visual player, width %, height, height-for-sets, autoplay, color, show/hide artwork, comments, related tracks, play count, user) are configured per formatter on *Manage display*. There is no global settings page and no permissions; everything is field-level config stored in the field/widget/formatter settings schema. Heights auto-adjust for sets (playlists) by inspecting the URL path.

---

- Add a SoundCloud audio field to a content type, taxonomy term, or any fieldable entity.
- Store a single SoundCloud track URL per field value.
- Embed a SoundCloud set / playlist URL and let the player auto-size for sets.
- Render an embedded HTML5 SoundCloud player server-side via oEmbed (default formatter).
- Render the player client-side using the SoundCloud JS SDK (javascript formatter).
- Choose the classic (compact) player or the visual (large artwork) player.
- Set the player width as a percentage of the container.
- Set custom heights for single tracks vs. sets.
- Pick the visual player height from 300 / 450 / 600 px.
- Set the player accent color via a hex value (default `ff7700`).
- Enable autoplay when the page loads.
- Toggle artwork, comments, play count, user info, and related tracks.
- Show a plain hyperlink to the SoundCloud URL instead of a player (link formatter).
- Trim the displayed link text and add `rel="nofollow"` or open-in-new-window.
- Output the raw SoundCloud URL as text (URL formatter) for theming or feeds.
- Provide a placeholder/example URL in the edit form via the widget setting.
- Validate that entered URLs point at `soundcloud.com` before saving.
- Build a podcast or music archive listing where each node embeds one player.
- Fall back to a graceful "content not available / private" message when oEmbed fails.
