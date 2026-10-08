# Configuration

Auto Translation has one settings form where you pick a provider, enter
credentials, and decide which content gets the Translate control.

## Open the settings form

1. Log in as a user with the **Administer auto_translation module** permission
   (this permission is security‑restricted).
2. Go to **Configuration → System → Auto Translation**, or navigate directly to
   `/admin/config/system/auto-translation`.

## Choose a provider

The **Translation provider** setting selects the engine (default is Google):

- **Google (free)** — the client‑side Google Translate endpoint. No API key
  required; good for getting started, subject to the free endpoint's limits.
- **Google (server)** — the paid Google Cloud Translate API. Turn on the
  server‑side API option and supply an API key for higher quality and limits.
- **DeepL** — Free or Pro. Requires an API key; toggle the **DeepL Pro mode** option
  to switch between the Free and Pro hosts.
- **LibreTranslate** — requires an API key.
- **Amazon Translate** — requires an access key, a secret key, and a region
  (default `us-east-1`).
- **Drupal AI** — LLM‑based translation via the AI Translate module; needs the AI
  and AI Translate modules with a provider configured for translation.

## Enter credentials

Depending on the provider, fill in the relevant fields:

- **API key** (and, where needed, **API secret**) — for Google server, DeepL, and
  LibreTranslate.
- **Amazon access key / secret key / region** — for Amazon Translate.

Validation enforces the right combination: an API key is required when the Google
server API is enabled or when the provider is DeepL or LibreTranslate, and Amazon
requires both keys. All credentials are escaped and stored **encrypted** in the
module's configuration — they are not kept in plain text.

> **Tip — keeping secrets out of config exports.** Because these credentials are
> stored as configuration, you can also override them per environment from
> `settings.php` (for example reading an API key from an environment variable with
> `getenv()`), which keeps the real secret out of your exported configuration and
> version control.

## Choose what gets translated

- **Content types** — tick the content types that should show the Translate control
  on their add/edit forms.
- **Excluded fields** — list field names that should never be translated (product
  codes, SKUs, and similar). One per line.
- **Bulk output state** — whether the bulk actions **publish** the new
  translations or save them as **drafts** for review (default: draft).
- **Enable debug** — verbose logging to the `auto_translation` log channel, useful
  when diagnosing provider issues.

Save the form.

## Grant the translate permission

The second, security‑restricted permission — **Auto translation translate
content** — controls who may actually run translations (via the button or the bulk
actions). Grant it on **People → Permissions** to the appropriate roles.

## Bulk translation

To translate many entities at once, expose the module's two actions —
**Auto Translate and Publish** and **Auto Translate** (save as draft) — as bulk
operations on a content View or the admin content listing. Editors then select
rows and run the action, which translates each item into its missing languages.
