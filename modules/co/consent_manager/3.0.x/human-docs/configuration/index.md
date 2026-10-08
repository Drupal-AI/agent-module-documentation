# Configuration

The base `consent_manager` module has **no settings form of its own** — it only
creates the shared admin area and defines the permission that guards everything.
The real configuration lives on each product submodule's settings form, and they
all share the same layout and the same "Install now" onboarding flow described
below.

## Who can configure it

A single permission controls the entire feature:

- **Administer consent manager settings** (`administer consent manager settings`)
  — required to open any product settings form. It is a **restricted** permission
  (Drupal flags it as security-sensitive), so grant it only to trusted
  administrators. Because these forms let someone inject third-party `<script>`
  code onto every page, this permission is genuinely powerful.

Grant it under **People → Permissions**.

## Where the settings forms are

Everything is grouped under **Configuration → consentmanager**
(`/admin/config/consent-manager`). Each product you enabled adds its own settings
form there — for example the cookie banner from `consent_manager_cmp`.

## Configuring a product

Every product form works the same way. The key field on each is the **Code-ID**,
which identifies one product in your consentmanager.net account. You have two ways
to fill it in:

- **Manually** — paste the Code-ID (and, if you use a non-default delivery host,
  the host/CDN values) from your consentmanager.net dashboard.
- **Automatically with "Install now"** — click the **Install now** button. A popup
  opens the consentmanager.net onboarding wizard. When you finish, the popup sends
  the resulting Code-ID and hosts back to the form (the module verifies the message
  really came from `app.consentmanager.net` before trusting it) and fills the
  fields for you. Then just save.

The delivery and CDN hosts default to `delivery.consentmanager.net` and
`cdn.consentmanager.net`; you normally only change them if consentmanager.net has
given you a custom domain. The form validates that any host you enter is a valid
hostname.

## How each product reaches your visitors

- **Banner and analytics products** (`consent_manager_cmp`,
  `consent_manager_analytics`) inject their code into the page automatically once a
  Code-ID is saved — there is nothing to place.
- **Block-based products** (the DSR form, privacy policy, and whistleblowing
  products) are exposed as a **consent_manager** block. Place them through
  **Structure → Block layout** in whichever region you want them to appear.

Saving a product form clears that product's cache so the change takes effect on
the next page load.
