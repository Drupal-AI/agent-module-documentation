# Configuration

The Drupal side of Lawwwing is deliberately thin: you connect your site to your
Lawwwing account by entering a **Plugin ID**, and the service does the rest. The
banner's appearance, language, and behaviour, along with the legal documents and
cookie scanning, are configured in your **Lawwwing account dashboard**, not in
Drupal.

## Open the settings form

1. Log in as a user with permission to administer the module (Lawwwing defines its
   own permission for this).
2. Go to **Configuration → Lawwwing Settings**.

## Enter your Plugin ID

- **Lawwwing Plugin ID** — the identifier from your Lawwwing account. This is the
  key that tells the module which Lawwwing configuration to load. Paste it in and
  save.

Once saved, the module injects Lawwwing's script and the site immediately begins
showing the cookie banner and serving the auto‑updated legal texts. Adjust the
banner style, language, and behaviour from your Lawwwing dashboard.

## Privacy, consent, and egress considerations

Because this integration loads a third‑party script and exchanges consent data
with an external service, keep the following in mind:

- **Data leaves your site.** Consent events and configuration are handled by
  Lawwwing. Make sure that is reflected in your privacy policy and is acceptable
  for the jurisdictions your visitors are in.
- **Outbound access is required.** Your Drupal installation must be able to reach
  Lawwwing to fetch configuration and updates, and visitors' browsers must be able
  to load the widget script.
- **Content‑Security‑Policy.** If you run a CSP, allow Lawwwing's script domain in
  your `script-src` (and any connect/frame directives the widget needs), otherwise
  the banner will be blocked.
- **Account credentials are secrets.** Keep your Lawwwing account credentials and
  any API key out of version control; store them securely (for example in
  environment variables) rather than committing them.
