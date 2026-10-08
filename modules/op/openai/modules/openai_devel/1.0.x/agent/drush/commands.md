# Drush commands

Service `openai_devel.commands` = `\Drupal\openai_devel\Commands\OpenAIDevelCommands`
(constructor arg `@plugin.manager.develgenerate`), registered in `openai_devel/drush.services.yml`.
The command is a thin wrapper that drives the `content_gpt` DevelGenerate plugin (see
[../plugins/content_gpt.md](../plugins/content_gpt.md)).

| Command | Alias | pluginId | Purpose |
|---------|-------|----------|---------|
| `devel-generate:content-gpt` | `gencgpt` | `content_gpt` | Generate `num` nodes whose title + string/text fields are written by OpenAI GPT. |

Signature: `content($num = 15, array $options = […])`. The `@hook validate` (`validate()`) resolves
the `content_gpt` plugin and runs its `validateDrushParams()`; `generate()` then calls the plugin's
`generate()`.

## Options

| Option | Default | Notes |
|--------|---------|-------|
| `--kill` | `FALSE` | Delete existing content first. |
| `--bundles` | `page,article` | Comma-delimited content types. |
| `--authors` | — | Comma-delimited user ids (defaults to all users). |
| `--feedback` | `1` | Insertion-rate logging interval. |
| `--skip-fields` | — | Fields to omit. |
| `--base-fields` | — | **Required.** Comma-delimited base/text field names to fill with GPT. |
| `--languages` | — | Comma-separated langcodes. |
| `--translations` | — | Comma-separated langcodes for translations. |
| `--add-type-label` | `FALSE` | Prefix the content-type label to the title. |
| `--model` | `gpt-3.5-turbo` | GPT model. |
| `--system` | — | **Required.** System profile that steers responses. |
| `--temperature` | `0.4` | 0–2. |
| `--max_tokens` | `512` | For non-gpt-4 models must be ≤ 4096. |
| `--html` | `FALSE` | Ask GPT for basic HTML in long-text fields. |

`validateDrushParams()` throws if `--system` or `--base-fields` is empty, if `temperature` is
outside 0–2, if `max_tokens` < 0, or if a non-gpt-4 model is asked for > 4096 tokens. Generation is
always batched (`isBatch()` returns TRUE).

Example:

    drush gencgpt 5 --bundles=article --base-fields=body \
      --system="Generate short articles about Drupal." --model=gpt-3.5-turbo --html
