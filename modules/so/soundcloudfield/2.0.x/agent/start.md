# SoundCloud Field — agent index

Provides a `soundcloud` field type (stores one SoundCloud URL) plus a widget and four
display formatters. No global config page (`configure` null), no permissions, no Drush.
Depends only on core `field`. All configuration is per-field on *Manage form display* /
*Manage display*.

- **Field type, widget, the four formatters and every setting key** →
  [configure/field.md](configure/field.md)

Key facts:
- Field type `soundcloud` → column `url` (varchar 2048); default widget `soundcloud_url`,
  default formatter `soundcloud_default`. Validated against regex requiring a `soundcloud.com` host.
- Formatters: `soundcloud_default` (server-side oEmbed fetch via Guzzle to
  `https://soundcloud.com/oembed`), `soundcloud_js` (client-side, loads SDK from
  `connect.soundcloud.com` CDN + `js/soundcloudfield.js`, theme hook `soundcloudfield_js_embed`),
  `soundcloud_link` (hyperlink), `soundcloud_url` (raw text).
- No dependency on an API key; oEmbed is public. Private/unavailable tracks render a
  fallback message.
