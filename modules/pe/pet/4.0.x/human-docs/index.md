# Previewable Email Templates (PET) — manual setup guide

**Previewable Email Templates** (`pet`) lets site builders create reusable, token-enabled
email templates that you can **preview — with tokens resolved — before sending**, and then
send to one or many recipients. It gives editors a single place to manage transactional and
notification emails (order confirmations, sign-ups, reminders, membership notices) instead of
burying that text inside code or Rules.

Each template is a small content entity with a subject and body (both of which can contain
tokens), plus optional extras like a plain-text body, a From override, and default CC/BCC
addresses. You manage templates from a dedicated admin listing where you can add, edit, clone,
and export them. When you send, an interactive two-step form collects the recipients and lets
you tweak the subject and body just for this one send, then shows you a **live preview** with
all the tokens substituted, and only sends when you confirm.

Token substitution uses the **Token** module, with `user` and `node` context pulled from the
recipient or from `?uid=` / `?nid=` values in the send URL — and developers can add their own
token objects via a hook. Beyond the interactive form, templates can be sent
programmatically from custom code with the module's send functions. A small settings form
controls how much sending activity is logged. If the **MimeMail** module is present, you also
get HTML-plus-plain-text multipart options. It depends on core's **Options** module and the
**Token** module.

This guide is written for a **human** setting things up through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the programmatic send API —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with Token) via Composer and
   enable it.
2. [Configuration](configuration/index.md) — permissions, the template fields, the logging
   setting, and MimeMail.

## Where it lives in the admin menu

- **Templates:** **Structure → PETs** (`/admin/structure/pets`) — list, add, edit, clone.
- **Send interactively:** `/pet/{template}`.
- **Settings:** **Configuration → System → PET settings**
  (`/admin/config/system/pet/settings`).
