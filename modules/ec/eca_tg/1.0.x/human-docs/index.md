# ECA Telegram — manual setup guide

**ECA Telegram** (`eca_tg`) adds an ECA action for **sending messages to
Telegram**, so your no‑code [ECA](https://www.drupal.org/project/eca)
automations can push notifications to a Telegram chat or channel (via a Telegram
bot) whenever an event fires — for example, alerting a team channel when content
is published or a form is submitted.

Like other ECA integration modules, it has no settings form of its own. It
contributes a Telegram action that appears in the ECA model editor; you configure
the destination and message inside the model.

Sending to Telegram requires a **bot token** from Telegram's BotFather. That
token is a **secret** — treat it like a password. Don't paste it into exported
configuration or commit it to version control; store it in an environment
variable (and, ideally, a Key entity) as described in the installation guide.
Keep the connection over HTTPS, and be mindful that anything you send leaves your
site for an external chat service — avoid sending sensitive data. The module has
no access‑control role of its own. It depends on ECA and supports Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and store the Telegram bot token securely.

There is **no configuration page** for this module. It adds a Telegram action you
use inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA Telegram adds no admin page of its own. You use it from the **ECA** model
editor (**Administration → Configuration → Workflow → ECA**), where its Telegram
action becomes available when you build or edit a model.

## How to use it

1. In Telegram, create a bot with **@BotFather** and note the **bot token**. Find
   the **chat id** of the chat or channel you want to post to. Store the token as
   a secret (see [Installation](installation/index.md)).
2. Open the ECA model editor and create or edit a model.
3. Add an event to trigger the model, add any conditions you need, then add this
   module's **Telegram** action and set the destination chat and message — you can
   template the message with tokens from the triggering context.
4. Save and enable the model. Keep sensitive content out of the messages, since
   they are delivered to an external service.
