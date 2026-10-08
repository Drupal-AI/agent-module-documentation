# Configuration

Preload Font's job is simple, but doing it well is a matter of preloading the
*right* fonts and no more. All of that happens on one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Preload Font**, or navigate directly
   to `/admin/config/user-interface/preload-font`.

## Add the fonts to preload

On the form, list the font files you want the browser to fetch early — typically
the specific `.woff2` files your theme uses for above-the-fold text. Point each
entry at the font file's path so the module can emit a matching
`<link rel="preload" as="font">` tag in the `<head>`.

## Getting the details right

The whole benefit of preloading depends on three things:

- **Preload only what appears above the fold.** Add the one or two weights and
  subsets that render immediately (for example your body and heading weights) — not
  an entire font family. Preloading everything front-loads bandwidth ahead of the
  CSS and images that decide when the page becomes usable, which slows the page
  down rather than speeding it up.
- **`crossorigin` is required, even for same-origin fonts.** Font requests are made
  in CORS mode, so a preload without `crossorigin` causes the browser to fetch the
  file **twice** — once for the preload it cannot reuse, once for the real request.
  This is the most common way a font preload backfires; the module emits the
  attribute for you, but it is why the correct font path and format matter.
- **Match the preloaded file exactly to what the CSS requests.** The preload only
  helps if it is the same URL, format, and crossorigin mode the `@font-face` rule
  will ask for; a mismatch means a wasted download.

## `font-display` is a separate setting

Preloading makes the font *arrive* sooner. It does not decide what the visitor sees
while they wait — that is `font-display` (for example `swap`), which lives in your
theme's `@font-face` CSS, not in this module. The two are complementary: use both
for the smoothest result.

## Save

Click **Save configuration**, then clear caches (`drush cr`) if the preload tags do
not appear immediately, and confirm in the page source that each font is preloaded
once with `crossorigin`.
