# Alexa — manual setup guide

**Alexa** (`alexa`) connects a Drupal site to Amazon Alexa. It gives your site a
web address that Amazon can post to whenever someone talks to your Alexa "skill",
checks that each incoming request is genuinely from Amazon, and then hands the
request off to other code so developers can build the skill's behaviour without
having to worry about the security checks themselves.

Concretely, the module exposes a callback at `/alexa/callback`. When a request
arrives it validates the request signature and certificate (using the `alexa-app`
PHP library), confirms it matches the Application ID you configured, and then
dispatches a Symfony event (`alexaevent.request`) that skill-handler code can
listen for. Request verification is built in, so the endpoint authenticates
itself by signature — you do not add your own access rules to it.

Two optional submodules ship with the project: **alexa_demo** and
**alexa_chatbot_api**, which demonstrate how to build integrations on top of the
event. On its own, the base module is plumbing: it receives, validates, and
dispatches — the actual voice responses come from handler code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the `alexa-app` library requirement.
2. [Configuration](configuration/index.md) — enter your Alexa Application ID and
   understand the callback URL.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Alexa**
(`/admin/config/services/alexa`), gated by the **Administer Alexa configuration**
permission. The callback Amazon talks to is `/alexa/callback`.

## How to use it

Enable the module, set your Application ID on the settings form, and point your
Amazon Alexa skill's endpoint at `https://yoursite/alexa/callback`. Then write
(or enable a submodule that provides) an event subscriber for
`alexaevent.request` to produce the spoken responses.
