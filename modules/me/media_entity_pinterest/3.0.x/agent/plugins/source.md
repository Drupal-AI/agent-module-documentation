# The Pinterest media source, formatter & validation

## Media source plugin (`src/Plugin/media/Source/Pinterest.php`)

`@MediaSource(id = "pinterest")`, `allowed_field_types = {link, string, string_long}`,
`default_thumbnail_filename = "pinterest.png"`. Extends `MediaSourceBase`, implements
`MediaSourceFieldConstraintsInterface`.

### Recognised URL patterns (`Pinterest::$validationRegexp`)

Matched case-insensitively against the URL-decoded source value, across regional domains
(`pinterest.com`, `pinterest.co.uk`, `jp.pinterest.com`, `pinterest.jp`, `www.pinterest.*`, …):

| Kind | Shape | Captured groups |
|---|---|---|
| Pin | `pinterest.<tld>/pin/{id}` | `id` |
| Board | `pinterest.<tld>/{username}/{slug}` | `username`, `slug` |
| Board section | `pinterest.<tld>/{username}/{slug}/{section}` | `username`, `slug`, `section` |
| User profile | `pinterest.<tld>/{username}` | `username` |

### Metadata attributes (`getMetadataAttributes()` / `getMetadata()`)

- `id` — pin ID, `board` — board slug, `section` — section slug, `user` — username.
- `default_name` — pin ID for pins; `user - board - section` / `user - board` / `user` otherwise.
- `thumbnail_uri` — local thumbnail if present, else the base default.

`getSourceFieldConstraints()` returns the `PinEmbedCode` constraint (below).

## Validation constraint (`src/Plugin/Validation/Constraint/`)

- `PinEmbedCodeConstraint` — `@Constraint(id="PinEmbedCode")`, message `"Not valid Pin URL/embed code."`,
  applies to `link`/`string`/`string_long`.
- `PinEmbedCodeConstraintValidator::validate()` runs every regexp against the URL-decoded value and adds a
  violation if **none** match. This is what stops editors saving non-Pinterest URLs.

## Field formatter (`src/Plugin/Field/FieldFormatter/PinterestEmbedFormatter.php`)

`@FieldFormatter(id = "pinterest_embed")`, for `link`/`string`/`string_long`. For each item it:

1. Runs the same regexps to classify the URL.
2. Builds a render array with the matching theme hook — `media_entity_pinterest_pin`,
   `media_entity_pinterest_board`, `media_entity_pinterest_board_section`, or
   `media_entity_pinterest_profile` — reconstructing the canonical `https://…pinterest.<tld>/…` path in
   `#path` and setting `data-conversation="none"` and `lang` attributes.
3. Attaches library `media_entity_pinterest/integration`.

The formatter has no settings form yet (a `@todo` in source).

## Libraries (`media_entity_pinterest.libraries.yml`)

- `integration` → `js/pinterest.js` (a no-op stub) + depends on `pinterest.widgets`.
- `pinterest.widgets` → external `https://assets.pinterest.com/js/pinit.js` (async/defer, declared
  **not** GPL-compatible / proprietary Pinterest widget). This script scans the rendered markup and turns
  it into the live Pinterest embed. Loading it means each page with a Pinterest embed calls out to
  Pinterest's CDN.

## No API

There is deliberately no Pinterest API client — pins/boards/profiles are handled purely from their public
URL and rendered by Pinterest's own widget script. API integration is listed as a future addition in the
README.
