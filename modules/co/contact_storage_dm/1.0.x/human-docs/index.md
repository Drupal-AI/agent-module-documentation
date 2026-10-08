# Contact Storage Disable Mail — manual setup guide

**Contact Storage Disable Mail** (`contact_storage_dm`) lets you turn off email
notifications on a **per-contact-form basis**. It extends the
[Contact Storage](https://www.drupal.org/project/contact_storage) module: you pick,
form by form, which contact forms should send an email on submission and which
should just store the submission without emailing anyone.

The problem it solves comes up when you use Contact Storage to collect submissions
in the database and review them there — for some forms you don't want an email
going out at all. Rather than an all-or-nothing choice, this module gives you a
simple per-form switch. It depends on the Contact Storage module.

Turning off the email doesn't affect storage: submissions are still captured and
governed by the usual contact and contact-storage access. The module adds no
access-control role of its own — it only controls whether a notification is sent.

There's no central settings page. You flip a checkbox on each contact form's edit
screen, as described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (along with Contact Storage).

There is **no central configuration page** — you disable mail per form with a
checkbox on the contact form, as described below.

## Where it lives in the admin menu

The module adds no settings page of its own. You work on each contact form at
**Structure → Contact forms → *(your form)* → Edit** (`/admin/structure/contact`),
where it adds a **Disable Mail Send** option.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Contact forms** (`/admin/structure/contact`) and edit the
   contact form that should stop sending email.
3. Tick the **Disable Mail Send** option that the module adds to the form.
4. Save the form.

From then on, submissions to that form are stored (via Contact Storage) but no
email notification is sent. Leave the box unticked on any form that should keep
emailing as usual.
