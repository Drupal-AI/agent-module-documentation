# Content Moderation Notifications — manual setup guide

**Content Moderation Notifications** (`content_moderation_notifications`) sends
emails when a moderated entity moves between workflow states — Draft → Needs
Review → Published, and so on. It extends Drupal core's **Content Moderation** and
**Workflows** so that, whenever content transitions, the right people hear about
it: the content's author, whole roles, ad‑hoc email addresses, or users pulled
from an entity‑reference field on the content itself.

You configure it by creating one or more **notification** entities at
**Configuration → Workflow → Content Moderation Notifications**. Each notification
is scoped to a single workflow and a chosen set of that workflow's transitions.
When a moderated entity is saved and its transition matches an enabled
notification, the module gathers the recipients, checks that role recipients
actually have permission to view the entity, and sends one message. All recipients
go on the **Bcc** header (so they can't see each other), and the visible "To" is
your site email address unless you choose to suppress it. The subject and body
support both Drupal **tokens** and inline **Twig**, and the body is run through a
text format's filters — so you can send plain or rich HTML mail and build dynamic
subject lines like `{{ entity.title }} needs review`.

The module adds three of its own tokens — workflow label, from‑state, and to‑state
— and provides a hook so other modules can adjust the recipient list or the
message before it's sent. It depends on core's **Content Moderation**, **Text**,
and **Workflows** modules; the **Token** module is an optional but recommended
enhancement for the token browser. A single permission gates who may create and
edit notifications.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the config entity
fields, services, tokens, and the mail‑data alter hook — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a notification, choose its
   workflow, transitions, and recipients, and write the subject and body.

## Where it lives in the admin menu

Notifications are managed at **Configuration → Workflow → Content Moderation
Notifications** (`/admin/config/workflow/notifications`). The permission that
gates this is on **People → Permissions**.

## How to use it

Make sure you have a content‑moderation workflow in place, then add a notification
for the transition you care about, pick who should be emailed, and write the
message. See [Configuration](configuration/index.md) for the field‑by‑field
walkthrough.
