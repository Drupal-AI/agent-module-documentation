<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AIDmi settings, config object & permission

## Install & enable

```bash
composer require drupal/aidmi
drush en aidmi -y
```

Dependencies (from `aidmi.info.yml`): **`ai`** and **`key`**. You must have a working AI provider
configured in the AI module with a **vision / `chat_with_image_vision`**-capable model before AIDmi
can produce anything. AIDmi itself declares no PHP or composer requirements (no `composer.json`
ships; `package.json` is only the CKEditor build toolchain).

## Settings form

Route **`aidmi.settings`** → `/admin/config/services/aidmi`, permission
**`administer site configuration`**. Form class `Drupal\aidmi\Form\AidmiSettingsForm`
(extends `ConfigFormBase`, form id `aidmi_settings_form`). The menu link
(`aidmi.links.menu.yml`) parents it under the AI module admin menu (`ai.admin_settings`), so it
appears in the AI settings area even though the path is under *Web services*.

Fields (`buildForm()`):

| Field | Config key | Type | Default | Notes |
|---|---|---|---|---|
| AI Prompt Instructions | `api_instructions` | textarea (required) | *"Describe this image for 508 alt-text."* (form fallback); install default is a longer 508 guidance string | Base instructions embedded in every prompt. |
| Drupal AI Provider & Model | `ai_model` | select | `''` (→ *Use Default System Vision Model*) | Options from `providerManager->getSimpleProviderModelOptions('chat', TRUE, TRUE, [AiModelCapability::ChatWithImageVision])`. Empty = use the AI module's default `chat_with_image_vision` provider/model. |
| Send surrounding text to AI | `send_context` | checkbox | `TRUE` | If on, body text is sent alongside the image for context. |
| Generate Image Captions | `enable_captions` | checkbox | `TRUE` | If on, the model is also asked for a long visible caption. |

`submitForm()` writes all four keys into config object **`aidmi.settings`** (booleans cast with
`(bool)`).

### Test Connection (AJAX)

The **Test Connection** submit button (`testConnectionSubmit` + `testConnectionAjaxCallback`)
does a cheap live handshake: it resolves the selected provider (or the default
`chat_with_image_vision` provider if none chosen), sends a one-line `ChatInput`
("Respond with only the single word: Connected"), and renders the provider's reply — or the caught
exception message — as a `status_messages` block in the `aidmi-test-result-container` wrapper. It
uses `#limit_validation_errors => [['ai_model']]` so only the model select is validated. Note the
error path prints the exception into a `<pre>` via a `t()` placeholder (escaped).

## Config object & schema

`config/install/aidmi.settings.yml` install defaults:

```yaml
ai_model: ''
api_instructions: 'When writing accessibility alt text, aim to provide concise descriptions ...'
send_context: true
enable_captions: true
```

Schema `aidmi.schema.yml` (`aidmi.settings`, type `config_object`): `ai_model` (string),
`api_instructions` (string), `send_context` (boolean), `enable_captions` (boolean).

These three consumers read the config: `AidmiAiService::getEngine()` (`ai_model`),
`AidmiAiService::analyzeImage()` / `analyzeContent()` (`api_instructions`, `send_context`,
`enable_captions`), and the settings form.

## Permission

`aidmi.permissions.yml` defines a single permission **`generate aidmi accessibility`** ("Generate
AIDmi Accessibility"), required by both AJAX generation routes. Grant it to editor roles that
should be able to trigger AI generation. The settings form is separately gated by core
`administer site configuration`.

## Enable the editor button

After install, add the button to a text format:

1. *Configuration → Content authoring → Text formats and editors* (`/admin/config/content/formats`).
2. **Configure** a CKEditor 5 format (e.g. Full HTML / Basic HTML).
3. Drag the **"AI, describe my image!"** button into the active toolbar.
4. Save. See [../ckeditor/plugin.md](../ckeditor/plugin.md) for how the button behaves.
