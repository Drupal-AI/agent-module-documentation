# Configuration

Poool is configured from a settings page where you enter your Poool application id
and define which content is free, premium, subscription or registration-gated.

## Open the settings page

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default). The module defines no permissions of its own.
2. Go to **Configuration → Web services → Poool**, or navigate directly to
   `/admin/config/services/poool`.

## What you configure

- **Application id** — your public Poool key from your poool.fr account. It is
  validated against Poool's expected key format before the tracker script is added
  to the page. Remember this is a **public** identifier, not a secret.
- **Page types** — how content is classified for the paywall: **free**,
  **premium**, **subscription**, or **registration**. The page type for a given
  request is derived from your path rules, bundle (content-type) rules, or the
  entity's own `poool` field (see below).
- **Visibility rules** — which requests the paywall applies to, filtered by request
  path.
- **Role targeting** — which user roles the widget applies to (or is skipped for).

## Marking individual content with the Poool field

Beyond the site-wide rules, you can control the paywall per entity:

1. Add a **Poool** field to the bundles you want to control (through the bundle's
   **Manage fields**).
2. Use the field's widget on each entity to mark whether that item is paywalled and
   to set the **hidden percentage** — how much of the content Poool hides — and the
   mode (hide, excerpt, or custom).

## Deciding who is "premium"

By default **no one** is treated as a premium (paying) user, so the widget applies
to everyone in scope. To grant premium access, another module or custom code must
subscribe to the `PooolEvents::POOOL_USER_IS_PREMIUM` event and mark the current
user premium; doing so disables the widget for that user. Plan for this — without a
subscriber, every targeted visitor sees the paywall.

## Cookie consent (GDPR)

For privacy/consent handling you can tell Poool whether cookies have been allowed,
via JavaScript that sets `drupalSettings.poool.config.cookies_enabled`. The module's
`poool.api.php` documents alter hooks (for example to adjust page types) if you need
to customize behavior further.

## Important: this is a client-side (soft) paywall

Be clear about what this configuration does and does not protect. **Enforcement is
client-side only.** The full protected content is still rendered into the page's
HTML and is merely blurred or truncated by Poool's JavaScript in the browser.
Anyone who disables JavaScript or views the page source can read the "protected"
content. No server-side redaction is performed.

Use Poool for **metered/soft paywalls** where the goal is conversion, not
confidentiality. Never rely on it to protect content that genuinely must be kept
private — for that you need real server-side access control.

## Save

Click **Save configuration**. The paywall behavior takes effect immediately —
view a page in scope as a non-premium visitor to confirm Poool's widget hides the
content as expected.
