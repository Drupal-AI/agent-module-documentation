# Configuration

The sync does nothing until you configure it and enable it. Everything lives on
one form.

## Before you start

Make sure **CMRF Core** has a working CiviMRF connection to CiviCRM, and that
CiviCRM has the **ChangeMessages extension** installed with a change-message
definition you can point at.

## Open the configuration form

Go to `/admin/config/cmrf_user_sync/usersyncconfig`. (The route is gated by the
**Access administration pages** permission — see the caution about tightening
this in the [guide](../index.md).)

## Steps

1. **Connection** — select the CiviMRF connection to read from.
2. **Change MessageDefinition** — select the CiviCRM change-message definition
   whose messages drive the sync.
3. **Processor** — choose how each message is applied:
   - **Basic User Sync** (`cmrf_basic_user_sync`) — creates a user when no
     account has the contact id, updates name/email on a match, and blocks a
     non-administrator account when its email becomes empty. Map the **name**,
     **email**, and **contact id** fields.
   - **Portal User Sync** (`cmrf_portal_user_sync`) — matches by email; creates
     users, sends the activation notification email, assigns configured
     **roles**, and applies a **delete policy** of *delete* or *block*. Map
     **name**, **email**, **old email**, **contact id**, **roles**, plus any
     additional user fields you need.
4. **Field mapping** — map each CiviCRM message field to the corresponding Drupal
   user field, per the processor you chose.
5. **Enabled** — tick this so cron begins processing messages. Disabling the sync
   clears the processing queue.

## How it runs

Once enabled, cron does the work: when the queue is empty it seeds a "get" item
that fetches change messages from CiviCRM and enqueues one processing item per
message; each processing item then runs your chosen processor against that
contact. There is no manual "run now" button — it follows your cron schedule.

## Things to keep in mind

- **Access control.** The Portal processor can grant roles and delete accounts;
  because the form is only **Access administration pages**-gated, restrict the
  route to a stronger permission (e.g. **Administer users**) if that permission
  is broadly held.
- **New accounts have no password.** Created users must reset their password to
  log in conventionally.
- **Administrator-role accounts are protected** — they are never auto-deleted or
  auto-blocked.
- The `field_user_contact_id` user field, which links accounts to CiviCRM
  contacts, is writable only by users with **Administer users**.
