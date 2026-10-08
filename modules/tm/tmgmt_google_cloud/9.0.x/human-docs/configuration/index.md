# Configuration

You configure this module by adding a TMGMT **translation provider** that uses the
Google Cloud plugin and entering your Google Cloud credentials.

## Add the Google Cloud provider

1. Log in as a user who can administer TMGMT.
2. Go to **Configuration → Regional and language → Translation providers**
   (`/admin/tmgmt/translators`).
3. Add a new provider (or edit an existing one) and choose **Google Cloud** as the
   translator plugin.
4. Enter your **Google Cloud credentials / API key** — the credential that lets
   Drupal call the Google Cloud Translation service on your account.
5. Save the provider.

## Translate content

With the provider saved, go to **TMGMT → Jobs** (`/admin/tmgmt/jobs`), pick the
content you want translated, choose the Google Cloud provider, and submit. Because
this module can handle larger text (up to roughly 200 KB per request), it copes
well with long content items. Translations return through TMGMT for you to review
and accept.

## Handle credentials as secrets, and mind the data egress

Your Google Cloud credentials authorise translation — and billing — on your Google
account, so treat them as secrets: store them in an environment variable (or a Key
entity) rather than in configuration that is exported and committed, and make sure
requests go over HTTPS. Remember, too, that the content you translate is **sent to
Google Cloud**; confirm that sending this particular content to an external
service is acceptable before you rely on the module in production.
