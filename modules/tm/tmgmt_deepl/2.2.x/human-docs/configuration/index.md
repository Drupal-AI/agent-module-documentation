# Configuration

DeepL is configured as one of TMGMT's translation providers. There is no separate
settings page — you create a provider and set the DeepL options on it.

## Add a DeepL provider

1. Go to **Translation → Providers** (`/admin/tmgmt/translators`) and add a
   translator/provider.
2. Choose the plugin **DeepL API Free** (for low‑volume sites — DeepL's free tier
   allows 500k characters/month) or **DeepL API Pro** (for higher‑volume or
   production use).
3. Enter your DeepL **authentication key**.
4. Adjust the DeepL options (below) and **Save**. The form validates the key
   against DeepL, so this step needs network access and a valid key.

## DeepL options

These map onto DeepL's own API parameters and are stored on the provider:

- **Formality** (`formality`) — how formal the translation should be: default,
  more formal, less formal, or a "prefer" variant. Only some target languages
  support formality.
- **Split sentences** (`split_sentences`) — how DeepL splits text into sentences:
  none, interpunction and newlines (the default), or interpunction without
  newlines.
- **Tag handling** (`tag_handling`) — off, or treat the content as **XML** or
  **HTML** so markup is preserved during translation.
- **Preserve formatting** (`preserve_formatting`) — keep the source formatting
  rather than letting DeepL normalize it.
- **Outline detection** (`outline_detection`) — DeepL's automatic outline
  detection for structured documents.
- **Splitting / non‑splitting / ignore tags** (`splitting_tags`,
  `non_splitting_tags`, `ignore_tags`) — comma‑separated XML tag lists that
  control where sentences may split and which tags are left untranslated.
- **Auto accept** (`auto_accept`) — automatically accept the translations DeepL
  returns, so jobs complete without a manual review step.
- **API endpoints** (`url`, `url_usage`) — the DeepL translate and usage
  endpoints. The defaults differ for free versus pro; adjust them if you need a
  specific region.

## Store the DeepL key securely

Don't commit the key to version control. Put it in an environment variable:

```bash
ddev dotenv set .ddev/.env --deepl-auth-key=<value>   # then: ddev restart
```

Then set the provider's auth key from `getenv('DEEPL_AUTH_KEY')` during
deployment (or use a Key entity where supported). Saving the provider config does
not call DeepL — only translating a job (or the form's key test) does.

## Translate content

With the provider saved, create a TMGMT translation job for the content you want,
choose your DeepL provider at checkout, and submit. Short jobs translate
immediately; long jobs can be processed in the background by DeepL's cron queue
worker (run on cron, or manually with `drush queue:run deepl_translate_worker`).
If you enabled the glossary submodule, you can attach a DeepL glossary to enforce
specific term translations.
