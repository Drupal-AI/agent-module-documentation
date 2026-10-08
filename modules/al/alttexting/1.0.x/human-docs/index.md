# AltTexting — manual setup guide

**AltTexting** (`alttexting`) uses an AI vision model to suggest alternative
(alt) text for the images in your media library. Writing good alt text by hand
for every image is one of the more tedious parts of accessibility work, and it
is often the first thing that gets skipped. AltTexting takes an image, sends it
to a configured AI provider, and hands back a suggested description you can use
as a starting point.

It builds on core **Media**, so it works with the images you already manage as
media items, and it adds its own permission so you can control who is allowed to
generate alt text. The goal is speed: it helps you clear an accessibility
backlog faster, not to remove humans from the loop.

Two things are worth understanding before you switch it on. First, generating a
suggestion **sends the image to an external AI provider** — think carefully
before using it on private or sensitive images, and make sure that egress is
acceptable for your site. Second, AI-generated descriptions can be wrong,
incomplete, or inappropriate, so every suggestion should be **reviewed by a
human** before it is saved as the real alt text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and connect an AI provider.

## How to use it

Once the module is enabled and an AI provider is configured (through Drupal's AI
ecosystem, with the provider's API key stored as a secret via a Key entity — not
in plain configuration), you can ask AltTexting to suggest alt text for a media
image. Grant the module's permission to the roles that should be allowed to do
this. Always read the suggestion it returns and edit it before saving — treat it
as a draft, not a final answer.
