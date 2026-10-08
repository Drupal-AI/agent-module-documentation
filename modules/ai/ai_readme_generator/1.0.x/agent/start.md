<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Readme Generator (ai_readme_generator) — agent index

Generates a `README.md` for an installed contrib/custom module by scanning its code and
summarising it with an AI provider (**OpenAI** or **Groq**). Package **Custom**. Version
**1.0.0**. Core `^10 || ^11`. License GPL-2.0-or-later.

No Drupal-module dependencies (info.yml declares none). Requires the Composer package
**`innoraft/ai-readme-generator` `^1.1.0`**, which supplies the actual code scanner and
AI HTTP client (`Innoraft\ReadmeGenerator\Scanner\CodebaseScanner`,
`Innoraft\ReadmeGenerator\AI\AIResponse`). It does **not** depend on `drupal/ai`.

## What it provides

- **Two admin forms & routes** (both `_permission: administer site configuration`) →
  [config/settings.md](config/settings.md)
  - `ai_readme_generator.config_form` at `/admin/config/ai-readme-generator` —
    `Form\AIConfigForm` (provider, API key, model → config `ai_readme_generator.settings`).
  - `ai_readme_generator.generate_readme_form` at
    `/admin/config/ai-readme-generator/generate-readme` — `Form\GenerateReadmeForm`
    (pick a module, generate + write its README.md).
  - Menu links under *Configuration → Development* (`ai_readme_generator.links.menu.yml`).
- **One Drush command** → [api/drush.md](api/drush.md)
  - `readme-generate <module>` — `Commands\ReadmeGeneratorCommands::generate()`.

## Mechanism (from source)

- Both the form and the Drush command resolve the module's directory, run
  `CodebaseScanner::scan()`, pass the config array to `AIResponse::summarizeArray()`, and
  `file_put_contents($module_path . '/README.md', $summary)`.
- Config object `ai_readme_generator.settings` holds `provider`, `api_key`, `model`,
  `base_uri`, `chat_endpoint`. There is **no** `config/schema` in the module.
- The Drupal module contains only the two forms + Drush command; the scan and the
  provider HTTP call happen inside the `innoraft/ai-readme-generator` package.

## Notes

- `composer.json`'s psr-4 maps `Innoraft\ReadmeGenerator\ => src/`, but `src/` actually
  holds `Drupal\ai_readme_generator\*` classes — the real `Innoraft\ReadmeGenerator\*`
  classes come from the Composer package, not this directory.
