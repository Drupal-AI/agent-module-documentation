# Configuration

Configuring Google Translator means creating a TMGMT **translation provider** that
uses the Google plugin and giving it an API key. There is no separate settings page of
its own — the settings live on the provider entity.

## Create a Google translation provider

1. Go to **Configuration → Regional and language → Translation providers**
   (`/admin/tmgmt/translators`).
2. Click **Add translator** (or edit an existing provider).
3. Set a **label** and choose **Google** as the translator **plugin**.
4. Fill in the settings below and **Save**.

## Settings

- **Google API key** *(required)* — your Google Cloud Translation API key. The
  provider is only reported as "available" once this is set. When you save, the module
  validates the key by asking Google for its list of supported languages; if the key is
  wrong you'll see the error *"The 'Google API key' is not correct."* so you know
  immediately.
- **Auto accept** — when enabled, translations returned by Google are automatically
  accepted for the job, skipping the manual review step. Leave it off if you want a
  human to review and post-edit the machine translation first.

(There is also a hidden endpoint-override setting used only by the module's automated
tests — leave it alone in production.)

Once the key is valid, TMGMT can list Google's supported languages, so the
language-mapping options for the provider become available — map your Drupal language
codes to Google's where they differ.

## Translate content

With the provider in place, use TMGMT as usual: pick content to translate, create a
job, and choose your **Google** provider to submit it. Google translates the strings
(batching them behind the scenes) and returns them to the job — automatically accepted
if you enabled **Auto accept**, otherwise waiting for your review. You can also set the
provider up as a continuous translator so new content is translated automatically, and
run several providers side by side (Google, DeepL, human teams) and choose per job.

## Setting it from the command line

The provider is stored as a config entity named `tmgmt.translator.<name>`:

```bash
drush cget tmgmt.translator.google
```
