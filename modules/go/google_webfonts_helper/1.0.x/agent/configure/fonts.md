<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managing self-hosted fonts (`google_webfont` config entities)

Each self-hosted font is a `google_webfont` **config entity**. Adding/editing one is the
module's main task; the download + CSS generation happen automatically on save.

## UI / routes (all require `administer google_webfonts_helper`)

| Route id | Path | Purpose |
|---|---|---|
| `entity.google_webfont.collection` | `/admin/config/system/google-webfonts-helper` | List (the `configure` link) |
| `entity.google_webfont.add_form` | `/admin/config/system/google-webfonts-helper/add` | Add font |
| `entity.google_webfont.edit_form` | `/admin/config/system/google-webfonts-helper/{google_webfont}` | Edit |
| `entity.google_webfont.delete_form` | `/admin/config/system/google-webfonts-helper/{google_webfont}/delete` | Delete |

Form class: `Drupal\google_webfonts_helper\Handler\Form\GoogleWebfontForm`.
List builder: `Handler\GoogleWebfontListBuilder` (its `Library` column prints the exact
library id to attach: `google_webfonts_helper/<id>`).

## Entity fields (config_export)

| Field | Form widget | Meaning |
|---|---|---|
| `id` | machine_name (locked after create) | Entity id; also the on-disk subfolder + CSS filename |
| `label` | textfield (required) | Human label |
| `font_id` | select (required, locked after create) | Font key from the service's `/api/fonts` list (e.g. `open-sans`); AJAX-refreshes variants/subsets |
| `family` | (set in `submitForm`) | Human font family, copied from the fetched options |
| `variants` | checkboxes (required) | Weight/style ids to include (e.g. `regular`, `700`, `italic`) |
| `subsets` | checkboxes (required) | Charset subsets (e.g. `latin`, `cyrillic`) |
| `css_target` | radios (required) | `legacy` = eot/woff/woff2/ttf/svg ("Best support"); `modern` = woff/woff2 |
| `css_weight` | select (required) | Library CSS bucket: `base`/`layout`/`component`/`state`/`theme` |
| `font_display` | select (required) | `auto`/`block`/`swap`/`fallback`/`optional` (default `swap`) |

`font_id`, `variants`, and `subsets` options are all fetched live from the
`https://gwfh.mranftl.com` service (via `google_webfonts_helper.rest_api`); if the service is
unreachable the selects come up empty.

## What happens on save (runtime trace)

`GoogleWebfont::postSave()` → `validateFiles($force)` → `FontManager::prepare($id, $force)`
(`force` is TRUE when editing an existing entity, so its files are rebuilt). `prepare()`:

1. `FileSystemManager::prepareDirectory($id)` creates `<fonts_path>/<id>` (default
   `public://google-webfonts-helper/<id>`).
2. On `force`, `deleteRecursive()` wipes that dir first.
3. `FontDownloader::download($font_id, $variants, $subsets)` — GETs
   `https://gwfh.mranftl.com/api/fonts/<font_id>?download=zip&subsets=…&variants=…` into
   `temporary://google-webfonts-helper/<font_id>.zip`, then `extract()` unzips it (core
   ArchiverManager) into `<fonts_path>/<id>` and deletes the zip.
4. `StyleGenerator::generate()` reads the extracted files with `symfony/finder`, fetches font
   metadata (`/api/fonts/<font_id>`) for family/style/weight/local names, renders the
   `google_webfonts_helper_style` theme and writes `<fonts_path>/<id>/<id>.css`.

Then attach the font with library `google_webfonts_helper/<id>` (see
[../theme/library.md](../theme/library.md)).

## Create via PHP (equivalent to the add form)

```php
\Drupal::entityTypeManager()->getStorage('google_webfont')->create([
  'id' => 'body_font',
  'label' => 'Body font',
  'font_id' => 'open-sans',           // must be a valid service font key
  'family' => 'Open Sans',
  'variants' => ['regular', '700'],   // must exist for that font
  'subsets' => ['latin'],
  'css_target' => 'modern',           // 'legacy' | 'modern'
  'css_weight' => 'base',
  'font_display' => 'swap',
])->save();                            // save() triggers download + CSS generation
```

Because it is a config entity, definitions export with `drush cex`, but the **downloaded font
files and CSS are not config** — each environment re-downloads them (on save, or when the
library is (re)built). See [../theme/library.md](../theme/library.md) for the rebuild trigger.
