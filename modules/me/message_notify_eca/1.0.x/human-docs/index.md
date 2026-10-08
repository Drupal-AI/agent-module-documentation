# Message Notify ECA — manual setup guide

**Message Notify ECA** (`message_notify_eca`) is a small bridge that exposes
[Message Notify](https://www.drupal.org/project/message_notify) as an action inside
[ECA](https://www.drupal.org/project/eca) — Drupal's no-code
Event‑Condition‑Action automation framework. With it, an ECA model can send a Message
Notify notification email as one of its steps, so you can automate "when *this*
happens, notify *that* person" without writing custom code.

The problem it solves is glue. Message Notify knows how to render and deliver a
Message to a recipient; ECA knows how to react to events and run conditional logic.
This module lets the two work together: you build the trigger and conditions visually
in ECA, and drop in the "send a Message Notify notification" action to do the
delivery. Typical uses are transactional notifications tied to content or workflow
events — a status change, a new submission, an approval — all configured by a site
builder rather than a developer.

There is nothing to configure in this module itself. It has no settings page: it
simply registers the action, which then appears in the ECA model editor. It depends
on both [ECA](https://www.drupal.org/project/eca) and
[Message Notify](https://www.drupal.org/project/message_notify), and requires Drupal
10.4 or 11.

Because the action sends email to recipients (email addresses are personal data) and
can be fired automatically by events, design your ECA models so that automated sends
respect consent and only reach intended recipients — an over-broad trigger can leak
message content to the wrong people.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and Message Notify.

There is **no configuration page** for this module — its one job is to make a "send
Message Notify notification" action available inside ECA.

## How to use it

After enabling the module, open the **ECA** model editor and build or edit a model:

1. Choose the **event** that should trigger the notification (for example, a content
   entity being saved).
2. Add any **conditions** that must hold.
3. Add the **Message Notify notification** action provided by this module, and
   configure which message/template to send and to whom.
4. Save the model. From then on, matching events send the notification automatically.
