# Configure a theme's colors

No dedicated admin page — the picker is injected into each **compatible** theme's settings form
(**Admin → Appearance → Settings → *theme***). If a theme has no color picker it is not
color-compatible (see [../theming/compatible-theme.md](../theming/compatible-theme.md)) or GD is
missing. Requires *Administer site configuration* + PHP GD with PNG.

Form section (`color_scheme_form` in `color.module`) offers:
- **Color set** — a predefined scheme from the theme, or *Custom*.
- **Palette** — one hex textfield per element (base, text, link, …); farbtastic picker + live preview.

Values are validated as `#rgb`/`#rrggbb` only (XSS/CSRF guard). On submit the module:
1. Writes recolored copies of the theme's stylesheets to `public://color/<theme>-<hash>/`.
2. If the theme ships a base image, GD-renders recolored images + logo there.
3. Saves everything to config `color.theme.<theme>`; selecting the exact default palette **deletes**
   that config (falls back to the theme's own CSS).

`hook_library_info_alter()` then swaps the theme's declared stylesheets for the recolored files at
render time; `ColorConfigCacheInvalidator` invalidates the `library_info` cache tag on every
save/delete so changes show immediately. The recolored logo is applied to the system branding
block via a `#pre_render` callback.

## Config object `color.theme.<theme>`

Schema `config/schema/color.schema.yml` (`provides_config_schema: true`):

| Key | Type | Meaning |
|---|---|---|
| `palette` | sequence<color_hex> | chosen hex value per element key |
| `logo` | path | generated recolored logo (svg/png) |
| `stylesheets` | sequence<path> | generated recolored CSS files |
| `files` | sequence<path> | all generated files (cleaned up on re-save) |

Read/write with core config commands, e.g. `drush config:get color.theme.olivero`. Note the
`palette` values are used to *write CSS to disk*, so config overrides are pointless — edit via the
form and re-save to regenerate files. GD/PNG availability is surfaced by `hook_requirements()`
(`color_gd`) on the status report.
