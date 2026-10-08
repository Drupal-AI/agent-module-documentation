<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Metatag AI

Form `MetatagAISettingsForm` at `/admin/config/content/metatag-ai`
(route `metatag_ai.content_settings`, permission `administer metatag content`). All values are saved
to the config object **`metatag_ai.content_settings`** (note: keys are nested under a `metatag_ai.`
prefix inside that object). No `config/schema` ships, so these are plain config values.

## Config keys (in `metatag_ai.content_settings`)

| Key | Type | Meaning |
|---|---|---|
| `metatag_ai.metadata_content_types` | array | Node type ids where the "Generate Metatag" button appears. |
| `metatag_ai.metadata_field_id` | string | Machine name of the Metatag field to populate (default `field_metatag`). |
| `metatag_ai.provider_model` | string | AI provider/model "simple option" (e.g. `openai__gpt-4o`). Empty = use AI module default chat provider. |
| `metatag_ai.system_prompts` | array | Per-langcode assembled prompt + its component parts (see below). |
| `metatag_ai.system_messages` | array | Per-langcode banner message shown at the top of the settings form. |

## Per-language system prompt

For every enabled interface language the form exposes a fieldset with: a **System Message** (form
banner text), **Title / Description / Abstract** instruction textfields (prefixed "title with " etc.),
a **Keywords** fieldset (`number` 1–50 + optional extra instruction), and free-form **Additional
instructions**. On submit these are assembled into `system_prompts[<langcode>]`:

```
prompt:      the full assembled prompt string sent to the AI
title:       "title with <…>"
description: "description with <…>"
abstract:    "abstract with <…>"
keywords:    { number: <int>, instruction: <string> }
additional:  <string>
```

The assembled prompt always ends with "Suggest content for SEO ranking." and "Reply in JSON format of
the title, description, abstract and keywords." The generator validates a prompt actually mentions
title/description/abstract/keyword + "max"/"maximum" before using it, else it errors.

At runtime the generator picks the prompt for the node's langcode, falling back to the default
language, then to a hardcoded built-in prompt (title ≤60, description ≤160, abstract ≤160, ≤10
keywords, reply JSON).

## Set it up with Drush

```bash
# Select content types + field, and (optionally) a provider/model.
ddev drush cset metatag_ai.content_settings metatag_ai.metadata_content_types.0 article -y
ddev drush cset metatag_ai.content_settings metatag_ai.metadata_field_id field_metatag -y
ddev drush cset metatag_ai.content_settings metatag_ai.provider_model 'openai__gpt-4o' -y
```

The Metatag field must already exist on the selected content type(s), and an AI chat provider must be
configured at `/admin/config/ai` for the button to render.
