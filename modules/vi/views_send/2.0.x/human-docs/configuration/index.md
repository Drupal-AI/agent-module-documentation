# Configuration

There are two parts to setting up Views Send: **building a View you can send
from** (done once per mailing tool), and the **global settings** that govern how
spooled mail is delivered.

## Build a sending View

1. Create a View with a **page or block** display over an entity that has email
   addresses (users, subscribers, registrations, content authors, …).
2. Add a **field that contains the recipient email address**. Optionally add a
   second field for the recipient's name, used as the "To" display name.
3. Add the field **Global: Send email**. This is the plugin that renders the
   per‑row checkboxes and the **Send email** button. (Its *enable excluded
   fields* option, on by default, lets columns you have hidden from display still
   be used as tokens in the message.)
4. Optionally **expose filters** so operators can narrow the recipient list right
   in the UI before sending.
5. Save the View, load the display, tick the rows you want (or select all), and
   choose **Send email**.

## The message form

When you send, you fill in a message form. The main fields are:

- **From name** and **From email** — the sender identity. The From email is
  validated as a real address.
- **Subject** and **Body** — personalize either with **tokens** that pull from
  each recipient's row (for example a name or order number). With Mime Mail
  enabled the body can be HTML.
- **Priority** — set a High / Low priority header for the campaign.
- **Receipt** — request a read receipt.
- **Additional headers** — one `Key: Value` per line (for example a `Reply-To`).
- **Carbon copy** — send a copy to the sender (on by default).

## Global settings (spool and cron)

Open **Configuration → System → Views Send**
(`/admin/config/system/views_send`); you need the **Administer views_send**
permission. These settings only matter for **spooled** (queued) sends — direct
sends go out immediately via the Batch API. Settings are stored in
`views_send.settings`.

- **Throttle** (`throttle`, default **20**) — how many messages are sent per cron
  run when delivering from the spool. Lower it to respect a mail provider's rate
  limits.
- **Retry** (`retry`, default **5**) — how many times a failed spooled message is
  retried before it is discarded.
- **Spool expire** (`spool_expire`, default **0**) — how many days to keep
  successfully sent rows in the spool table for auditing. `0` deletes them
  immediately after sending.
- **Debug** (`debug`, off by default) — log every outgoing message to the system
  log. Useful while testing; turn it off in production.

## Direct vs. spooled delivery

- **Direct** — messages are sent right away through the Batch API. Best for small
  or urgent sends.
- **Spool** — messages are written to the `views_send_spool` table and delivered
  by cron, up to *throttle* per run, honoring *retry*, then cleaned up according
  to *spool expire*. Best for large lists.

## Save

Click **Save configuration** on the settings form. Your sending Views are ready
to use as soon as the *Send email* field is present and the operator has the
**mass mailing with views_send** permission.
