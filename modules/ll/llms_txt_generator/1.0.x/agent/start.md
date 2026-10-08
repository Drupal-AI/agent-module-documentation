<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LLMs.txt Generator (llms_txt_generator) — agent index

Serves a **hand-authored** `llms.txt` file at `/llms.txt`. No dependencies. Core `^9 || ^10 || ^11`.
**Release is 1.0.0-alpha1 — alpha.**
Settings at `/admin/config/search/llms-txt-generator`, permission
**`administer llms txt generator`** (`restrict access: true`).

Despite the name, it does **not** generate content from the site. An admin types the file
contents into one textarea; the module writes that text verbatim to `public://llms.txt` and serves
it. "Generation" = writing config text to a file + filling `{site_name}`/`{site_url}`/`{date}` in a
static default template on install. There is no node/content enumeration anywhere.

## What you'd do → where

- **Edit the file, the settings keys, the enable toggle, the default template, the reset button** →
  [configure/settings.md](configure/settings.md)
- **The `/llms.txt` route + controller, the file-generator service, cron self-heal** →
  [api/service.md](api/service.md)
- **Who can edit / why `/llms.txt` is public** → [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Routes: `llms_txt_generator.settings` (`_form`, `/admin/config/search/llms-txt-generator`, perm
  `administer llms txt generator`); `llms_txt_generator.content`
  (`LlmsTextGeneratorController::content`, `/llms.txt`, **`_access: 'TRUE'`** — public by design,
  like robots.txt).
- Config object: `llms_txt_generator.settings`, keys `enable_file` (bool, default TRUE) and
  `llms_txt_content` (text; default `''`, seeded on install from the template).
- Service: `llms_txt_generator.file_generator` = `Drupal\llms_txt_generator\Service\LlmsFileGenerator`
  (interface `LlmsFileGeneratorInterface`). Methods: `generateLlmsFile($suppress_empty_warning=FALSE)`,
  `getLlmsFileContent()`, `getDefaultTemplateContent()`. File URI constant
  `LlmsFileGenerator::LLMS_TXT_URI = 'public://llms.txt'` (fixed).
- Hooks: `hook_install` seeds config + writes the file; `hook_uninstall` deletes the file + config;
  `hook_cron` rewrites `public://llms.txt` only if it is missing and `enable_file` is TRUE.
- Default template: `templates/default-template.md` (static; placeholders `{site_name}`,
  `{site_url}`, `{date}`). Menu link under `system.admin_config_search`, weight 10.
- No dependencies, no Drush, no plugin types. Provides config schema
  (`config/schema/llms_txt_generator.schema.yml`) and one permission.
