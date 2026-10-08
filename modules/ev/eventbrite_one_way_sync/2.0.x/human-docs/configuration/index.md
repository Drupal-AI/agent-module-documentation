# Configuration

Eventbrite One-Way Sync is configured in three parts: your Eventbrite **credentials**,
the **webhook** that carries updates into your site, and (optionally) how events map to
**nodes**. There is no admin settings form — the credentials live in configuration /
`settings.php`, which keeps your secret tokens out of the exported config and the
database.

## 1. Store your Eventbrite token as a secret

Each Eventbrite account is accessed with a **private token**. Never hardcode a token in
code or commit it to version control. With DDEV, store it as an environment variable:

```bash
ddev dotenv set .ddev/.env --eventbrite-token=<your-private-token>
ddev restart
```

That makes the value available inside the web container as `EVENTBRITE_TOKEN` (keep
`.ddev/.env` out of version control). You can then read it in `settings.php` with
`getenv('EVENTBRITE_TOKEN')`. If you manage several accounts, use one variable per
account.

## 2. Configure the accounts

The module reads its accounts from the `eventbrite_one_way_sync.unversioned` config,
under an `api-keys` list keyed by an **account label**. For each account you provide a
**private token** and an **organization ID**. Because these values are read at runtime,
the recommended place to set them is `settings.php` (which is not exported with your
site config), pulling the token from the environment variable above rather than writing
it inline. This lets one site sync multiple Eventbrite accounts, each identified by its
label.

To find these values: the **private token** comes from your Eventbrite account's API
key page, and the **organization ID** identifies which Eventbrite organization's events
to pull.

## 3. Run the initial import

With at least one account configured, run the initial bulk import so the site fetches
the organization's existing events. From then on, ongoing changes are delivered by
webhook (next step).

## 4. Point an Eventbrite webhook at your site

Ongoing updates arrive through the **Webhook Receiver** module, not through any route
this module defines. In your Eventbrite account, create a webhook that targets your
site's Webhook Receiver endpoint. The Eventbrite receiver plugin **defers** the payload
(Eventbrite's timeout is short) and then routes it by action — handling `event.updated`
to refresh events and `test` for connectivity checks.

> **Secure the webhook.** This module does not verify a signature on the incoming
> payload — the only authentication on inbound webhooks is whatever you configure in
> **Webhook Receiver**. Configure that authentication before relying on the webhook in
> production, and treat the Webhook Receiver endpoint as the trust boundary.

## 5. (Optional) Map events to nodes

If you enabled the **Eventbrite One-Way Sync Node** submodule, configure its
`FieldMapper` to decide which Eventbrite fields populate which node fields. Event
start/end times are stored using core's Datetime Range. Because the sync is one-way,
treat these nodes as a read-only mirror of Eventbrite — edits in Drupal are not pushed
back.

## Verifying

Use the built-in smoke test to confirm the API connection, and the end-to-end
self-test against a dummy account to confirm the whole path works. Webhook activity is
logged through Webhook Receiver's logger.
