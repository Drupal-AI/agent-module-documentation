<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migration — prompt system (`ai_migration_prompt` plugin type)

Lets each migration override the built-in extraction prompts. Two layers: default prompt text (enum) + pluggable prompt-source plugins, combined by a per-migration operation.

## Plugin type
- Manager `plugin.manager.ai_migration_prompt` → `PluginManager/PromptPluginManager.php` (extends `DefaultPluginManager`; discovery dir `Plugin/ai_migration/prompt`, interface `AiPromptInterface`, attribute `#[AiPrompt]`, alter hook `ai_migration_prompt_info`). Helpers: `findPlugIdByType()`, `findDefaultPluginId()`, `getPluginByType()`, `getDefaultPlugin()`.
- Attribute `#[AiPrompt(id, label, weight, type, is_default)]` — `src/Attribute/AiPrompt.php`. Note the id must follow the `ai_migration_prompt:string` pattern.
- Interface `AiPromptInterface::getPrompt(array $configuration): string` — `Plugin/ai_migration/prompt/AiPromptInterface.php`.
- Default plugin `PromptString` (id `ai_migration_prompt:string`, `type: string`, `is_default: TRUE`) — returns `trim($configuration['prompt'])`. Add your own plugin type (e.g. file-based) by implementing the interface with a new `type`.

## Service `ai_migration.prompt_manager` — `AiMigrationPromptManager`
- Constant `MIGRATION_ROOT_KEY = 'prompt'`, `DEFAULT_OPERATION = 'replace'`.
- `setConfig(array)` — called by the data parser with the migration's `ai.prompt` block.
- `getPrompt(string $role, array $migration_config = [])`:
  - validates `$role` against `PromptRole` (user/system); invalid → `InvalidArgumentException`.
  - finds the config entry whose `role` matches; none → returns the built-in default `PromptDefault::from($role)->getPromptText()`.
  - else resolves the prompt-source plugin by `type` (default plugin if none), gets its text, and applies the `operation` (`PromptOperation`: prepend/append/replace, default replace; `operation_eol` toggles the newline) to combine it with the default prompt.

## Default prompts — `src/Enum/PromptDefault.php`
- **system**: a "Web Content Extractor" instruction set — strict well-formed JSON, `null` for missing fields, `data` arrays for relationships (with `type`/`name`, and `uri`/`alt` for media/images), always include `attributes` objects, and a `[ai:migration:schema]` token that `AiMigrator` replaces with the generated schema.
- **user**: HTML/URL-conversion rules (make URLs absolute, timestamps in seconds) plus the `[ai:migration:content]` token replaced with the page HTML.

## Enums & trait
`src/Enum/PromptRole.php` (user/system), `PromptOperation.php` (prepend/append/replace + `modify()`), `PromptDefault.php`; `src/Trait/EnumValidMethodsTrait.php` supplies `isValid()`/`getValidItems()` for validation.

## YAML example
```yaml
ai:
  prompt:
    - role: system
      operation: append
      prompt: "Return ONLY minified JSON, no markdown fences."
```
Omit `prompt:` entirely to use both defaults unchanged. `role` is required on each entry; `type` defaults to `string`, `operation` to `replace`.
