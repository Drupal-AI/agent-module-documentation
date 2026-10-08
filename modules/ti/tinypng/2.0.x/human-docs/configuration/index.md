# Configuration

TinyPNG is configured on one settings form, plus a per-image-style checkbox. This
page covers both, and explains the two ways compression can happen.

## Open the settings form

1. Log in as a user with the **`administer tynipng`** permission.
2. Go to **Configuration → Media → TinyPNG**, or navigate directly to
   `/admin/config/tinypng`.

## The settings

### API key

Paste in your TinyPNG / Tinify API key (from
[tinypng.com/developers](https://tinypng.com/developers)). This is **required** —
with an empty or invalid key, nothing is ever sent to TinyPNG and no image is
compressed. Keep the key out of committed configuration; see the note in
[Installation](../installation/index.md#keep-your-api-key-out-of-version-control).

### Compress on upload

A checkbox. When enabled, **every** image uploaded to the site is compressed as
it's saved. Turn this off if you'd rather compress only selected image styles
(see below) and leave originals untouched.

### Upload method

Only relevant when *Compress on upload* is on. It controls how images reach the
TinyPNG service:

- **Upload** *(default)* — Drupal sends the image bytes directly to TinyPNG.
  This works everywhere, including local development where your site isn't
  reachable from the internet.
- **Download** — Drupal gives TinyPNG a public URL and TinyPNG fetches the image
  itself. This requires your site to be reachable from the internet, so it's for
  production use, not localhost.

### Image action (per-image-style compression)

A checkbox that enables the per-image-style option. When it's on **and** an API
key is set, each image style's edit form gains a **Compress with TinyPNG**
checkbox (see the next section). Leave it on if you want to compress specific
styles' derivatives; you can combine or use it independently of on-upload
compression.

Click **Save configuration** when done.

## Compress a specific image style's derivatives

With *Image action* enabled and an API key set:

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`) and edit a style — for example a large
   hero style or a responsive-image variant.
2. On the style's edit form you'll see a **Compress with TinyPNG** checkbox.
   Tick it and save.

From then on, that style's generated derivatives are routed through TinyPNG when
they're created, so visitors receive the compressed versions while the original
uploaded file is left untouched. This is the most free-tier-friendly approach:
flag only your highest-traffic styles to keep monthly compressions under the
limit.

## The two ways to compress, summarized

1. **On upload** — turn on *Compress on upload*; every uploaded image is
   compressed once, when it's saved.
2. **Per image style** — turn on *Image action*, then tick *Compress with
   TinyPNG* on the styles you choose; only those styles' derivatives are
   compressed, originals stay as-is.

Both require a valid API key. You can use either, both, or neither.

## For developers

The `tinypng.compress` service wraps the Tinify API client and can be used to
compress an image from custom code (it reads the API key from
`tinypng.settings`). See the agent docs at
[`api/services.md`](../../agent/api/services.md) for details.
