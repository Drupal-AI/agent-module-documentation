# AI Image — manual setup guide

**AI Image** (`openai_image`, distributed as the Composer package
`drupal/openai_image_for_drupal`) lets content authors generate images from a
text prompt right where they're working — inside **image fields** and inside the
**CKEditor 5** rich‑text editor. An editor types a description, the module asks an
AI provider to generate a matching image, and the result is inserted into the
image field or the editor. It's a fast way to produce illustrations without
leaving the content form.

Rather than talking to OpenAI directly, AI Image builds on Drupal's **AI** module
and uses whichever image‑capable provider you've configured there. That means the
provider and API keys are managed centrally by the AI module (typically an
environment‑backed **Key** entity), and AI Image just requests generations
through it.

Two practical notes: each generation is a **paid API call**, so scope who can use
the feature and keep an eye on cost; and the images are produced by an external
service, so the usual data‑handling and licensing considerations for AI‑generated
imagery apply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the AI
   module, and enable it.

There is **no settings page of its own**. The AI provider and API key are
configured in the **AI** module — see below.

## Where its configuration lives

AI Image relies on the **AI** module for the connection to your image provider.
Set the provider and its API key (as a **Key** entity) in the AI module's
configuration under **Configuration → AI**; AI Image reuses that. There's no
separate credentials form in this module.

## How to use it

Once the AI module has an image‑capable provider configured, editors will see a
generate‑from‑prompt option on **image fields** and in the **CKEditor 5**
toolbar. Type a prompt, generate, and the image is inserted. Grant the feature to
trusted roles, since each generation costs money.
