# Add Email To Contact — manual setup guide

**Add Email To Contact** (`add_email_to_contact`) fixes a small but real annoyance
with Drupal's core Contact forms: when someone fills in a contact form, the email
that lands in the recipient's inbox doesn't always make the sender's own address
easy to see or reply to. This module makes sure the submitting person's email
address is always included in the message that goes out — so whoever receives it
can read who wrote and simply hit reply.

That's the whole job. It's an enhancement to Drupal's core **Contact** module,
with no content and no access rules of its own. It works quietly in the background
the moment it's enabled — there is nothing to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. Once enabled, the module simply changes the emails that
core Contact sends. The Contact forms themselves are still managed where they
always were, under **Structure → Contact forms**
(`/admin/structure/contact`).

## How to use it

1. Make sure Drupal's core **Contact** module is enabled and you have at least one
   working contact form.
2. Enable Add Email To Contact (see [Installation](installation/index.md)).
3. That's it — submit a test message through a contact form and check the email
   that arrives. The sender's email address is now included so recipients can see
   and reply to it.
