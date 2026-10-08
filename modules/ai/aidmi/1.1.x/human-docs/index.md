# AIDmi — AI Describe My Image — manual setup guide

**AIDmi** (`aidmi`), short for "AI Describe My Image", generates accessible alt
text for images using an AI vision model. It reads the content of an image and
produces a 508‑compliant description, so editors can quickly add compliant alt
text for accessibility instead of writing every description by hand.

It builds on the AI module and uses an AI vision provider to do the work. That
means images are **sent to the configured AI provider** for description, which
carries the provider's per‑call cost, and the provider's API key is stored
securely through the **Key** module (backed by an environment variable) rather
than in plain configuration. Generation is gated by the
`generate aidmi accessibility` permission.

It improves accessibility and helps with Section 508 compliance by populating alt
attributes, but the output is a draft — review the generated descriptions for
accuracy before publishing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Alt‑text generation is offered where you work with images, gated by the
`generate aidmi accessibility` permission (set under **People → Permissions**).
The AI provider and its API key are configured in the **AI** module (with the key
stored via the Key module).

## How to use it

1. Make sure the **AI** module has a working **vision‑capable** provider and its
   API key is stored as a Key.
2. Enable AIDmi and grant `generate aidmi accessibility` to the editors who
   should generate alt text.
3. Generate a description for an image and review it for accuracy before saving.

> **Data egress:** images you describe are sent to your AI provider. Confirm this
> is acceptable for your content.
