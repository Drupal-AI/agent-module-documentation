# Configuration

editics needs to know **where your CRI conversion server is** and **how to
authenticate to it**. That's the whole of the required configuration — everything
else (field‑to‑placeholder mapping) is done in YAML mapping documents by the
`cri_core_mapping` submodule.

## Open the settings form

1. Log in as a user with the **"Administer site configuration"** permission (an
   administrator by default).
2. Go to **`/admin/api/configuration`**.

The form stores its values in `editics.api.settings` and is organised into two
environments so you can point at a live server or a staging one per request.

## Production settings

- **Production server URL** — the address of your live CRI "flux" conversion
  server. editics POSTs the document content (as JSON) to this URL to produce the
  final Word/PDF file.
- **Production credential ID** and **Production credential password** — the
  username/password pair used to build the **HTTP Basic** `Authorization` header
  sent with the request.

## Staging ("recette") settings

The same three fields for a staging environment:

- **Recette server URL**
- **Recette credential ID**
- **Recette credential password**

The environment is chosen per request — a conversion call can select the
production credentials or fall back to the recette (staging) ones — so you can test
against staging before pointing production traffic at the live server.

## Save

Click **Save configuration**. Once the URL and credentials are stored, the module
can send content to the CRI server and receive generated documents. If credentials
are missing, conversion calls return a structured error rather than a document.

## Field mapping (via cri_core_mapping)

The document *content* itself is defined by **YAML mapping documents** read by the
`cri_core_mapping` submodule — each describes how a Drupal field maps to a
placeholder in the `.docx` template, and each field type (text, date, image, table,
numeric, percent, currency, checkbox list, etc.) is handled by its own type class.
Setting up those mappings is a developer task; the `cri_demo` submodule lets you
preview the output while you work.

## Security: protect the credentials in transit

This form holds credentials that are sent to a remote server, so handle it with
care:

- Serve the site over **HTTPS**, and make sure the connection to the CRI server
  uses properly **verified TLS** so the Basic‑auth credentials can't be captured in
  transit. Review the module's HTTP client behavior before production use.
- Keep the credentials out of version control. Because they're stored in
  configuration, be careful with configuration exports — don't commit them to a
  public repository.
- **Never feed untrusted content through the template engine's "Evaluate" field
  type**, which executes template values as PHP. Restrict document generation and
  its templates to trusted administrators.
