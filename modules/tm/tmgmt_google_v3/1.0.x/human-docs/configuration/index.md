# Configuration

Google V3 Translator has **no settings page of its own**. You configure it by
creating a TMGMT **Translator** (translation provider) that uses the **Google V3**
plugin. This page walks through that, including the Google credentials and the
private‑files requirement.

## Before you start

Make sure you have:

- The **private file system** configured (`$settings['file_private_path']` in
  `settings.php`). The credentials key is uploaded to `private://`, so this must be
  in place first.
- A **Google Cloud project** with the Cloud Translation API enabled, and its
  **service‑account JSON key** file downloaded (see
  https://cloud.google.com/translate/docs/setup).
- At least two languages configured on your site.

## Create the translation provider

1. Go to **Configuration → Regional and language → Translation providers**
   (`/admin/tmgmt/translators`) and click **Add translator**.
2. Set **Translator plugin** to **Google V3**. The plugin's own settings then
   appear:

   - **Location** — the Google API location. The default `global` is right for most
     sites; use a regional location only if your Google setup requires it.
   - **Project ID** — your Google Cloud project id. Internally this is used as
     `projects/<id>/locations/<location>`.
   - **Google API Credentials** — upload your service‑account **JSON key** file.
     The upload only accepts `.json` files, and the file is stored in the private
     filesystem and marked permanent when you save.
   - **Glossary mappings** *(optional)* — one field per site language, where you can
     enter a Google **glossary id** to use for that target language. Leave these
     empty if you're not using glossaries.

3. Click **Connect** to test. This asks Google for its list of supported languages;
   a "Successfully connected!" message means your project id and credentials are
   working.
4. Give the provider a **label** and **Save**.

The provider is only considered fully configured once **Location**, **Project ID**,
and **Credentials** are all set — until then TMGMT shows it as not configured.

## A note on the credentials secret

The service‑account JSON key is a sensitive credential. This module stores it as an
uploaded managed file in the **private** filesystem (`private://`), which keeps it
out of the public web root — that's why private files must be enabled before you
configure the provider. Treat the key file like any other secret: restrict who can
download it, and rotate it in your Google Cloud console if it is ever exposed.

## Using the provider

Once saved, the Google V3 provider is available whenever you create a TMGMT job:
choose it as the translator when you send content for translation, and TMGMT routes
the job to Google Cloud Translation v3. Because the plugin also supports TMGMT's
**continuous** translation, you can set up jobs that translate new or changed
content automatically. Very long fields (over 20,000 characters) are chunked into
multiple requests automatically, and where you've mapped a glossary for a target
language, it is applied to that language's translations.

Developers can post‑process Google's output — for example fixing entities or
markup — by subscribing to the module's `PostTranslationEvent`; see the sibling
[`agent/`](../../agent/start.md) docs for that.
