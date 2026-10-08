# Configuration

Cookiebot + GTM is inert until you enter your Cookiebot profile and GTM container
id. Everything is done from one settings form.

## Open the settings form

1. Log in as a user with the **`access cookiebot gtm config`** permission (grant it
   under Administration → People → Permissions to a trusted role — it is a
   restricted permission).
2. Open the **Cookiebot + GTM** settings form under **Configuration** (settings
   route `cookiebot_gtm.cookiebot_gtm_config_form`).

## What you configure here

- **Cookiebot profile / CBID** — the identifier for the Cookiebot profile you
  created for this site. This is the consent side of the integration.
- **Google Tag Manager container id** — your GTM id (in the form `GTM-XXXXXXX`).
  This is where your tags are managed. Once both are set, the module wires the
  Cookiebot consent signal into GTM.
- **Multilingual options** *(optional)* — for a multilingual site you can set the
  language of the cookie banner and, if you want, a **separate GTM id per language**.

Save the form. All of your other external JavaScript should then be added through
GTM, where Cookiebot's consent signal governs when each tag may fire.

These are account/container identifiers (configuration), not secrets.

## Make consent actually stick — verify these

- **Order matters:** the consent signal must arrive before any tag can fire, or the
  first pageview leaks tracking regardless of the visitor's later choice.
- **Per‑tag checks:** the consent condition lives in each tag's *trigger* in GTM,
  not in the container. A tag added by someone who does not follow the convention
  fires unconditionally, so audit the GTM tag inventory regularly.
- **Drupal‑attached scripts bypass GTM:** anything a Drupal module adds through the
  asset system is not governed by this integration at all — move such tracking into
  GTM if it needs to respect consent.
- Disclose your use of Cookiebot and GTM in your privacy policy.
