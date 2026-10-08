# Configuration

There are two admin forms, both under **Configuration → Regional and language**
and both gated by the **Administer site configuration** permission.

## 1. API key and glossary

Go to **DeepL settings** (`/admin/config/regional/deepl`):

- **API key** (`apikey`) — your DeepL API key (free or pro). Required. This is the
  credential the module uses to authenticate every translation request.
- **Glossary** (`glossary_id`) — an optional DeepL glossary id. Set it to enforce
  consistent terminology across translations, or leave it empty to translate
  without a glossary.

Click **Save configuration**.

### Handling the API key as a secret

The API key is stored in the `auto_node_translate_deepl.settings` configuration
object (this module ships no config schema, so the value is stored untyped). That
means the key **travels with a configuration export**. Treat it as a secret:

- Keep any config export that contains it out of public version control.
- Prefer a restricted DeepL API key scoped to just this site's needs.

If you prefer to set the key from the command line rather than the UI:

```bash
ddev drush config:set auto_node_translate_deepl.settings apikey <YOUR_KEY>
```

(Drop the `ddev` prefix if you're already inside the container.)

## 2. Language mapping

Go to **DeepL language mapping** (`/admin/config/regional/deepl/mapping`).

For every language configured on your Drupal site, this form shows a **source**
and a **target** select. The options come from DeepL's *live* list of supported
source and target languages — so the form only opens if your API key is valid.
Use it to:

- Pin a Drupal language to a specific DeepL variant — e.g. map Drupal `pt` to
  DeepL `PT-PT` or `PT-BR`.
- Set the source and target codes separately, which matters for DeepL's asymmetric
  language codes.

The values are stored per language as `source_<langcode>` and `target_<langcode>`
in the `auto_node_translate_deepl.language_mapping` config object.

**If a language has no explicit mapping**, the module passes the raw Drupal
language code straight to DeepL. That's often fine for common languages, so you
only need this form for the variant/asymmetric cases.

## How translation actually runs

This module only provides the DeepL backend. When an editor uses Auto Node
Translate's translate button, this plugin sends the field text to DeepL with HTML
tag handling and formatting preservation turned on (so markup survives), applies
your glossary if one is set, and returns the translated text. The parent **Auto
Node Translate** module owns the UI, the permissions, and the decision of which
nodes and fields get translated and when. If a translation call fails, the module
shows the error and leaves the original text untouched rather than wiping it.
