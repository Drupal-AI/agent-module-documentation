# Contact Storage Options Email Recipient — manual setup guide

**Contact Storage Options Email Recipient** (`contact_storage_options_email_recipient`)
lets an *options* field on a contact form decide **where the submission is emailed**.
Instead of every message going to one fixed address, the visitor's choice — say
"Sales", "Support", or "Billing" — routes the email to the matching recipient
(sales@, support@, billing@…). It builds directly on the
[Contact Storage](https://www.drupal.org/project/contact_storage) module, which
supplies the "Options email" field type this module refines.

The problem it solves is a small but annoying one. Contact Storage's own "Options
email" field already lets a selected option add a recipient, but Drupal *still*
insists you fill in a recipient address on the contact form's edit page — so a
submission ends up going to **both** the typed recipient and the option-selected
one. This module removes that now-redundant recipient field whenever a *required*
"Options email" field is present, and shows a notice at the top of the form's edit
page: "The recipient of this form is determined by the '[field name]' field." When
the "Options email" field is optional, it instead notes that the field determines
an *additional* recipient.

There is no central settings screen. You configure the behavior entirely on Contact
Storage's side — by adding an "Options email" field to your contact form and mapping
each option to an address. Visitors pick from that administrator-defined list of
options; the option→address mapping is handled by Contact Storage, not by this
module. This module only removes the now-redundant recipient field on the edit page
and shows the notice. It adds no routes, permissions, or configuration of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Contact Storage.

There is **no dedicated configuration page** for this module. All setup happens on
your contact form's fields — see "How to use it" below.

## How to use it

1. With [Contact Storage](https://www.drupal.org/project/contact_storage)
   installed, edit (or create) a contact form under **Structure → Contact forms**.
2. Add an **"Options email"** field (the field type Contact Storage provides) and
   define the options, mapping each one to the address it should route to.
3. Make the field **required** if you want it to fully replace the form's single
   recipient. Once you save, this module removes the now-redundant recipient field
   and shows the "recipient is determined by…" notice on the edit page.
4. Submit a test message choosing each option and confirm it arrives at the right
   mailbox.
