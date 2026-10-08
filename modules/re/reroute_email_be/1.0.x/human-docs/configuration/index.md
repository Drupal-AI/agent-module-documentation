# Configuration

This module layers a friendlier settings screen and a governance model on top of
the Reroute Email module. Configuration has three parts: the settings form, the
permissions and roles that decide who may change what, and the status block.

## Open the settings form

1. Log in as a user with the **Administer reroute email** permission.
2. Go to **Configuration → Development → Better Experience for Reroute emails**, or
   navigate directly to `/admin/config/development/reroute_email_be`.

The form is the Reroute Email settings screen, enhanced so that individual fields
are enabled or disabled according to the granular permissions each role holds. The
core rerouting fields you configure here are:

- **Rerouting enabled** — the master switch for whether outbound mail is
  intercepted and redirected. Turn this *on* for staging/test, and make sure it is
  *off* on production.
- **Destination (rerouted) address** — the address that all intercepted mail is
  sent to instead of its real recipients.
- **Allowed (skipped) addresses** — addresses that are *not* rerouted, so genuine
  mail to those recipients still goes through.
- **Allowed roles** — roles whose mail is not rerouted.

## Granular permissions

Rather than a single "administer" switch, this module splits control into discrete
permissions so you can delegate carefully. Assign them at **People → Permissions**
(`/admin/people/permissions`):

- **Send rerouted email** (`send rerouted email`) — who may toggle rerouting on and
  off.
- **Edit destination address** (`edit destination address`) — who may change the
  address that intercepted mail is redirected to.
- **Edit allowed address** (`edit allowed address`) — who may edit the list of
  addresses excluded from rerouting.
- **Edit allowed roles** (`edit allowed roles`) — who may edit which roles' mail is
  not rerouted.
- **Configure reroute email module** (`configure reroute email module`) and
  **Configure reroute email be module** (`configure reroute email be module`) —
  broader configuration access to the underlying module and this companion.

On the settings form, fields a user lacks permission for are shown disabled, so you
can safely let, say, a tester toggle rerouting without also letting them change the
destination address.

## Governance roles

To make the permission split easy to apply, the module installs three roles you can
assign to people at **People**:

- **Data Owner** — overall responsibility for the data / rerouting configuration.
- **Data Steward** — oversight of data quality.
- **Data Custodian** — the technical storage and access role.

These are ordinary Drupal roles; adjust the permissions attached to each to match
your organisation's separation of duties.

## The Rerouting Status block

So the current state is never a surprise, place the **Rerouting Status** block in a
visible region:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, find **Rerouting Status**, and
   place it.

The block renders a themeable banner showing whether rerouting is **enabled**
(safe — mail is being captured), **disabled** (caution — mail is going to real
recipients), or **missing** (Reroute Email is not configured yet).

## Drush automation

The module ships Drush commands so you can switch the rerouting state from scripts
or CI pipelines, with optional email notifications to the people responsible for the
data. Run `drush list` after enabling the module to see the available commands.

## Save

Click **Save configuration** on the settings form to apply your changes. Confirm
the Rerouting Status block reflects the state you expect before relying on it —
especially before any deployment.
