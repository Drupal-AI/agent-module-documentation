# Configuration

Setting this module up is a two-part job: first give Drupal your ActiveCampaign
credentials (through the ActiveCampaign API module), then map the fields on your
contact form to the fields in your ActiveCampaign account. Until both are done,
submissions are not sent anywhere.

## Step 1 — connect your ActiveCampaign account

The connection details live in the **ActiveCampaign API** module
(`activecampaign_api`), not in this module. Go to **Configuration → Web services →
ActiveCampaign API** (`/admin/config/services/activecampaign-api/account`) and add
an account. The account form asks for:

- **ActiveCampaign API base URL** — your account's API URL, e.g.
  `https://<your-account>.api-us1.com/api/3`.
- **ActiveCampaign API token** — the API key from your ActiveCampaign account
  (Settings → Developer). This is a required field.

There are also optional fields for event tracking and an error-reporting webhook
URL; leave them empty unless you use those features.

Save the account. You can add more than one account and target different ones from
different contact forms.

Because the API token is a secret entered here, restrict the
`manage activecampaign_api settings` permission to trusted administrators.

## Step 2 — map contact-form fields to ActiveCampaign

The custom fields you receive the data into must already exist in ActiveCampaign
before you can map to them, so create those first in your ActiveCampaign account.

On the Drupal side, this module lets you **manually map** the fields on a core
contact form to the corresponding ActiveCampaign fields. Work through the mapping
form and pair each contact-form field (name, email, and any extra fields you have
added to the form) with the ActiveCampaign field that should hold it. Only fields
you map are forwarded — anything left unmapped is simply not sent.

## Permissions

The module provides its own permissions. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant the configuration/mapping permission only
to trusted administrator roles, since it governs how submitted data leaves your
site for a third-party service.

## Save and test

After saving the credentials and the field mapping, submit a test contact form.
A new contact (or an update to an existing one) should appear in ActiveCampaign
with the mapped fields populated. If nothing arrives, re-check the API URL and
key, confirm the ActiveCampaign fields exist, and confirm the mapping is saved.
