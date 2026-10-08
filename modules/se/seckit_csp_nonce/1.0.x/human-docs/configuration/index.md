# Configuration

SecKit CSP Nonce needs a little configuration to be effective: you choose how it
operates and, crucially, you make sure your Content Security Policy actually
**requires** the nonce. Adding a nonce to your scripts does nothing for security
if the policy still allows `'unsafe-inline'`.

## Open the settings

Log in as an administrator and open the module's settings form. This is where you
select the operation mode and how the module interacts with SecKit.

## Operation modes

The module offers multiple operation modes for how the CSP header is produced:

- **Merge with SecKit** *(recommended)* — the module adds its per-request nonce
  to the CSP policy that the **Security Kit (SecKit)** module already emits. Use
  this when you manage your CSP through SecKit and simply want nonce support layered
  on top. It requires SecKit to be installed and configured.
- **Override SecKit** *(advanced)* — the module replaces SecKit's CSP entirely
  with its own. Use this only if you want this module to be the sole source of the
  CSP header.
- **Standalone** — the module generates and enforces its own nonce-based CSP
  without SecKit in the picture.

## Google Tag Manager support

If you use **Google Tag Manager**, the module can nonce the GTM container script
so GTM works under a strict CSP without `'unsafe-inline'`. Enable the relevant GTM
option in the settings if that applies to your site.

## Make the CSP actually require the nonce

This is the step that turns the feature from cosmetic into real protection:

- Ensure your CSP `script-src` **does not include `'unsafe-inline'`**. As long as
  `'unsafe-inline'` is present, the browser allows any inline script and the nonce
  is ignored. Removing it makes the nonce the thing that authorizes inline scripts.
- Ensure **every legitimate inline script** on your pages receives the nonce.
  The module aims to cover core, contrib, theme templates, raw markup, GTM, and
  third-party widgets — but if you have inline scripts injected by some path the
  module does not catch, those scripts will be blocked once `'unsafe-inline'` is
  gone. Watch the browser console for "Refused to execute inline script" errors
  and confirm each blocked script is either given the nonce or moved to an
  external file.

## Save and test

Save the form, then reload a page and inspect it: inline `<script>` tags should
carry a matching `nonce` attribute and the CSP header should reference the same
nonce. Clicking through the site (especially any pages with analytics, embeds, or
custom widgets) and watching the console for CSP violations is the best way to
confirm nothing legitimate is being blocked before you rely on the strict policy.
