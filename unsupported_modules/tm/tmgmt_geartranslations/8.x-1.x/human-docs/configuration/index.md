# Configuration

GearTranslations Translator has no standalone settings page. You configure it the
way you configure any TMGMT provider: by creating a **translation provider** and
entering your GearTranslations credentials.

## Add the GearTranslations provider

1. Log in as a user who can administer TMGMT.
2. Go to **Configuration → Regional and language → Translation providers**
   (`/admin/tmgmt/translators`).
3. Add a new provider (or edit an existing one) and choose **GearTranslations**
   as the translator plugin.
4. Enter the **API access token** you received from GearTranslations. This token
   is the credential that lets Drupal talk to the GearTranslations platform.
5. Save the provider.

You can then create a TMGMT job (**TMGMT → Jobs**), pick this provider, choose
your translation level, and submit content for translation. Completed
translations come back into the job for review and approval.

## Handle the access token as a secret

The GearTranslations access token authorises translation on your account — treat
it like a password. Store it in an environment variable and reference it rather
than pasting it into configuration that gets exported and committed to version
control.

## Security points to weigh before going live

Two behaviours in the module as shipped deserve your attention:

- **The callback is not authenticated.** GearTranslations returns translated text
  by posting to `/tmgmt_geartranslations_callback`, and the module imports that
  posted text into the matching active job **without checking that the request
  really came from GearTranslations**. In principle, anyone who can reach that URL
  and guess an active job ID could push arbitrary "translated" content into your
  site — a content‑injection and potential stored‑XSS risk.
- **TLS verification is disabled** on the module's outbound API calls, which means
  the access token is sent over a connection that is not certificate‑verified and
  could be intercepted by a man‑in‑the‑middle.

There is no in‑UI toggle for either of these; they are properties of the code as
shipped. If your content or site is sensitive, consider whether you can restrict
access to the callback path, and factor these caveats into your decision to run
the module on a public‑facing site. The project is not covered by Drupal's
security advisory policy and is currently seeking a new maintainer.
