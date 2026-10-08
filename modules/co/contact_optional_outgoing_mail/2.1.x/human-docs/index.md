# Contact Optional Outgoing Mail — manual setup guide

**Contact Optional Outgoing Mail** (`contact_optional_outgoing_mail`) makes the
**recipient** field on a contact form optional. Normally Drupal's Contact module
insists on at least one recipient email address when you create or edit a contact
form, and it emails that address on every submission. This module relaxes that
requirement, so a form can be saved and used without a recipient — in which case no
email is sent on submission.

The problem it solves shows up when you only want to **store** contact submissions
rather than email them. Paired with the Contact Storage module, for example, you
can collect submissions in the database and skip the outgoing notification
entirely. It's a small, focused contact-form tweak that depends only on core's
**Contact** module and supports Drupal 9, 10, and 11.

There's no central settings page. Once enabled, the recipient field simply becomes
optional on the contact-form edit screen — leave it empty for the forms that
shouldn't send mail, as described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — enabling the module simply makes the
recipient field optional on contact forms, as described below.

## Where it lives in the admin menu

The module adds no settings page of its own. You work on each contact form at
**Structure → Contact forms → *(your form)* → Edit** (`/admin/structure/contact`),
where the **Recipients** field is now optional. Editing contact forms is
controlled by core's own **Administer contact forms** permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Contact forms** (`/admin/structure/contact`) and edit the
   form that should not send email.
3. Leave the **Recipients** field **empty** and save. Core would previously have
   blocked this; now it's allowed.
4. With no recipient set, submissions to that form are **not** emailed. If you're
   using Contact Storage (or another handler), the submissions are still captured
   there.

For forms where you *do* want notifications, just fill in the recipient as usual —
the field is optional, not removed.
