# Contact Storage Remote — manual setup guide

**Contact Storage Remote** (`contact_storage_remote`) forwards submissions from
Drupal's core **Contact** forms to remote or external systems — a webhook, a CRM,
a third‑party web service — through a pluggable "remote storage" architecture. It
depends only on core's Contact module.

On its own the module is a **framework**, not a finished integration. It provides
the plumbing: a plugin type for transports (the thing that actually pushes a
submission somewhere), per‑plugin field mapping so you can shape the outgoing
payload, a mail settings form, and a **conditions** system that can limit sending
to submissions matching field‑value rules (for example, only forward messages
where "Department" equals "Sales"). The actual delivery — the HTTP client, the TLS
settings, any API credentials — lives in a concrete transport plugin. A companion
module, `contact_storage_remote_webhook`, ships an example transport that POSTs the
message fields to a URL; without a transport plugin installed, the base module has
nothing to send with.

Once enabled, a **Remote storage** tab appears on each contact form's edit page.
There you enable and configure transports per form, set up field mapping, and add
conditions. Everything is gated behind a single dedicated permission, and the base
module exposes no anonymous or public endpoints — the security posture of the
outbound connection depends on whichever transport plugin you install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   add a transport plugin.
2. [Configuration](configuration/index.md) — the per‑form Remote storage tab, field
   mapping, conditions, and permissions.

## Where it lives in the admin menu

Contact Storage Remote adds no top‑level settings page. Its controls live per
contact form under **Structure → Contact forms → *(your form)* → Manage**, on the
**Contact Storage Remote** tab
(`/admin/structure/contact/manage/{contact_form}/contact-storage-remote`).
