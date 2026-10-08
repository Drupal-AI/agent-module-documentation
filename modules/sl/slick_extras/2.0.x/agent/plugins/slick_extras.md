# slick_extras — extra skins (SlickSkin plugin)

Slick Extras' only substantive runtime contribution is a `SlickSkin` plugin that adds extra
skins to the parent **slick** module. It does not define a new plugin type — it *implements*
Slick's `SlickSkin` plugin type (see the slick docs `plugins/skins.md`). Enable the module,
clear cache, and the skins show up in the **Skin** dropdown of any Slick optionset / field
formatter.

## The plugin

`src/Plugin/slick/SlickExtrasSkin.php`, class `Drupal\slick_extras\Plugin\slick\SlickExtrasSkin`,
extends `Drupal\slick\SlickSkinPluginBase`:

```php
/**
 * @SlickSkin(
 *   id = "slick_extras_skin",
 *   label = @Translation("Slick extras skin")
 * )
 */
class SlickExtrasSkin extends SlickSkinPluginBase {
  protected function setSkins() { /* returns keyed skin definitions */ }
}
```

## Skins it registers

Each entry sets `name`, `group` (`main` or `thumbnail`), `provider` (`slick_extras`), a
`description`, and one or more CSS files under `slick_extras/css/theme/`:

| id | name | group | CSS | Notes |
|---|---|---|---|---|
| `d3-back` | X 3d back | main | `slick.theme--d3-back.css` | 3D view, focal slide at back; best with 3 slidesToShow, caption below. |
| `boxed` | X Boxed | main | `slick.theme--boxed.css` | Side margins on slick-list, revealing arrows. |
| `boxed-carousel` | X Box carousel | main | `slick.theme--boxed.css` + `slick.theme--boxed--carousel.css` | Margins; alternative to centerMode. |
| `boxed-split` | X Box split | main | `slick.theme--boxed.css` + slick's `slick.theme--split.css` | Margins plus split caption/image. |
| `rounded` | X Rounded | main | `slick.theme--rounded.css` | Rounds `.slide__image`; good for 3–5 visible slides. |
| `vtabs` | X VTabs | thumbnail | `slick.theme--vtabs.css` | Vertical-tabs-style thumbnail navigation. |

## Add your own skin (same pattern)

1. Create `your_module/src/Plugin/slick/YourSkin.php` extending `SlickSkinPluginBase` with a
   unique `@SlickSkin(id = ..., label = ...)`.
2. Override `setSkins()` returning `['my-skin' => ['name' => 'My skin', 'group' => 'main',
   'provider' => 'your_module', 'description' => $this->t('...'), 'css' => ['theme' =>
   [$path . '/css/theme/slick.theme--my-skin.css' => []]]]]`. Use `$this->getPath('module',
   'your_module')` for the path.
3. Ship the referenced CSS file, then clear cache — the skin appears in the optionset **Skin**
   dropdown. `group` controls where it's offered: `main` for the primary carousel, `thumbnail`
   for the nav/thumbnail slider.

## Non-runtime / learning parts (not for production)

- **slick_example** (sub-module, depends on `slick_views`): sample optionsets prefixed `X`
  (`x_main`, `x_carousel`, `x_grid`, `x_overlay`, `x_slick_nav`, `x_slick_for`, `x_split`,
  `x_vtabs`, `x_fullscreen`), Slick image styles, the `slick_x` View, an asNavFor JS demo, and
  its own `SlickExampleSkin`. Clone what you need; see `slick_example.module` for alter-hook
  examples.
- **slick_devel** (sub-module): a `slick_devel.settings` form and a debug JS loader for Slick
  library development.
- `slick_extras.module` exposes only `slick_extras_get_path()`, a deprecated path helper.

The maintainers explicitly say this project is example/scaffolding: clone it, make it yours, and
uninstall it in production (safe to leave enabled if you forget).
