<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image-style usage inspector service

Service **`seeds_development.inspector`** → `Drupal\seeds_development\SeedsDevelopmentInspector`
(`src/SeedsDevelopmentInspector.php`), implementing `SeedsDevelopmentInspectorInterface`. Injected
with `@entity_type.manager`, `@config.factory`, `@module_handler`.

## `imageStyleUseability(ImageStyleInterface $image_style): array`

Returns an associative array of "sections", each `['id', 'title', 'content']` where `content` is a
list of `['label', 'id', 'url']`. The controller renders each section as a fieldset of links. A
completely **empty** return means the style is considered unused (this is what
`inspectAllImageStyle()` keys "unused" on). Sections checked:

1. **Responsive images** (only if `module_handler->moduleExists('responsive_image')`): loads all
   `responsive_image_style` entities and keeps those whose `getImageStyleMappings()` contain a
   mapping with `image_mapping == $image_style->id()`, or whose `getFallbackImageStyle()` equals the
   id. Each match links to its `edit-form`. Note: this section is always added (even when empty) if
   responsive_image is on, so a style used only here vs. nowhere still differs from a truly empty
   result.
2. **View displays**: loads all `entity_view_display` entities, skips disabled ones, and for each
   `image`-type component whose `settings['image_style']` equals the id, records a link to the
   bundle's default or per-view-mode display edit route.
3. **Found in Config**: `configUsability($image_style->id())` — greps the **config sync directory**
   for the style id.

## `configUsability($search)` (private)

Resolves `DRUPAL_ROOT` + `Settings::get('config_sync_directory')` and runs a **`shell_exec()`**
`grep` over the exported `*.yml` files for the style id, excluding the style's own
`image.style.<id>.yml`. Each hit becomes a section entry (label = filename, `url = new Url('<none>')`).
Because it reads the on-disk sync directory rather than active config, results can differ from the
running site — the unused-styles page states this explicitly. `$search` is the image-style entity id
(a machine name).

## Notes

- The `inspectAllImageStyle()` table only lists ids whose usability result is empty; it does not
  show where used styles are used (use the per-style `inspectImageStyle` route for that).
- `configUsability()` has a latent PHP notice (`end(explode(...))` passes a non-variable by
  reference) — functional, not a behavior change.
