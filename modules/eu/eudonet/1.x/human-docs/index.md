# Eudonet — manual setup guide

**Eudonet** (`eudonet`) provides an **API client for the Eudonet CRM**. It is a
client/service layer — the connectivity foundation that lets Drupal read from and
write to the Eudonet CRM's API, so other modules or custom code can synchronise
contacts and CRM records between your site and Eudonet.

By itself it is not a user‑facing feature; think of it as the plumbing your
integration builds on. It talks to the Eudonet API on your behalf, which means two
things worth planning for from the start:

- **Egress and credentials.** The client makes outbound calls to the Eudonet API
  using your Eudonet credentials, over HTTPS. You supply those credentials — the API
  base URL and the login parameters — on the module's own settings form (see below).
- **Personal data.** CRM records are typically contact data (PII). Moving that data
  between systems has privacy implications — disclose it in your privacy policy and
  handle it according to your obligations.

The module has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Eudonet is the integration foundation: enable it, configure the connection, then
build (or add) the module or custom code that uses its client to read/write Eudonet
CRM records.

### Configure the connection

Go to **Configuration → Services → Eudonet API configuration**
(`/admin/config/services/eudonet`) and fill in:

- **API base url** — for example `https://xrm.eudonet.com/EudoAPI/` (include the
  trailing slash).
- **Authentication** — subscriber login, subscriber password, base name, user login,
  user password, language and product name, as issued by your Eudonet environment.
  (Leave a password field blank on a later edit to keep the value you already saved.)

Press **Try auth request** to confirm the credentials work; the form reports either
a successful authentication or the API error returned. Once authenticated, the module
caches the returned session token and reuses it automatically — you do not normally
call the authentication step yourself.

### Build your integration

With the connection configured, custom code or a dependent module uses the `eudonet`
service to run queries (search, catalog, meta‑infos, create/update/delete,
attachments). See the [`agent/`](../agent/start.md) docs for the developer API.
