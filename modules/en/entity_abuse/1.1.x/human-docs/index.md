# Entity Abuse — manual setup guide

**Entity Abuse** (`entity_abuse`) gives your visitors a way to flag problematic
content. Once enabled and configured, an "Add complaint" link appears on the
content types you choose, and clicking it opens a small form where a user can
submit an abuse report against that entity. The reports pile up in one place so
moderators have a queue of flagged content to work through. On Drupal 8 and later
it works against **any content entity** — nodes, comments, users, taxonomy terms,
and so on — not just a fixed list.

Reports are themselves stored as content entities, so you manage their fields and
form display the same way you would any other entity. By default each report has a
single formatted long-text **Message** field, but you can add more fields on the
report's *Manage fields* tab. The module integrates with **Views** and **Views
Bulk Operations**, which is how site builders turn the collected reports into a
usable moderation dashboard.

This is not a works-on-enable module: after installing it you need to visit its
settings page to pick which content types can be reported and to tune the link and
message text, then set up permissions for who may submit, edit, and review
reports. It depends only on core's **User** and **Filter** modules.

A word of caution because this feature accepts public input: the report text is
**user input**, so make sure it is treated safely wherever moderators view it, and
if you let anonymous or lightly-trusted users submit reports, the reporting form
itself becomes a spam vector — pair it with CAPTCHA and/or flood control and gate
submission through the module's permissions. Reports can also name or accuse other
users, so treat the collected data with appropriate care.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types can be
   reported, set the link and message text, and wire up permissions.

## Where it lives in the admin menu

Once enabled, the module's settings live under **Structure → Entity abuse**
(`/admin/structure/entity-abuse`). From that same area you also reach the report
entity's **Manage fields**, **Manage form display**, and (if you enable the core
Configuration Translation module) a **Translate entity abuse** tab for translating
the button labels and messages.
