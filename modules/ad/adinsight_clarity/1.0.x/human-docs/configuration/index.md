# Configuration

AdInsight / Clarity is configured by entering your Microsoft Clarity project key on
the module's settings form. The module adds a permission that gates access to that
form, so only users you trust can change the tracking configuration.

## Enter your Clarity project key

1. Sign in to your Microsoft Clarity / AdInsight account and open (or create) the
   project for this site. Copy its **project ID / tracking key**.
2. In Drupal, log in as a user with the module's *administer* permission, and open
   the AdInsight / Clarity settings form (added under **Configuration** once the
   module is enabled).
3. Paste your Clarity project key into the field and save.

Once saved, the module injects the Clarity tracking snippet into your front-end
pages and Clarity begins recording behaviour into your dashboard.

## Privacy and consent — do not skip

Because Clarity can record **session recordings and heatmaps**, it collects
sensitive personal data and sends it to Microsoft. Before you go live:

- **Disclose** the tracking in your privacy policy.
- **Consent-gate** it — integrate with your cookie/consent management so the script
  only loads after the visitor has agreed (behaviour recording is consent-gated
  under GDPR).
- **Mask sensitive fields** (passwords, personal details, payment fields) so they
  are excluded from recordings, using Clarity's masking options.

## A note on these docs

The upstream agent documentation for this module is thin and does not spell out the
exact admin path of the settings form or the precise field labels. The steps above
describe the module's behaviour as documented (it adds a settings form and a
permission for entering the Clarity project key); confirm the exact wording on your
own site's form after enabling the module.
