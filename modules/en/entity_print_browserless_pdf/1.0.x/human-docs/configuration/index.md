# Configuration

Entity Print Browserless PDF is configured as an **engine choice inside Entity
Print's own settings** — it does not add a separate settings page. You select the
Browserless engine and tell it how to reach your Browserless instance.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Print**, or navigate
   directly to `/admin/config/content/entityprint`.

## Select the PDF engine

On Entity Print's settings page, find the **PDF engine** selector and choose
**Browserless**. Entity Print supports one active engine per document type, so
selecting Browserless makes it the engine used for PDF exports.

## Browserless connection settings

Once Browserless is selected, its connection fields appear:

- **Browserless endpoint / URL** — the address of your Browserless instance that
  Entity Print will POST the print HTML to. Use the full URL for your
  self‑hosted server or the hosted Browserless service.
- **Token** — the access token your Browserless instance requires (the hosted,
  paid service uses one). The module stores this value as a plain plugin
  configuration value within Entity Print's engine settings; it does not read it
  from an environment variable or a Key entity. Treat the resulting configuration
  as sensitive and restrict who can view or export it.

Requests are sent over Drupal's Guzzle HTTP client with TLS by default; keep the
endpoint on `https://` so the token and your content are encrypted in transit.

## Save

Click **Save configuration**. Then generate a PDF from any Entity Print print
link to confirm Browserless is producing the document.

## Operational note — outbound requests to a configured URL

This engine makes your web server send an HTTP request to the endpoint configured
above, carrying your rendered print HTML and the token. Because the endpoint is
set on the settings form, keep that form restricted to trusted administrators and
point it at a Browserless instance you operate or trust, using an explicit
`https://` URL. That keeps generation reliable and your content and token in
transit encrypted.
