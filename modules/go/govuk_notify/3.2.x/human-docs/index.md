# GOV Notify Integration — manual setup guide

**GOV Notify Integration** (`govuk_notify`) lets your Drupal site send **email,
SMS and even printed letters** through **GOV.UK Notify** — the shared messaging
platform built by the UK Government Digital Service — and its open‑source
equivalents adopted by the Canadian and Australian governments. You send both
regular and system messages, using the Notify **templates** you have already set
up in your Notify account.

For a public body, Notify is usually not so much a choice as the default: it is
already procured and assessed, and it handles the parts of messaging that are hard
to do well and expensive to get wrong. The message wording lives in Notify rather
than in your site, so the text of a statutory letter is edited and versioned by
the people responsible for it. Delivery is reported per message, so a question
like "did the applicant actually receive the decision?" has an answer. And because
it can send **actual printed post**, a service that cannot assume every user is
online does not have to build a print pipeline itself.

Three things are worth understanding before you deploy it, and they all revolve
around the **API key**. Notify issues keys with different **scopes** — live, test
and team‑only — and the scope genuinely matters: a live key used in a
non‑production environment is exactly how a test run ends up sending real letters
to real people, which is a recognisable incident in this sector rather than a
hypothetical. The **personalisation** you pass (names, addresses, reference
numbers, case details) is real personal data, so the integration is a processing
activity to record, not just a technical detail. And because **the template is the
message**, your site's job is only to supply the right variables — hard‑coding
message text defeats the whole arrangement Notify was adopted for.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the Views backend submodule.
2. [Configuration](configuration/index.md) — connect to Notify with an API key
   (stored securely), and understand key scopes, templates and personalisation.

## Where it lives in the admin menu

The module adds a settings page for entering your Notify API key and connection
details, protected by the **administer GOV.UK Notify** permission
(`administrator gov uk notify`). See [Configuration](configuration/index.md) for
what to enter and how to store the key safely. Official installation notes are
also maintained on drupal.org at
<https://www.drupal.org/docs/8/modules/govuk-notify/installation>.
