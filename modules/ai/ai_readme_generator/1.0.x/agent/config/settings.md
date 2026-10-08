<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & the Generate form

## Install & enable

```bash
composer require drupal/ai_readme_generator   # pulls innoraft/ai-readme-generator
drush en ai_readme_generator -y
```

No other Drupal modules are required. Admin Toolbar is a convenience for reaching the
config pages.

## AI configuration form

Route `ai_readme_generator.config_form` → `/admin/config/ai-readme-generator`, class
`Form\AIConfigForm` (a `ConfigFormBase` editing `ai_readme_generator.settings`).
Permission: **`administer site configuration`**.

Fields:

| Field | Notes |
|---|---|
| **AI Provider** | Select: `openai` or `groq` (AJAX-refreshes the model list). |
| **API Key** | Text field. |
| **Model** | Depends on provider — OpenAI: `gpt-3.5-turbo`, `gpt-4`; Groq: `llama3-8b-8192`. |

On submit, `AIConfigForm::submitForm()` also derives and stores `base_uri` and
`chat_endpoint` from a hard-coded provider map:

- openai → `https://api.openai.com/v1/` + `chat/completions`
- groq → `https://api.groq.com/` + `openai/v1/chat/completions`

All five values (`provider`, `api_key`, `model`, `base_uri`, `chat_endpoint`) are saved
into the `ai_readme_generator.settings` config object. The module ships **no config
schema** for this object.

## Generate README form

Route `ai_readme_generator.generate_readme_form` →
`/admin/config/ai-readme-generator/generate-readme`, class `Form\GenerateReadmeForm`
(a plain `FormBase`). Permission: **`administer site configuration`**.

- The **Select a module** dropdown is built by
  `getTopLevelCustomAndContribModules()`: it scans modules via `ExtensionDiscovery`,
  skips `core/modules`, and skips nested modules under `modules/custom|contrib` deeper
  than the top level; option keys are module machine names.
- `submitForm()` re-scans with `ExtensionDiscovery`, verifies the chosen machine name
  exists (`isset($all_modules[$module_name])`, else an error), computes
  `$module_path = DRUPAL_ROOT . '/' . $extension->getPath()`, runs
  `CodebaseScanner($module_path)->scan()`, calls
  `AIResponse($config)->summarizeArray($moduleData)`, then
  `file_put_contents($module_path . '/README.md', $summary)` and reports the path.

## Config object reference

```yaml
# ai_readme_generator.settings
provider: openai
api_key: '…'
model: gpt-4
base_uri: 'https://api.openai.com/v1/'
chat_endpoint: 'chat/completions'
```

## Operating notes

- The generated README is written **into the target module's own directory**, overwriting
  any existing `README.md` there. Review the AI output before committing it.
- The provider HTTP call and the code scan are performed by the
  `innoraft/ai-readme-generator` Composer package (`AIResponse`, `CodebaseScanner`), not
  by classes in this module.
