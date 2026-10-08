# PDF Preview field formatter

Plugin id **`pdfpreview`** — `Drupal\pdfpreview\Plugin\Field\FieldFormatter\PDFPreviewFormatter`,
which **extends core `Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter`**. It applies to
`field_types = {file}` (regular file fields, not image fields).

## Enable it

Manage Display for the entity/bundle → set a **file** field's format to *PDF Preview*. Configure with
the gear icon. Because it extends the core image formatter, it also inherits the image formatter's
settings: **Image style** (`image_style`) and **Link image to** (`image_link`: nothing / content / file).

## Per-display settings

| Setting | Type | Default source | Effect |
|---------|------|----------------|--------|
| `show_description` | checkbox | `pdfpreview.settings:show_description` | Render the file description beside the preview. |
| `tag` | radios (`span`/`div`) | `pdfpreview.settings:tag` | Wrapper element emitted by the `pdfpreview_formatter` theme wrapper. |
| `fallback_formatter` | checkbox | `pdfpreview.settings:fallback_formatter` | Intended to format non-PDF files with a default file formatter. |
| `image_style` | select | (inherited) | Image style applied to the generated preview image. |
| `image_link` | select | (inherited) | Link the preview to the content or to the file. |

`defaultSettings()` seeds `show_description`, `tag`, and `fallback_formatter` from the
`pdfpreview.settings` config object, then merges the parent image-formatter defaults.

## Render behavior (`viewElements()`)

For each referenced file:

- If `\Drupal\file\Entity\File::getMimeType()` is `application/pdf`, it calls
  `pdfpreview.generator::getPDFPreview($file)` to obtain (or lazily create) the preview image URI,
  loads it through `image.factory`, and — if valid — renders it via the core `image_formatter` theme
  using the chosen `image_style` and `image_link`.
- Otherwise (non-PDF, or preview generation failed / image invalid), it renders the file with the
  core `file_link` theme.
- Every element is wrapped by the `pdfpreview_formatter` theme wrapper and carries `#settings`
  (the formatter settings) and `#fid` (the file id).

Cache tags from the file (and the image style, when set) are attached; a `url.site` cache context is
added when `image_link` is `file`.

## Theme

Theme hook **`pdfpreview_formatter`** (template `templates/pdfpreview-formatter.html.twig`,
registered in `pdfpreview_theme()`). `template_preprocess_pdfpreview_formatter()` exposes `tag`, `fid`,
and `description` (only when `show_description` is on). Output:

```html
<div class="pdfpreview" id="pdfpreview-<fid>">
  <span|div class="pdfpreview-image-wrapper"> {{ element }} </span|div>
  {{ description }}
</div>
```
