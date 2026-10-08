# Configuration

Monsido Tools is configured on a single settings form where you connect the site
to your Monsido account and control where the Monsido agent script is loaded.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the Monsido Tools settings page (route `monsido.admin_settings`), under
   **Configuration**.

## The connection and agent settings

The exact labels come from your Monsido account, but you will typically set:

- **Account / customer identifier and agent token** — the values from your
  Monsido account that identify this site to Monsido and authorise the agent.
  These come from your Monsido dashboard. Treat the token as sensitive: don't
  share it publicly, and if your workflow supports it, keep environment-specific
  values out of exported configuration.
- **Where the agent loads** — options that control on which pages/parts of the
  site the Monsido agent script is embedded. Load it where you want Monsido to
  observe real usage, and consider excluding purely administrative areas.

## Privacy, consent, and CSP

The Monsido agent is a **third-party script** that loads from Monsido's servers:

- **Consent** — depending on what the agent does and your jurisdiction, you may
  need to disclose it in your privacy policy and gate it behind your cookie/
  consent management.
- **Content Security Policy** — if your site sends a CSP, you must allow the
  Monsido script/connection domains, or the agent will be blocked from loading.

## Save

Save the form. Then load a front-end page and confirm the Monsido agent is
present (via your browser's developer tools). Remember that Monsido Tools is
deprecated — for new work, use the Acquia Optimize module instead.
