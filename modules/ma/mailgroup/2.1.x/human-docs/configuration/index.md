# Configuration

Setting up Mail Group has a clear order: get encryption in place first (so
credentials can be stored safely), then create a group and its connection backend,
then add members and delegate the right permissions.

## Step 1 — set up encryption

Because connection settings can include credentials, Mail Group stores them
**encrypted** through the [Encrypt](https://www.drupal.org/project/encrypt) module.
Before you configure a connection backend:

1. Install an encryption backend — for example
   [Real AES](https://www.drupal.org/project/real_aes), Key management: KMS, or
   Sodium — following your site's security policy.
2. Create an **encryption key** (typically via the
   [Key](https://www.drupal.org/project/key) module) and store it as a secret, not
   in configuration. Keep the raw key material out of version control.
3. Create an **encryption profile** in the Encrypt module that uses that backend
   and key.

With a profile in place, the credentials you enter for a connection backend are
encrypted at rest.

## Step 2 — create a group type and a group

1. Create a **Mail Group Type** to act as a template for your groups.
2. Create a **Mail Group** of that type, giving it the **email address** that will
   act as the list address (mail sent there reaches all members).
3. Choose the group's **reply behaviour** — whether replies go back to the
   original sender only, or out to the entire group.

## Step 3 — choose and configure a connection backend

A **connection plugin** determines how the group sends and receives mail. IMAP is
bundled; add-on modules provide others such as **Amazon SES** and **Mailgun**.
Select the backend for your group and fill in its settings — any credentials it
needs are stored encrypted using the profile from Step 1. Backends typically offer
a way to **test the connection** so you can confirm it works before going live.

## Step 4 — add members

Add users to the group as **Mail Group Memberships**. You can manage memberships
individually, and the module ships bulk actions (Views Bulk Operations) so you can
**activate, deactivate, add, or remove** memberships for many users at once from
the membership admin pages. Members can also be given a per-user "Mail Groups" page
where they manage their own memberships (subject to permissions).

## Step 5 — set permissions

Mail Group ships a fine-grained permission set. The key ones:

- **Administer mail groups** — the overarching admin permission (marked
  restricted). The bulk membership actions require this together with the relevant
  membership permission.
- **Add / edit / delete / view mail groups** — group-level management.
- **Add / edit / delete / view mail group memberships**, each with an **"own"**
  variant — so you can let members manage only their own memberships while
  reserving broader control for administrators.

Grant these at **People → Permissions** (`/admin/people/permissions`), giving the
administrative permissions only to trusted operators.

## A note on inbound mail

Received messages are routed in through the group's connection backend and handled
by the module (raw messages are parsed into stored Mail Group Messages). The
specifics of receiving depend on the backend you chose — for example, the Amazon
SES add-on documents its own AWS-side setup.
