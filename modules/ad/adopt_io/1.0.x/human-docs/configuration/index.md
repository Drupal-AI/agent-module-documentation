# Configuration

Adopt.io has a settings form where you connect Drupal to your GoAdOpt (Adopt.io)
consent management platform. Once configured, the GoAdOpt banner script loads on
your site.

## Open the settings form

Open the module's Adopt.io / GoAdOpt settings as an administrator. This is where
you provide the details that tell the module which GoAdOpt CMP account to load.

## Enter your GoAdOpt CMP details

Supply your GoAdOpt CMP identifier / account details as provided by GoAdOpt. Save
the form, and the module embeds GoAdOpt's CMP script so the consent banner appears
to visitors and their consent choices are managed by GoAdOpt.

## Wire your other tags to the consent signal (the important part)

Adding the banner is only half the job. A consent management platform is meant to
**govern** whether other tracking runs, so:

- Connect your **analytics, advertising, and marketing tags** to GoAdOpt's consent
  signal so they only fire once the visitor has given the relevant consent.
- Remember that the GoAdOpt CMP script is a **third-party script** that manages
  consent and may set cookies or contact GoAdOpt itself — account for it in your
  own privacy disclosures.

## Verify

On a non-production environment, confirm the banner appears, that consenting and
declining behave as expected, and that your other tracking tags actually respect
the CMP's decision before relying on it for compliance.
