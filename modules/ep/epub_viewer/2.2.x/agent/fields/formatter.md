<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Epub Formatter (`epub_field_formatter`)

`src/Plugin/Field/FieldFormatter/EpubFieldFormatter.php` — `@FieldFormatter(id = "epub_field_formatter", label = "Epub Formatter", field_types = { "file" })`, extends core `FileFormatterBase`.

## What it does

- `viewElements(FieldItemListInterface $items, $langcode)` iterates `getEntitiesToView($items, $langcode)` (so core file display flag / access is honored when building the list).
- Per file: if `$file->getMimeType() == 'application/epub+zip'` it builds
  `$path = $base_url . '/view-ebook/' . $file->id()` and returns a render element
  `['#theme' => 'epub_formatter', '#path' => $path]`.
- Otherwise it returns `['#theme' => 'file_link', '#file' => $file]` (the standard core file link).
- `$base_url` is the PHP global; `$file->id()` is the file entity id used as `{fid}` in the viewer route.

## Template

`templates/epub-formatter.html.twig` renders the `epub_formatter` theme hook (var `path`, registered in `epub_module_theme()`):

```
<a target="_blank" href="{{ path }}">Read Ebook on Reader</a>
```

So the on-page output for an EPUB item is just an anchor opening `/view-ebook/{fid}` in a new tab.

## Enable / use

1. Enable the module: `drush en epub_module -y`.
2. Add a **file** field to a fieldable entity (any bundle) or reuse one.
3. On *Manage display*, set that field's format to **Epub Formatter**.
4. Upload `.epub` files (MIME `application/epub+zip`); other file types keep the normal file link.

## Notes

- No formatter settings (`defaultSettings()`/`settingsForm()` not overridden). Appearance is global, from the settings form (see `config/settings.md`).
- Targets core file fields only; not media/link/image fields.
- The MIME check is exact-string; a file mis-detected as `application/zip` (or `octet-stream`) will not get the reader link and will fall through to `file_link`.
