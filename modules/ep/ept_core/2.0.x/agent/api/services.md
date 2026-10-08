<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services and hooks

## Services (`ept_core.services.yml`)

| Service id | Class | Purpose |
|---|---|---|
| `ept_core.generate_css` | `Services\GenerateCSS` | `generateFromSettings($settings, $paragraph_class)` → build scoped CSS from a paragraph's EPT design options + `ept_core.settings` |
| `ept_core.generate_js` | `Services\GenerateJS` | `generateFromSettings($settings)` → build per-paragraph JS (parallax, video/YouTube background, etc.) |
| `Drupal\ept_core\Hook\EptCoreHooks` | `Hook\EptCoreHooks` | autowired OOP hook implementations (see below) |

Both generators take the decoded `field_ept_settings` value of a paragraph and are invoked from
the render pipeline; a `paragraph_class` (a per-paragraph CSS scope class) keys the CSS so
settings only affect that paragraph.

## Hooks (`src/Hook/EptCoreHooks.php`, attribute-based)

Implemented with `#[Hook(...)]` on `EptCoreHooks`:

- `#[Hook('help')]`
- `#[Hook('theme')]` — registers `ept-settings-default` etc.
- `#[Hook('theme_registry_alter')]`
- `#[Hook('theme_suggestions_paragraph_alter')]` — adds EPT paragraph template suggestions
- `#[Hook('preprocess_paragraph')]` — injects the generated CSS/JS + design variables
- `#[Hook('paragraph_view')]`
- `#[Hook('entity_view_alter')]`

So to change how EPT design options are applied, decorate/replace the generator services or
override the paragraph templates the suggestions point at — you rarely re-implement these hooks.

## Constants

`Drupal\ept_core\Constants\EptConstants`: `COLOR_BLUE = '#0d77b5'`, `COLOR_WHITE = '#fff'`,
`COLOR_BLACK = '#000'` — used as colour fallbacks.

## Bundled front-end libraries

`ept_core.libraries.yml` wraps the Composer-installed JS libs used by EPT paragraphs:
colorpicker (`levmyshkin/jquery-colorpicker`), YouTube player (`jquery-mb-ytplayer`),
parallax (`parallaxjs`), and video background (`vidbg`).

No Drush commands here — the `ept_core_starterkit` submodule adds the `ept:module` generator.
