# Required Message — manual setup guide

**Required Message** (`required_message`) lets you replace Drupal's generic
"*&lt;field&gt; field is required*" validation error with your own wording, one
field at a time. When someone submits a form and leaves a required field empty,
they see the message *you* wrote — for example "Please enter your email address so
we can reply" instead of the terse default.

The module is deliberately small. It adds a **Required message** box to the field's
edit form in Field UI, which appears only when that field is marked as required.
Whatever you type is stored with the field's configuration and shown as the
validation error whenever the field is submitted empty. Leave the box blank and
Drupal falls back to its normal default message.

Because the setting lives on the field configuration, it exports cleanly with your
configuration for deployment and can be translated through Drupal's standard
configuration translation. It works on any fieldable entity — nodes, users,
taxonomy terms, and so on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no central settings page — you set the message per field on the
Field UI edit form, described in "How to use it" below.

## Where it lives in the admin menu

There is no dedicated admin page. The **Required message** box appears on each
field's edit form under **Structure → Content types (or Users, or Taxonomy) →
Manage fields → *(the field)* → Edit** — but only when the field's **Required
field** checkbox is ticked.

## How to use it

1. Go to the field you want a custom message for: **Manage fields → *(the field)*
   → Edit**.
2. Make sure **Required field** is checked. The **Required message** section only
   appears for required fields.
3. Type the message you want people to see when they leave the field empty (for
   example, "Please enter your phone number").
4. Save the field settings.

To remove a custom message later, clear the **Required message** box and save
again — the field then reverts to Drupal's default error text.
