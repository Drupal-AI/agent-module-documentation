# Configuration

GCLID has a single settings form that controls how the Google Click ID is
captured and where it gets written.

## Open the settings form

1. Log in as a user with the **Administer GCLID settings** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Configure GCLID settings**.

## The settings

- **Fields to auto‑populate** — tell the module which form field(s) should receive
  the captured GCLID. In a typical setup this is a hidden field you have added to
  your forms (for example a Webform component), so the GCLID rides along with the
  submission.
- **GCLID expiration** — how long the captured GCLID is retained for the visitor
  before it is considered stale. Match this to how long you want an ad click to
  remain attributable.
- **Roles** — which user roles the GCLID‑capturing functionality is enabled for,
  so you can limit it to anonymous visitors or specific roles as appropriate.

Save the form to apply your choices.

## Privacy and consent

The GCLID is a marketing identifier tied to an individual visitor. Capturing and
storing it is subject to your privacy policy and any cookie/consent regime you
operate under — make sure your consent flow accounts for it, and only capture it
where you're permitted to. This module records the identifier; it does not manage
consent on your behalf.
