# Configuration

Configuration means telling Drupal how to reach your Mautic instance (or several)
and, where needed, setting up the webhooks Mautic uses to notify Drupal. Mautic API
supports **multiple instances**, so you manage a set of connections rather than a
single global setting.

## Permissions to grant first

Mautic API gates its administration behind two permissions, both of which should go
only to trusted administrators:

- **`administer mautic_api_connection`** — create and manage Mautic connections
  (the server details and credentials).
- **`administer mautic_api_webhook`** — create and manage the webhooks tied to those
  connections.

Set these under **People → Permissions** (`/admin/people/permissions`).

## Add a Mautic connection

Using the connection admin (available to holders of
`administer mautic_api_connection`), add a connection for each Mautic instance you
integrate with. A connection carries the Mautic server URL and the **API
credentials** used to authenticate. Because Mautic supports multiple instances, you
can define more than one and other modules choose which to use.

## Manage webhooks

Where an integration needs Mautic to notify Drupal of events, add **webhooks**
(with `administer mautic_api_webhook`). These are managed per connection so each
Mautic instance can have its own.

## Store credentials securely

Mautic API credentials grant access to your marketing platform and the contact data
it holds, so keep them out of plain, git‑committed configuration:

- Prefer supplying credentials from an **environment variable** rather than typing
  secrets into exported config. With DDEV, store the value with
  `ddev dotenv set .ddev/.env --mautic-secret=<value>` (keep `.ddev/.env` out of
  version control) and `ddev restart`, then reference it from settings or a Key
  entity where supported.
- Restrict the two `administer mautic_api_*` permissions to trusted roles only.

## Save

Save each connection (and any webhooks). Once a valid connection exists, Mautic API
becomes the shared client that other Mautic modules — and your custom code — use to
talk to Mautic.
