# Configuration

You configure Microsoft Translator by creating a TMGMT **translator (provider)**
entity and giving it your Azure API key. There is no separate module settings page —
the "configure" link goes to the TMGMT providers list.

## Create the provider

1. Go to **Translation → Providers** (`/admin/tmgmt/translators`) and add a
   translator.
2. Choose the plugin **Microsoft**.
3. Enter the **Microsoft Azure API Key** — your Azure Cognitive Services Translator
   subscription key. This field is required.
4. Click **Connect** to validate the key. If the key is wrong you'll see
   *"The 'Azure API Key' is not valid."*
5. Optionally enable TMGMT's **auto accept** option so returned translations are
   accepted automatically rather than waiting for review.
6. Save. The provider is now selectable when creating TMGMT jobs.

## Settings reference

The provider stores two settings (in `tmgmt.translator.settings.microsoft`):

| Setting | Meaning |
|---------|---------|
| **Microsoft Azure API Key** (`api_key`) | Your Azure Translator subscription key. Required. |
| **Auto accept** (`auto_accept`) | TMGMT's standard option to auto-accept returned translations. |

The Azure endpoints (the token URL and the translate URL) are built into the plugin
and are **not** shown in the form — you only ever supply the key.

## Keep the API key out of version control

The key is stored in the translator entity's configuration. Like any Drupal config
value, if you export configuration to code it would otherwise be committed in
plaintext. To avoid that, override it per environment rather than persisting the real
key in exported config.

The recommended approach on this project is to keep the value in an environment
variable and reference it, never hard-coding or committing the secret:

1. Store the key as an environment variable with DDEV's dotenv helper (this writes to
   `.ddev/.env`, which must stay out of version control):

   ```bash
   ddev dotenv set .ddev/.env --azure-translator-key=<your-key>
   ddev restart
   ```

   The flag `--azure-translator-key` becomes the variable `AZURE_TRANSLATOR_KEY` in
   the web container.

2. Reference that variable for the translator's key from `settings.php`, so the real
   value lives only in the environment:

   ```php
   $config['tmgmt.translator.<translator_id>']['settings']['api_key'] = getenv('AZURE_TRANSLATOR_KEY');
   ```

   Replace `<translator_id>` with the machine name of the provider you created.

This keeps exported configuration free of the secret while the running site still
picks up the key.

## How translation works (for reference)

When a TMGMT job runs against this provider, the plugin exchanges your subscription
key for a short-lived token, then posts each translatable segment to the Azure
Translator v3 `/translate` endpoint using Drupal's HTTP client. Content is sent as
**HTML** so markup is preserved, and text wrapped in `notranslate` spans is left
untouched. Drupal language codes are mapped to Azure's equivalents (for example
Simplified/Traditional Chinese), and any single segment longer than 50,000 characters
is rejected to respect Azure's per-request limit. The list of supported target
languages is fetched live from Azure.

There are no module-specific permissions and no Drush commands — administering the
provider uses TMGMT's own screens and permissions.
