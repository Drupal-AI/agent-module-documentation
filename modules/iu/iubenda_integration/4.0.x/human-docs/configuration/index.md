# Configuration

All of Iubenda Integration's settings live under **Configuration → Services →
Iubenda Integration** (`/admin/config/services/iubenda-integration`), across three
tabbed forms. Everything you save on any of the three tabs is stored in the **single
config object `iubenda_integration.settings`** — a useful thing to know when reading
the values back with `drush cget iubenda_integration.settings`.

All three forms require the **Administer iubenda_integration** permission.

## Tab 1 — General / Privacy

This is where you configure the privacy-policy link itself.

- **Privacy policy code** — the number from your `iubenda.com/privacy-policy/XXXXXXX`
  URL. This is **required**: Iubenda's JavaScript only attaches to your pages once a
  code is set.
- **Link style** — how the privacy-policy link looks: *no style*, *white*, or
  *black*, to match your theme.
- **Legal only** / **Show brand** — flags that control whether the link shows only
  the legal content and whether the Iubenda brand is shown.
- **Form element type** — whether the privacy-consent element added to your forms is
  a **checkbox** or a **radio**.
- **Forms** — a list of Drupal **form IDs** (one per line) that should get a required
  privacy-consent element. Any form whose ID you list here will force the visitor to
  accept the policy before submitting (useful on registration or contact forms).
- **Link text pieces** — the label and the pre-text / link text / post-text used
  when the privacy-policy link is rendered.

## Tab 2 — Cookie solution

This tab turns on and configures the cookie-consent banner.

- **Enable cookie solution** — the master switch for the banner.
- **Site ID** — your Iubenda site ID. Setting this also enables the script
  auto-blocking behaviour.
- **Legal frameworks** — toggles for **GDPR** (EU), **LGPD** (Brazil), **FADP**
  (Switzerland), and **US state** privacy laws. Enable the ones that apply; a single
  site ID can serve a multi-regulation banner.
- **Position** — where the banner sits: full-width top, bottom, floating center,
  floating top-left, and other options.
- **Background overlay** / **Apply styles** — whether to dim the page behind the
  banner and whether Iubenda applies its own styling.
- **Buttons** — which buttons the banner shows: **Accept**, **Customize**,
  **Reject**, and **Close**, plus whether the close button counts as a rejection.

## Tab 3 — Consent solution

- **API key** — your Iubenda Consent Solution API key. When set, the consent-solution
  JavaScript is attached so consent proofs are recorded.

## The privacy-policy block

The module provides a block, **Iubenda Integration: Privacy policy**. Place it in a
region from **Structure → Block layout** to output the privacy-policy link. The block
has its own settings for text shown before and after the link (a prefix, the link
text, and a suffix).

## The `[site:iubenda_integration]` token

The module registers a **`[site:iubenda_integration]`** token that renders the
privacy-policy link (pre-text + link + post-text). Drop it into any token-enabled
text — a footer, a custom block, or a field — to embed the link without placing the
block.

## Runtime behaviour worth knowing

- Iubenda's JavaScript loads from `cdn.iubenda.com` **only on non-admin pages**, and
  **only when a privacy-policy code is set**.
- Any form ID you listed under **Forms** gets a required consent element before it
  can be submitted.
- A response subscriber runs Iubenda's cookie-class parser to lock tagged scripts
  until the visitor consents.

## Translating the settings

The `iubenda_integration.settings` config is exposed to **config translation**, so
you can translate the link and banner text for a multilingual site.

## Reading and changing settings with Drush

```bash
drush cget iubenda_integration.settings iubenda_integration_policy_code
drush cset iubenda_integration.settings iubenda_integration_policy_code 1234567 -y
drush cset iubenda_integration.settings cookie_solution_enable true -y
drush cset iubenda_integration.settings siteId 987654 -y
drush cset iubenda_integration.settings position bottom -y
```
