# Configuration

Setting up Help Scout Beacon is a two‑part job: tell Drupal which Beacon to embed
(the form id), and decide which roles should see the widget (the permission).

## Before you start

In your **Help Scout** account, create a Beacon (or open an existing one) and copy
its **form id** — the unique identifier Help Scout assigns to that Beacon. This is
the value Drupal needs. It is a public, client‑side embed id, not a secret, so it is
safe to store in ordinary Drupal configuration.

## Open the settings form

1. Log in as a user with the **Administer Help Scout Beacon settings** permission
   (an administrator by default).
2. Go to **Configuration → Web services → Help Scout Beacon**, or navigate directly
   to `/admin/config/services/help-scout-beacon/settings`.

## The Beacon form id field

The settings form has one main field:

- **Beacon form id** — paste the form id you copied from Help Scout here. This is the
  identifier the module hands to the Beacon JavaScript so it knows which Beacon to
  load. Change this value later to swap in a different Beacon.

Click **Save configuration**. The id is stored in the module's configuration
(`help_scout_beacon.settings`), which means it travels with your configuration
export/import like any other setting.

## Grant the "Use Help Scout Beacon" permission

The widget is only attached for users who hold the **Use Help Scout Beacon**
permission, so nothing appears until you grant it:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Use Help Scout Beacon** and tick it for each role that should see the
   widget:
   - Grant it to **Authenticated user** to show the Beacon to everyone who is logged
     in.
   - Grant it to **Anonymous user** as well to show the Beacon to *all* visitors.
   - Grant it only to a **support/staff role** to keep the widget internal.
3. Save permissions.

Revoking the permission from every role effectively turns the widget off site‑wide
without uninstalling the module, and roles that lack the permission never load the
Beacon JavaScript at all — so there is no front‑end overhead for them.

## A note on security

There are no credentials or API keys involved. The Beacon form id is a public embed
identifier that Help Scout expects to appear in page source, so storing it in plain
configuration is by design and poses no secret‑leakage risk.
