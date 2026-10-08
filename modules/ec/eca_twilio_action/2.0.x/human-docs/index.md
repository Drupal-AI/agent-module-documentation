# ECA Twilio Action — manual setup guide

**ECA Twilio Action** (`eca_twilio_action`) adds a single ECA action — **Send
Twilio SMS** — so your no‑code [ECA](https://www.drupal.org/project/eca) models
can send text messages through the
[Twilio](https://www.drupal.org/project/twilio) module as part of any
event/condition/action workflow. It's ideal for SMS notifications, alerts, order
or booking confirmations, or reminders driven by your site's business rules.

The action exposes two fields — a **phone number** and a **message body** — and
both support ECA token replacement, so you can template the recipient and the
text from the triggering entity or context (for example, a user's phone number
and name). At run time it decodes HTML entities in the message and hands the
number and message to the Twilio module's SMS service. If sending fails, the
error is caught and logged to the `eca_twilio_action` log channel rather than
thrown, so an ECA model keeps running — check that log channel if you're not sure
a message went out.

Crucially, **this module does not hold your Twilio credentials**. Delivery, the
account SID, the auth token, and the from‑number all come from the separate Twilio
contrib module, which you configure once. Those credentials are secrets — see the
installation guide for handling them safely. ECA Twilio Action has no routes or
permissions of its own; it can only be used from within ECA models, and editing
ECA models is itself an administrative capability. It depends on ECA, Twilio and
Token, and supports Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside ECA, Twilio and Token, and configure Twilio credentials
   securely.

There is **no configuration page** for this module itself. It adds one action you
use inside ECA models; the credentials live in the Twilio module. See "How to use
it" below.

## Where it lives in the admin menu

ECA Twilio Action adds no admin page of its own. You use it from the **ECA** model
editor (**Administration → Configuration → Workflow → ECA**), where the **Send
Twilio SMS** action becomes available when you build or edit a model. Twilio
credentials are configured on the Twilio module's own settings page.

## How to use it

1. Enable and configure the **Twilio** module with your account SID, auth token
   and from‑number (see [Installation](installation/index.md) for handling those
   secrets).
2. Open the ECA model editor and create or edit a model.
3. Add an event to trigger the model, add any conditions you need, then add the
   **Send Twilio SMS** action.
4. Fill in the **Phone Number** and **Message** fields, using tokens where you
   want dynamic values (for example, `[user:field_phone]` for the number and a
   templated body).
5. Save and enable the model. If messages don't arrive, check the
   `eca_twilio_action` log channel — send failures are logged there rather than
   surfaced as errors.
