# Drush: download the Tiny Slider library

`drush.services.yml` registers `tiny_slider.commands`
(`Drupal\tiny_slider\Commands\TinySliderCommands`).

| Command | Alias | Effect |
|---|---|---|
| `tiny_slider:download` | `ts:dl` | Downloads the Tiny Slider library (v2.9.3 tar.gz from GitHub) into `DRUPAL_ROOT/libraries/tiny-slider`. |

What it does (`downloadTinySlider()`):
1. Ensures `DRUPAL_ROOT/libraries` exists.
2. Downloads `https://github.com/ganlanyuan/tiny-slider/archive/refs/tags/v2.9.3.tar.gz` to a temp
   file (via `file_get_contents` — the server needs outbound HTTP and `allow_url_fopen`).
3. Decompresses/extracts with `PharData`, then renames `tiny-slider-2.9.3/` to
   `libraries/tiny-slider/` (deleting any existing one first), and cleans up temp files.

After running, `/libraries/tiny-slider/dist/tiny-slider.js` exists and the runtime requirement
(`tiny_slider_requirements()`) turns green. You can also install it manually (download the release
zip and extract to `libraries/tiny-slider`).

```bash
drush tiny_slider:download   # or: drush ts:dl
```
