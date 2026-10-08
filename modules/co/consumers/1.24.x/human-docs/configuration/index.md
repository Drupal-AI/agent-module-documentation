# Configuration — the Consumers list

Consumers has no global settings page. Its "configuration" is the set of
consumer records themselves: each **consumer is a client-application identity**
that your site's API recognises. You manage them from a single list.

## Open the Consumers list

1. Go to **Configuration → Web services → Consumers**
   (`/admin/config/services/consumer`).

![The Consumers list with columns for Client ID, UUID, Label, Is Default, Status and Operations](../images/list.png)

## What each column means

The list shows one row per registered client, with these columns:

- **Client ID** — the identifier the client sends so the site can recognise
  which consumer is making a request (for example `default_consumer`).
- **UUID** — the entity's universally unique identifier.
- **Label** — the human-readable name of the client application.
- **Is Default?** — whether this consumer is the site's default. Exactly one
  consumer is the default; it is used when an incoming request does not name a
  specific client.
- **Status** — whether the consumer is **Active** or disabled. Disabling a
  consumer is how you revoke a client's access without deleting its record.
- **Operations** — the **Edit** action (and, via its dropdown, actions such as
  deleting or making a consumer the default).

The two buttons at the top let you **+ Add Consumer** (covered in the next
section) and **+ Export all consumers**.

## Each consumer is a client identity

A consumer is a *fieldable* entity, which is why other modules can extend it.
When you install **Simple OAuth**, for example, it adds fields to the consumer —
a client **secret**, allowed **scopes**, and **redirect URIs** — so the same
record becomes the full OAuth client definition. Out of the box, Consumers
stores each client's label, client ID, description, logo, a "3rd party" flag,
the default flag, and the active/disabled status.

To register a new client, continue to
[Adding a consumer](../adding-a-consumer/index.md).
