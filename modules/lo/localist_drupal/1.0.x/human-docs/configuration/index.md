# Configuration

All setup happens on one page: **Configuration → Web services → Localist
settings** (`/admin/config/services/localist`).

## Connect to Localist

1. Open the Localist settings page.
2. Tick **Enable Localist sync**.
3. Enter your organization's **Localist endpoint base URL**. You can find this on
   your Localist home page or by asking your Localist representative.
4. Click **Save configuration** at the bottom.

When the form reloads, check the **Preflight Check** section at the top. If the
endpoint is reachable, a green checkmark appears next to **Localist Endpoint**.

## Create groups and choose one to sync

1. Click **Create Groups**. This synchronizes the groups from Localist and adds
   them as taxonomy terms in the **`localist_groups`** vocabulary.
2. Once the groups exist, use the **Group to Sync Events** autocomplete to select
   the group whose events you want to bring into Drupal.

At this point all Preflight Checks should be green.

## Set up the event migration

Selecting a group prepares the module, but **no events are synced until an event
migration is specified**. You can:

- Install the module's bundled **recipe**, which creates an example migration that
  demonstrates how event data maps into Drupal, or
- Write your own event migration to control exactly which Localist event fields
  land on which Drupal fields.

Building a custom event migration is covered in the project's `README.md`.

## Scheduled syncing

Migrations registered in the module's configuration run **automatically on cron**,
hourly. Make sure cron is running on your site so new and updated events keep
flowing in without manual intervention. You can also trigger migrations manually
with the standard Migrate Tools Drush commands during setup and testing.

## A note on the endpoint

The Localist endpoint base URL is a connection setting rather than a secret
credential, but keep the integration on HTTPS so event data is fetched over a
secure connection.
