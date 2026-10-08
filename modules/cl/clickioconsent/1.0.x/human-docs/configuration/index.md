# Configuration

Clickio Consent needs one piece of information from you: your **Clickio site ID**.
Once that's set, the module loads Clickio's script for that property and the CMP
takes over presenting the consent banner and recording consent.

## Open the settings form

1. Log in as an administrator.
2. Open the module's settings form from its entry on the **Extend** page (use the
   *Configure* link), or from the site's configuration area.

## What you configure

- **Clickio site ID** — the identifier for your Clickio property, which you obtain
  from your Clickio account. Enter it here and save. The module then injects
  Clickio's script tied to this ID so the consent banner loads for visitors.

  This value is **ordinary configuration, not a secret**: it identifies your Clickio
  property and is safe to store in Drupal config and include in exported
  configuration. It does **not** require a Key entity or an environment variable.

## After saving

Load a public page as an anonymous visitor and confirm the Clickio consent banner
appears. Because the CMP runs client-side, most of the customisation of the banner
itself (appearance, languages, TCF/Consent-Mode behaviour, reporting) is done in
your **Clickio account**, not in Drupal.

## Privacy reminder

The module sends traffic to Clickio and runs Clickio's code in your visitors'
browsers, where their consent data is processed. Make sure Clickio is vetted as a
data processor and is named in your site's privacy policy.
