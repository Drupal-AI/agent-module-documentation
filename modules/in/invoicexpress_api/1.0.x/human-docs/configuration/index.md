# Configuration

InvoiceXpress API is configured on one form at **Configuration → Web services →
InvoiceXpress API** (`/admin/config/services/invoicexpress_api`). This is where
you connect Drupal to your InvoiceXpress account.

## Enter your API credentials

1. Log in to your **InvoiceXpress dashboard** and obtain your **API key** and
   account details. (This requires a direct contract with InvoiceXpress.)
2. In Drupal, open **Configuration → Web services → InvoiceXpress API**.
3. Enter your API key and any account/endpoint details the form asks for.
4. Save the configuration.

Once saved, the four services (`invoicexpress_api.invoices`,
`invoicexpress_api.estimates`, `invoicexpress_api.clients`,
`invoicexpress_api.sequences`) can authenticate against InvoiceXpress.

## Keep the API key a secret

The API key authorizes billing operations against your InvoiceXpress account, so
treat it as a credential, not ordinary configuration:

- **Store it as an environment variable rather than hard‑coding it.** With DDEV,
  save it into the container's environment:
  ```bash
  ddev dotenv set .ddev/.env --invoicexpress-api-key=your-key-here
  ddev restart
  ```
  Keep `.ddev/.env` out of version control.
- Where the module supports it, prefer referencing the key through a **Key
  entity** (the [Key](https://www.drupal.org/project/key) module) backed by that
  environment variable, so the secret never lands in exported configuration or the
  database in plain text.
- If the key is ever exposed, **rotate it** in your InvoiceXpress dashboard.
- Always communicate with InvoiceXpress over **HTTPS**.

## Handle invoicing data responsibly

The data exchanged with InvoiceXpress includes invoicing and client information —
that is personal data plus financial and fiscal records. Handle it in line with
your privacy policy and your fiscal/legal obligations, and limit which staff can
administer this integration. The module's own permission has no access‑control
role beyond gating the settings; the sensitivity is in the data and the key.
