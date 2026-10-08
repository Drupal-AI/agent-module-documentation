# Configuration

Cookie-Script is inert until you connect it to your Cookie-Script.com account.

## Open the settings form

1. Log in as an administrator (the module provides its own permission for managing
   the integration; grant it to the appropriate role under Administration → People
   → Permissions).
2. Navigate to **`/admin/config/cookie_script`**.

## What you configure here

- **Cookie-Script ID** — the identifier from your Cookie-Script.com account. This is
  what activates the integration: once set, the Cookie-Script code loads on your
  pages and shows the consent banner. It is an account identifier (configuration),
  not a secret.

Save the form when you are done.

## Compliance and data‑flow notes

- A banner is only compliant if the cookie‑setting scripts **respect consent**. In
  your Cookie-Script dashboard, configure blocking of analytics, marketing, and
  embed scripts until the visitor agrees.
- The integration loads Cookie-Script's code from its own origin on your pages, so
  that third‑party origin is added to every page. If you run a
  Content‑Security‑Policy, allow it as a script source.
- Disclose the use of the Cookie-Script consent service in your privacy policy.
- Consent categories and consent records are managed in the Cookie-Script service,
  not in Drupal.
