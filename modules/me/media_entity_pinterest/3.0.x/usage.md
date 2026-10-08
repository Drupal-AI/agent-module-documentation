Media entity Pinterest adds a **Pinterest** media source to Drupal core Media, letting you store Pinterest pins, boards, board sections, and user profiles as media entities from their URL and render them as native Pinterest embeds.

---

The module provides a core `MediaSource` plugin (`pinterest`) whose source field can be a `link`, `string`,
or `string_long` field holding a Pinterest URL. A set of regular expressions (`Pinterest::$validationRegexp`)
recognises four URL shapes — pin (`/pin/{id}`), board (`/{user}/{slug}`), board section
(`/{user}/{slug}/{section}`), and user profile (`/{user}`) — across regional Pinterest domains
(pinterest.com, pinterest.co.uk, jp.pinterest.com, …). From a matched URL it exposes metadata attributes
`id`, `board`, `section`, `user`, plus a sensible `default_name` and `thumbnail_uri`. A validation
constraint (`PinEmbedCode` / `PinEmbedCodeConstraintValidator`) rejects source values that match none of the
patterns. The `pinterest_embed` field formatter renders the stored URL into the matching Pinterest embed
markup via one of four theme hooks (`media_entity_pinterest_{pin,board,board_section,profile}`) and attaches
the module's `integration` library, which loads Pinterest's official `pinit.js` widget script from
`https://assets.pinterest.com/js/pinit.js` (declared non-GPL, external) to turn the markup into a live embed.
There is no admin settings page (`configure` is null) and no permissions; the only config is
`media_entity_pinterest.settings:local_images` (default `public://pinterest-thumbnails`) for thumbnail
storage. **Pinterest API integration is not implemented** — everything is derived from the public URL/embed.

---

- Create a "Pinterest" media type backed by the `pinterest` source to manage pins as media entities.
- Embed a single Pinterest **pin** by pasting its `/pin/{id}` URL.
- Embed a whole Pinterest **board** from its `/{user}/{board}` URL.
- Embed a board **section** from its `/{user}/{board}/{section}` URL.
- Embed a Pinterest **user profile** feed from its `/{user}` URL.
- Reuse pins in any entity by adding a media-reference field pointing at the Pinterest media type.
- Validate editor input so only genuine Pinterest URLs are accepted (via the `PinEmbedCode` constraint).
- Support international Pinterest domains (`.co.uk`, `.jp`, `jp.pinterest.com`, etc.) automatically.
- Auto-generate a media name from the pin ID or user/board/section when none is given.
- Render pins/boards/profiles with the official Pinterest `pinit.js` widget for a live, styled embed.
- Add a Pinterest field to the media library for editors to pick from.
- Store a source URL in a plain string, long-string, or link field — whichever suits the workflow.
- Display curated inspiration boards on campaign or blog pages.
- Show a brand's Pinterest profile feed in a sidebar block via a media-reference field.
- Present a product board section (e.g. a seasonal collection) inline in content.
- Migrate Pinterest URLs from another system into Drupal media using the source field.
- Use URL-decoding-aware matching so encoded URLs still resolve correctly.
- Keep media metadata (pin id, board slug, section, user) queryable via the source's metadata attributes.
- Configure where local thumbnail images are stored via `media_entity_pinterest.settings:local_images`.
- Build a Views listing of Pinterest media rendered with the `pinterest_embed` formatter.
- Provide a code-free way for editors to add Pinterest content without touching Pinterest's embed HTML.
