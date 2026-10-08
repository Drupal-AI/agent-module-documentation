# Christmas Snow settings

Route `christmas_snow.settings` → `/admin/config/christmas_snow/cs_settings` (form
`Form\ChristmasSnowSettingsForm`, a `ConfigFormBase`). Permission: core `administer site configuration`
(the module ships **no** `*.permissions.yml`). Parent menu route `christmas_snow.admin`
(`/admin/config/christmas_snow`) uses the same permission. All values persist in `christmas_snow.settings`.

There is **no `config/install` file and no config schema** — keys exist only after the form is first
saved; until then the form falls back to the inline defaults below.

| Config key | Field | Type / options | Default | Passed to JS as |
|---|---|---|---|---|
| `christmas_snow` | Enable snow | checkbox | (off) | — (gate; nothing attaches when off) |
| `christmas_snow_flakes_max` | Maximum snow flakes | select 16/32/64/128/512 | 128 | `flakesMaxActive` |
| `christmas_snow_snowcolor` | Snow color | textfield hex, maxlength 7 (Farbtastic picker) | `#FFFFFF` | `snowcolor` |
| `christmas_snow_flake_bottom` | Flakes on the bottom | select 500/750/1000 | 500 | `flakeBottom` |
| `christmas_snow_follow_mouse` | Flakes follow mouse | select `true`/`false` | `true` | `followMouse` |
| `christmas_snow_melt` | Flakes melt away | select `true`/`false` | `true` | `useMeltEffect` |
| `christmas_snow_stick` | Flakes stick | select (`false`=Yes/`true`=No) | `false` | `snowStick` |
| `christmas_snow_twinkle` | Flakes twinkle | select `false`/`true` | `false` | `useTwinkleEffect` |
| `christmas_snow_character` | Flake character | select `•`/`·` | `•` | `snowCharacter` |
| `christmas_snow_animation_int` | Performance | select 20/33/50 (ms/frame) | `33` | `animationInterval` |
| `christmas_snow_minified` | Use minified libraries | checkbox | (off) | picks `snowstorm-min` vs `snowstorm` |

## How it renders
`Hook\ChristmasSnowHooks::pageAttachments()`:
1. Skips admin routes (`router.admin_context`->isAdminRoute).
2. If `christmas_snow` is on, attaches `christmas_snow/snow` plus `christmas_snow/snowstorm`
   (or `snowstorm-min` when `christmas_snow_minified`), and sets `drupalSettings.christmas_snow.*`.
3. Always adds cache tag `config:christmas_snow.settings`.

## Libraries (`christmas_snow.libraries.yml`)
- `snow` — the module's glue JS (`js/snow.js`), depends on jQuery + core/drupal.
- `colorpicker` — `js/colorpicker.js`, used on the settings form with `core/jquery.farbtastic`.
- `snowstorm` / `snowstorm-min` — **external** Snowstorm 1.44 from `cdn.rawgit.com` (a defunct CDN).
  Override with `hook_library_info_alter` or a `libraries` override to a working/self-hosted copy so the
  effect actually loads.

## Set without the UI
```bash
drush config:set christmas_snow.settings christmas_snow 1 -y
drush config:set christmas_snow.settings christmas_snow_snowcolor '#FFFFFF' -y
```
