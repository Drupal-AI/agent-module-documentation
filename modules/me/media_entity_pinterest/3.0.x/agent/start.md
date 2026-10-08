# Media entity Pinterest — agent index

Adds a core-Media **`pinterest`** media source for pins, boards, board sections, and profiles, plus a
`pinterest_embed` field formatter that renders them with Pinterest's `pinit.js`. No admin settings page
(`configure` null), no permissions. Depends on core `media`. URL-only — **no Pinterest API integration**.

- **Create the Pinterest media type + source field + formatter (UI/config/Drush) and the one setting** →
  [configure/media-type.md](configure/media-type.md)
- **The source plugin, URL patterns, metadata attributes, validation constraint, formatter & pinit.js** →
  [plugins/source.md](plugins/source.md)

Key facts:
- Source plugin id `pinterest`; allowed source field types: `link`, `string`, `string_long`.
- Recognised URL shapes: pin `/pin/{id}`, board `/{user}/{slug}`, section `/{user}/{slug}/{section}`,
  profile `/{user}` (across regional pinterest.* domains).
- Metadata attributes: `id`, `board`, `section`, `user` (+ `default_name`, `thumbnail_uri`).
- Formatter `pinterest_embed` attaches library `media_entity_pinterest/integration`, which loads the
  external `https://assets.pinterest.com/js/pinit.js`.
- Only config: `media_entity_pinterest.settings:local_images` (default `public://pinterest-thumbnails`).
