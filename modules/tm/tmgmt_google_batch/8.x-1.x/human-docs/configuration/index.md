# Configuration

You configure this module by adding a TMGMT **translation provider** that uses the
Google batch plugin and entering your Google API key.

## Add the Google provider

1. Log in as a user who can administer TMGMT.
2. Go to **Configuration → Regional and language → Translation providers**
   (`/admin/tmgmt/translators`).
3. Add a new provider (or edit an existing one) and choose the **Google** batch
   translator as the plugin.
4. Fill in the provider settings:
   - **API key** — the key from your Google Cloud project that has the Cloud
     Translation API enabled. This is the credential the module passes to Google
     with every translation request. The module **validates the key when you
     save**, so an invalid key is caught immediately rather than at translation
     time.
   - **Endpoint URL** — the Google translation endpoint. A sensible default is
     provided; you only need to change it if you are pointing at a different or
     proxied Google translation URL.
5. Save the provider.

## Translate content

With the provider saved, go to **TMGMT → Jobs** (`/admin/tmgmt/jobs`), select the
content you want translated, choose this Google provider, and submit. Because it
uses Google's batch API, it comfortably handles large jobs. Results are fetched
back through TMGMT automatically for you to review and accept.

## Keep the API key safe

The API key authorises translation (and therefore billing) on your Google Cloud
account, so treat it as a secret. Prefer storing it in an environment variable and
keeping it out of any configuration that is exported and committed to version
control. Requests to Google go out over Drupal's standard HTTP client with normal
TLS verification. Bear in mind that the content you translate is sent to Google —
make sure that data egress is acceptable for the material you are translating.
