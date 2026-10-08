# Configuration

The Google provider is configured on one settings form, after some setup in the
Google Cloud console.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → Google**, or navigate
   directly to `/admin/config/regional/google`.

## Step 1 — set up Google Cloud

In the Google Cloud console:

1. Create a **project** (or choose an existing one).
2. Enable the **Cloud Translation API** for that project.
3. Create a **service account** that has translation access, and download its
   **JSON key** file.

## Step 2 — enter the settings in Drupal

On the settings form:

- **Google API Credentials** — upload the service-account **JSON** file you
  downloaded. This field only accepts `.json` files, and the file is stored in
  Drupal's **private filesystem** (`private://`), not a web-accessible
  directory. Keep that private filesystem protected on the server, because it
  holds your credentials.
- **Project ID** — your Google Cloud project id.
- **Location** — the Google Cloud location, for example `global`.

### Optional: glossaries

For each language you can enter a **Glossary** id and toggle **Case sensitive**.
When a glossary is configured, translations for that language honour it (case
sensitivity is controlled by the toggle), so a controlled vocabulary is applied
consistently.

## How translation works at runtime

- When Auto Node Translate translates a field, this provider calls Google's
  Translation service using the uploaded credentials via the official Google
  Cloud PHP SDK.
- Text longer than 20,000 characters is split and translated in chunks.
- Returned text has HTML entities decoded; if a call fails, the original text is
  returned unchanged.

Note that **your field content is sent to Google** for translation. No API key
is exposed in the browser — authentication happens server-side through the SDK
using the uploaded JSON.

## Rotating the credentials

To rotate the service-account key, generate a new JSON key in Google Cloud and
**re-upload** it on this form.

## Select Google as the provider

Finally, in Auto Node Translate's own settings, choose **Google** as the active
translation provider so that translations run through this module.
