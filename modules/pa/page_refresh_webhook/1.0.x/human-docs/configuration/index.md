# Configuration

Page Refresh WebHook needs four things set: **where** to send the request (the
endpoint), **how** to authenticate it (an API key via the Key module, optional),
**which** content types trigger it, and **how deep** the refresh should go (crawl
depth). On this **1.0.x** branch, see the module's `README.md` for the exact
location of the settings form; the fields it exposes are described below.

## Store the API key with the Key module (do this first)

The API key value is **never stored in this module's configuration** — only a
reference to a **Key** entity is. Create the key first:

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Add a key holding your endpoint's API key value. An **environment‑variable** or
   **file** provider is recommended so the secret never lands in exported config or
   the database.

> **Never hard‑code or commit a secret.** Keep the value in an environment variable
> (or a file outside the docroot) and let the Key module read it.

## Configure the webhook

In the module's settings, set:

- **Endpoint** — the URL the POST request is sent to.
- **API key** — select the Key entity you created above. Its value is sent as an
  `api-key` request header. Leave it unset to send unauthenticated requests.
- **Content types** — enable only the content types whose saves should trigger the
  webhook.
- **Crawl depth** — per content type: `1` sends just the changed page's URL; `2`
  sends the URL plus linked/attached elements.

## How and when it fires

When a node of an enabled content type is saved, the module sends a POST to your
endpoint so the external system can rebuild or refresh the changed page. Remember
the direction: this is an **outbound** call from your site — there is no inbound
route that a third party can hit. The only authentication involved is the API key
your site sends on the outgoing request, so make sure your endpoint verifies that
header.
