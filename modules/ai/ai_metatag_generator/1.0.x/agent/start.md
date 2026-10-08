<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Metatag Generator (ai_metatag_generator) — agent index

Adds a **"Generate Metatags with AI"** button to a node's Metatag field widget that fills
**description / abstract / keywords** from the node content via the **Drupal AI** module.
Package *SEO*. Core `^8 || ^9 || ^10 || ^11`. Depends on **`ai`** (drupal/ai) and **`metatag`**.
License GPL-2.0-or-later. Version 1.0.0-alpha3.

- **Settings form, config keys, prompts & per-language messages** →
  [config/settings.md](config/settings.md)
- **The generator service + AJAX callback (content → AI → form fields)** →
  [api/service.md](api/service.md)

## What it provides

- **No routes of its own besides the settings form; no entities, no plugins.** One
  `hook_field_widget_single_element_form_alter()` adds the button; one service
  `Services\AiMetatagService` (id `ai_metatag_generator.ai_service`); one static AJAX callback
  `AiMetatagUtility::generateMetatags()`.
- **Permissions** (`*.permissions.yml`): `administer ai metatag generator` (`restrict access:
  true`) and `use ai metatag generator`.
- Settings form route `ai_metatag_generator.settings` → `/admin/config/ai/ai-metatag-generator`,
  permission `administer ai metatag generator`. Menu link under *AI* (`ai.admin_settings`).
- Config object `ai_metatag_generator.settings` (schema in `config/schema/`): `content_types`,
  `metatag_field`, `provider_model`, `strip_html`, `display_mode`, `black_list`, `prompts`
  (per-language), `success_messages`, `error_messages`.

## Mechanism (from source)

- `ai_metatag_generator_field_widget_single_element_form_alter()`: on the widget for the
  configured `metatag_field`, if the entity is an existing node of an enabled content type and the
  user has `use ai metatag generator`, adds a `#type => 'button'` with an `#ajax` callback to
  `AiMetatagUtility::generateMetatags`.
- `AiMetatagUtility::generateMetatags()` (AJAX): loads the node from the form, calls
  `AiMetatagService::generateMetatags($node)`, and pushes returned values into the metatag basic
  fields via `InvokeCommand('...[basic][description|keywords|abstract]', 'val', [...])`, then opens
  a success/error `OpenDialogCommand`.
- `AiMetatagService::generateMetatags()`: renders the node (`display_mode`, default `full`) in
  isolation, prepends the title, optionally `strip_tags()` + removes blacklisted words, calls the
  AI chat provider with the per-language prompt as system prompt (appending a required JSON output
  shape), and `parseAiResponse()` JSON-decodes and validates `description`/`abstract`/`keywords`.

## Integration notes

- Uses the **drupal/ai** provider abstraction (`provider_model` or default `chat` provider). No
  external API key or TLS handling lives here.
- Values are only ever placed into form fields client-side for review — the node is saved by the
  editor as usual (the button does not persist anything directly).
- Note: the config default `metatag_field` is `field_meta_tag`, but the programmatic
  `AiMetatagService::updateNodeMetatags()` hard-codes `field_meta_tags` — set your field name in
  config to match your Metatag field.
