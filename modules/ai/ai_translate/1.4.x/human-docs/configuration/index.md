# Configuration

AI Translate works as soon as it is enabled and the AI module has a provider —
the settings form is where you tune the prompt, the per-language behaviour, and
what happens to new translations.

## Open the settings form

1. Log in as a user with the **Manage AI translation prompts** permission.
2. Go to **Configuration → AI → AI Translate**, or navigate directly to
   `/admin/config/ai/ai-translate`.

## The settings, field by field

- **Use AI Translate** (`use_ai_translate`, default **on**) — when on, AI
  Translate takes over the core **Translate** tab and adds the "AI translate"
  links. Turn it off to keep the standard core translation UI and use this module
  only as a back-end framework (for other tooling such as AI TMGMT). Changing
  this rebuilds routes.
- **Cache translation results** (`cache_translations`) — reuse a previous
  translation when the same text is translated between the same two languages
  again, cutting cost and repeat provider calls. Stored results record the AI
  provider and model that produced them, so switching model translates afresh and
  switching back reuses what was stored; editing a translation prompt discards the
  results that used it. New installs have this **on**; sites updating from an
  earlier version keep it **off** until you tick it here.
- **Default prompt** (`prompt`) — which translation prompt to use by default.
  Prompts are stored as AI-module prompt entities; the module ships a sensible
  default. The prompt is a template with placeholders for source/target language
  and the input text, and must render to at least 50 characters.
- **Translation status** (`translation_status`, default *keep original*) —
  whether a new translation keeps the source entity's published status
  (*keep_original*) or is created as an unpublished **draft** for an editor to
  review before publishing (*create_draft*).
- **Redirect after create** (`redirect_after_create`, default *list*) — after
  generating a translation, send the user to the translation **overview**
  (*list*) or straight into the **edit form** of the new translation (*edit*) for
  quick correction.
- **Reference defaults** (`reference_defaults`) — which entity types' referenced
  entities (paragraphs, referenced nodes) are translated automatically along with
  the host entity.
- **Entity reference depth** (`entity_reference_depth`, default **1**) — how many
  levels deep reference translation recurses. Options are `1`, `2`, `5`, `10`, or
  unlimited.
- **Per-language settings** (`language_settings`) — for each target language you
  can override the **model** (a specific AI provider/model) and the **prompt**.
  This lets you, say, use a stronger model and a more formal prompt for Japanese
  while using a cheaper model for Spanish.

Click **Save configuration** to store your choices.

## Prompts

The translation prompt lives as an AI-module prompt entity of type
`ai_translate`, with variables for the source and target language (code and
name) and the input text. Edit the default prompt, or create additional prompts,
to control tone and formality, then select them as the default or per-language
prompt above.

## Where the model and API key actually come from

AI Translate never stores an API key or endpoint. It calls the AI module's
default provider for the `translate_text` operation, so to switch LLM vendor
globally you change the provider in the **AI** module — nothing changes here. A
per-language **model** override on this form only re-selects among the models the
AI module exposes. If you have not set up a dedicated translation provider, the
bundled **Chat proxy to LLM** provider lets any configured chat model act as the
translator.

## Permissions

Three permissions gate the module (grant them to trusted roles):

| Permission | What it allows |
|---|---|
| **Create ai content translation** | Trigger AI translation of a content entity (creates and saves the target-language translation). |
| **Create ai interface translation** | Use the "AI translate" button on the interface (locale) translation screen. |
| **Manage ai translation prompts** | Access this settings form and manage prompts. |

When someone triggers a content translation, AI Translate also checks that they
have permission to **update that specific entity** before creating the
translation, so the feature follows your existing content edit permissions.

## Bulk translation from the command line

Two Drush commands do the same work as the UI (they run with CLI-level trust):

```bash
# Translate one or more entities (comma-separated IDs) from English to French:
drush ai:translate-entity node 16,18,20 en fr

# Translate a raw string (text, then source, then target language):
drush ai:translate-text "Hello world" en fr
```

Entities that already have the target translation are skipped.
