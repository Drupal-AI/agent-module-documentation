<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI color-palette & font generators

Two services turn a natural-language prompt into validated DXPR Theme settings by calling the
optional **`drupal/ai`** module's chat provider.

## Services

```yaml
# dxpr_theme_helper.services.yml
dxpr_theme_helper.ai_palette_generator:
  class: Drupal\dxpr_theme_helper\AiPaletteGenerator
  arguments: ['@?ai.provider', '@?ai.prompt_json_decode', '@extension.list.theme']
dxpr_theme_helper.ai_font_generator:
  class: Drupal\dxpr_theme_helper\AiFontGenerator
  arguments: ['@?ai.provider', '@?ai.prompt_json_decode', '@extension.list.theme']
```

The `@?` prefixes make the `ai.provider` and `ai.prompt_json_decode` dependencies **optional** —
the services exist even when `drupal/ai` is not installed, but generation then returns an error.

## `AiThemeGeneratorBase` (shared logic)

Both generators extend `AiThemeGeneratorBase`:

- `isAvailable()` — TRUE only if the `ai.provider` service was injected (i.e. `drupal/ai` present).
- `hasConfiguredProvider()` — TRUE if a chat provider is configured for the `chat` operation.
- `generate(string $prompt): array` — the entry point. It returns `['error' => …]` when:
  the AI module is missing, the prompt is empty, no chat provider/default model is configured,
  the response can't be parsed, required keys are missing, or a value fails validation.
  On success it returns `[<responseKey> => <data>]` (`colors` or `fonts`).
- Uses the AI module's `ChatInput`/`ChatMessage`, tags the request (`dxpr-palette` /
  `dxpr-theme`), and decodes JSON via `ai.prompt_json_decode` with a manual regex fallback.

## `AiPaletteGenerator`

- Response key `colors`; required keys are loaded dynamically from DXPR Theme's
  `features/sooper-colors/color-settings.json` (so it needs DXPR Theme present to know the fields).
- Validates each value is a 6-digit hex color (`/^#[0-9A-Fa-f]{6}$/`).
- System prompt instructs the model to return only JSON of `{field: #hex}` with WCAG-AA contrast
  between text/background pairs.

## `AiFontGenerator`

- Response key `fonts`; analogous flow for font selections (extends the same base).

## Invoking

Via Drush (see [../drush/dxt-commands.md](../drush/dxt-commands.md)):

```bash
drush dxt:generate:palette "Modern tech startup" --apply
drush dxt:generate:fonts "Clean editorial" --dry-run
```

Or via the HTTP POST routes used by the theme-settings UI:
`dxpr_theme_helper.generate_palette` (`/admin/dxpr-theme/generate-palette`) and
`dxpr_theme_helper.generate_fonts` (`/admin/dxpr-theme/generate-fonts`), both requiring the
`administer themes` permission and delegating to the two services.

## Requirements

- `drupal/ai` (^1) installed and configured with a chat provider/default model.
- DXPR Theme installed (palette fields come from its `color-settings.json`).
Without `drupal/ai`, `generate()` returns an error and the commands report the AI module is not
installed.
