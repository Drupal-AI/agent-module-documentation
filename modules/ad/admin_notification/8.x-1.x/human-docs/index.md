# Admin notification — manual setup guide

**Admin notification** (`admin_notification`) lets a site administrator set a single
message that is shown to **every logged‑in user** on each page they load. It is a
lightweight way to broadcast a short site‑wide notice — a scheduled maintenance
window, a policy or workflow change, a deploy freeze, an incident heads‑up — without
creating content, placing a block, or building anything custom.

You control the notice from one settings form: a toggle to turn it on or off, the
message text, and the message severity (status, warning, or error). While the notice
is enabled, Drupal shows it through its normal messenger area on every request, so it
reappears on each page load until you switch it off or clear the text. Only
authenticated users ever see it — anonymous visitors do not.

Because the message is displayed exactly as typed, treat it as trusted admin‑only
content: grant the **administer admin notification** permission only to roles you
trust to edit it. There are no other routes, no anonymous or mutating endpoints, and
no external calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   the on/off toggle, the message, and the severity type.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Admin notification**
(`/admin/config/system/admin_notification`), gated by the **administer admin
notification** permission.

## How to use it

1. Grant **administer admin notification** to a trusted role on the
   **People → Permissions** page.
2. Open the settings form, tick **enabled**, type your message, choose a severity,
   and save.
3. To stop the notice, untick **enabled** (or clear the message) and save again — it
   disappears immediately for all logged‑in users.
