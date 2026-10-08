# Contact Terms Of Service Checkbox — manual setup guide

**Contact Terms Of Service Checkbox** (`contact_tos_checkbox`) adds a **required
consent checkbox** — something like "I have read and accept the privacy policy" — to
Drupal's core site‑wide contact feedback form. Because the checkbox is marked
required, a visitor cannot submit the form until they tick it, giving you an
explicit, auditable record of consent. It depends only on core's Contact module.

This answers a very common legal / GDPR requirement: capturing clear consent before
a visitor sends personal details through the contact form. The module works by
altering the core `contact_message_feedback_form` and injecting the checkbox when
you enable it in configuration. Both the checkbox's **label** and its **description**
(which can include a link to your privacy or terms page) are set by an
administrator, so you can word the consent exactly as your legal team requires and
keep that wording in version control as exported configuration.

Two things are worth knowing up front. First, the shipped default label and
description are **in German** and link to a `/datenschutz` page, so almost every
site will edit them to match its own copy and language. Second, this project is
flagged **Unsupported / Obsolete** by its maintainer and is **not covered** by
Drupal's security advisory policy — consider whether core's own tools or a
maintained alternative fit better before relying on it long term.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Contact.
2. [Configuration](configuration/index.md) — turn the checkbox on and set its label
   and description text.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Contact TOS Checkbox**
(`/admin/config/user-interface/contact-tos-checkbox`), behind the **"administer
contact tos checkbox"** permission. The checkbox itself appears near the bottom of
the site‑wide contact feedback form once enabled.
