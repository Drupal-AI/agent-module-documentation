# The text filter

## Enable it

1. Go to *Configuration → Text formats and editors*
   (`/admin/config/content/formats/manage/<format>`, e.g. `full_html`).
2. Check **"Convert Legacy Media Tags to Markup"** and save.
3. Content in that format now has its media tokens rendered as images on output.

There is no settings form for the filter — it has no `#settings`.

## What it does (`App::filterText` / `App::tokenToMarkup`)

- Matches tokens with `/\[\[\{.*?"type":"media".+?\}\]\]/s`.
- For each: strips `[[`/`]]`, `Json::decode()`s the blob, requires a `fid`, then
  `File::load($fid)` (throws → logged, token replaced with `''`).
- Builds the src via `file_url_generator` (`generateAbsoluteString()` →
  `transformRelative()`).
- Emits:

```html
<div class="media media-element-container media-default">
  <div id="file-<fid>" class="file file-image">
    <div class="content">
      <img style="<style>" alt="<alt>" title="<alt>" class="<class>" src="<url>" <height> <width>>
    </div>
  </div>
</div>
```

- Plugin type `TYPE_TRANSFORM_IRREVERSIBLE`: it rewrites on the way out and is not reversible,
  so order it appropriately relative to other filters. On a top-level exception the whole
  filter returns the original text unchanged (`watchdogThrowable` logs it).
