<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the llms.txt content

Single settings form, single config object. There are no plugins, content types, or field
settings — the entire "configuration" is one textarea plus an enable toggle.

## The form

- Route `llms_txt_generator.settings` at **`/admin/config/search/llms-txt-generator`**
  (Configuration → Search and metadata → LLMs.txt Generator), permission
  **`administer llms txt generator`**. Form class
  `Drupal\llms_txt_generator\Form\LlmsTextGeneratorSettingsForm` (extends `ConfigFormBase`).
- **LLMs.txt Content** (`llms_txt_content`) — a **required** 25-row textarea. Whatever you type is
  written verbatim to the served file. Its default value is the current config, or the bundled
  template if config is empty. Validation only blocks all-whitespace content and, if the text is >5
  lines with **no** `key: value` "directive" lines, adds a non-blocking warning
  (`LlmsTextGeneratorSettingsForm.php:145-177`).
- **Reset to default content** — a client-side button; its `onclick` runs
  `document.getElementById("edit-llms-txt-content").value = <json-encoded template>` and returns
  false, so it only repopulates the textarea in the browser (nothing is saved until you submit).
- **Enable llms.txt file** (`enable_file`, default TRUE) — when unchecked, `/llms.txt` returns 404
  and `generateLlmsFile()` refuses to write.
- A collapsed **Section Examples** details element shows copy-paste snippets (site info, access
  guidelines, URL section, human-visitor block). It is reference text only.

On submit, config is saved and `fileGenerator->generateLlmsFile()` rewrites `public://llms.txt`; a
success or error message is shown depending on the write result.

## Config object `llms_txt_generator.settings`

```yaml
enable_file: true          # boolean — serve the file / allow generation
llms_txt_content: ''       # text — the exact file body (seeded on install)
```

Schema: `config/schema/llms_txt_generator.schema.yml` (`config_object`; `enable_file` boolean,
`llms_txt_content` text). Set it without the UI:

```bash
drush cset llms_txt_generator.settings enable_file 1 -y
drush cset llms_txt_generator.settings llms_txt_content "$(cat my-llms.txt)" -y
drush php:eval "\Drupal::service('llms_txt_generator.file_generator')->generateLlmsFile();"
```

(Changing config alone does not rewrite the physical file — call the service, resubmit the form, or
wait for cron to notice a *missing* file. See [../api/service.md](../api/service.md).)

## The default template

`hook_install` seeds `llms_txt_content` (only if empty) from
`getDefaultTemplateContent()`, which reads the static file `templates/default-template.md` and
substitutes three placeholders — `{site_name}` (from `system.site` name), `{site_url}` (the current
request's scheme+host), and `{date}` (`M d Y`). The template is boilerplate prose (Site Type,
Access Guidelines, a hand-written "Main Documentation" URL list pointing at `/about`, `/contact`,
`/docs`, and a "For Human Visitors" block). **These URLs are examples, not discovered pages** —
edit them to match your site.
