# Configure FlexSlider — optionsets, display, library

## The optionset config entity

FlexSlider's central concept is the **optionset**: a `flexslider` config entity
(`config_prefix: optionset`, so config objects are named `flexslider.optionset.{id}`,
`admin_permission: administer flexslider`, `config_export: id, label, options`). It stores
every FlexSlider library setting in an `options` mapping. A `default` optionset ships in
`config/install/flexslider.optionset.default.yml`.

Manage optionsets at these routes (all gated by `administer flexslider`, path prefix
`/admin/config/media/flexslider`):

| Route | Path | Purpose |
|---|---|---|
| `entity.flexslider.collection` | `/` | List optionsets (this is the `configure` route) |
| `entity.flexslider.add_form` | `/add` | Add an optionset |
| `entity.flexslider.edit_form` | `/{flexslider}` | Edit |
| `entity.flexslider.delete_form` | `/{flexslider}/delete` | Delete |
| `entity.flexslider.enable` / `.disable` | `/{flexslider}/enable` \| `/disable` | Toggle status |
| `flexslider.form_settings` | `/advanced` | Module-wide advanced settings form |

Optionsets export/deploy with `drush config:export`. Create one in code with
`\Drupal\flexslider\Entity\Flexslider::create(['id' => 'hero', 'label' => 'Hero'])->save()`
— `create()` merges your `options` over `FlexsliderDefaults::defaultOptions()`.

### Key options (schema: `config/schema/flexslider.schema.yml`; defaults from `default` optionset)

| Option | Default | Meaning |
|---|---|---|
| `animation` | `fade` | `fade` or `slide` |
| `animationSpeed` | `600` | Animation duration (ms) |
| `direction` | `horizontal` | `horizontal` or `vertical` sliding |
| `slideshow` | `true` | Auto-advance slides |
| `slideshowSpeed` | `7000` | Delay between slides (ms) |
| `animationLoop` | `true` | Loop the slideshow |
| `randomize` | `false` | Randomize slide order |
| `startAt` | `0` | Starting slide index |
| `itemWidth` / `itemMargin` | `0` / `0` | Set both non-zero to make a **carousel** |
| `minItems` / `maxItems` | `0` / `0` | Carousel item range (responsive) |
| `directionNav` | `true` | Prev/next arrows |
| `controlNav` | `'1'` | Paging dots; `thumbnails` for thumbnail nav |
| `keyboard` / `touch` / `mousewheel` | `true`/`true`/`false` | Input navigation |
| `pausePlay` / `pauseOnHover` | `false` / `false` | Pause controls |
| `namespace` | `flex-` | CSS class prefix (advanced; enables per-optionset CSS) |
| `useCSS` / `video` | `true` / `false` | CSS transitions / video-friendly mode |

`getOptions(TRUE)` returns strictly-typed options for the JS library (casting `controlNav`
to boolean unless it equals `thumbnails`).

## Apply as an image field formatter (submodule: flexslider_fields)

Enable `flexslider_fields`, then on an entity's **Manage display** set a **multi-value image
field**'s format to **FlexSlider**. Formatter id `flexslider` extends core `ImageFormatter`;
`isApplicable()` requires a multi-value image field. Its settings form adds an **optionset**
selector, an image style, and caption settings (the core image-link setting is hidden). A
**Responsive FlexSlider** formatter is also available when core **Responsive Image** is
enabled. Do not put the FlexSlider formatter on a field you also render through the Views
FlexSlider style (nesting sliders).

## Apply as a Views style (submodule: flexslider_views)

Enable `flexslider_views`, then in a view set **Format → FlexSlider** (style plugin id
`flexslider`, depends on core `views`). Its options are:
- **Option set** — populated from `flexslider_optionset_list()`.
- **Caption Field** — a view field to render as each slide's caption (required for thumbnail
  captions; or add the `.flex-caption` class to a field manually).
- **Element ID** — manual container ID (keep unique per page).

Include an image field in the display, but **do not** set that field's own formatter to
FlexSlider.

## The FlexSlider JavaScript library requirement

The JS library is an **external dependency**, not bundled. Place it at
`[DRUPAL ROOT]/libraries/flexslider` (required files `jquery.flexslider-min.js`,
`flexslider.css`; `jquery.flexslider.js` for debug). Suggested via Composer as
`woothemes/flexslider:~2.0`. The module declares two libraries in
`flexslider.libraries.yml`:
- `flexslider/flexslider` — the vendor JS/CSS at `/libraries/flexslider/...`.
- `flexslider/integration` — the module glue (`dist/js/flexslider.load.min.js` +
  `assets/css/flexslider_img.css`), depending on `flexslider/flexslider` plus
  `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`.

`hook_library_info_alter` (in `flexslider.module`) resolves the library path (via
`library.libraries_directory_file_finder`), swaps in the unminified JS when debug is on, and
removes CSS if disabled. Attach a slider manually with `flexslider_add($id, $optionset)`,
which returns an `#attached` array (adds `flexslider/integration` and drupalSettings).

### Module-wide settings (`flexslider.settings`, form route `flexslider.form_settings`)

Config object `flexslider.settings` (edit at `/admin/config/media/flexslider/advanced` or via
`drush cset flexslider.settings <key>`):

| Key | Default | Meaning |
|---|---|---|
| `flexslider_version` | `'2.0'` | Declared library version |
| `flexslider_debug` | `false` | Load unminified library JS |
| `flexslider_css` | `true` | Load the vendor library CSS |
| `flexslider_module_css` | `true` | Load the module's fix-up CSS (`flexslider_img.css`) |
