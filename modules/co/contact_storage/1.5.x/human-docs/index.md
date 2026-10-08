# Contact Storage — manual setup guide

**Contact Storage** (`contact_storage`) makes Drupal's core Contact module actually
*keep* the messages people submit. Normally core builds a contact message, emails
it, and then throws it away. Contact Storage saves each submission as an editable
`contact_message` content entity, and adds an admin listing so site editors can
review, view, edit, and delete received messages — turning core Contact into a
lightweight alternative to Webform for simple data collection.

Because contact forms become entity **bundles**, you can add ordinary Drupal
**fields** (a phone number, a dropdown, and so on) to a contact form, and they're
stored with each submission. Each message also records **when** it was created, the
**user** who sent it, and their **IP address**. The stored messages are exposed
through a bundled Views page at *Structure → Contact → List*, with per‑message view
/ edit / delete and a bulk delete action.

Contact Storage also adds a set of **per‑form extras** (configured on each contact
form's edit page): a custom submit‑button label, an optional URL alias, a
disabled‑form message, a preview toggle, and a cap on submissions per user. You can
enable or disable an individual form, clone a whole form, and route submissions to
different recipients based on a selected option. A small global setting controls
whether contact mail is sent as HTML.

Contact Storage depends on core **Contact**, **Views**, **Options**, and
**Filter**, plus the contrib **Token** module. It has no submodules and defines no
permissions of its own — access is gated by the core **Administer contact forms**
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the message list, per‑form settings,
   enabling/disabling and cloning forms, and the global HTML‑mail setting.

## Where it lives in the admin menu

Everything hangs off **Structure → Contact** (`/admin/structure/contact`):

- **Messages list** — *Structure → Contact → List*
  (`/admin/structure/contact/messages`).
- **Per‑form settings** — the extras appear on each contact form's add/edit page
  (*Structure → Contact → (a form)*).
- **Global setting** — *Structure → Contact → Settings*
  (`/admin/structure/contact/settings`).

All of it is gated by the **Administer contact forms** permission.

## How to use it

1. With the module enabled, every submission through your existing core contact
   forms is now saved automatically.
2. Review submissions at **Structure → Contact → List**.
3. Optionally add fields to a contact form, and tweak its per‑form extras (submit
   text, URL alias, submission cap, and so on).

See [Configuration](configuration/index.md) for the details.
