# AI Featured Image — manual setup guide

**AI Featured Image** (`ai_featured_image`) automatically generates a featured
image for a node using AI image generation. When a piece of content doesn't have
a suitable hero image, the module can create one with an AI image provider and
attach it as the node's featured image — so content that would otherwise ship
without a picture gets a generated one.

It works with core's Node and File systems: the generated image is saved as a
managed file and used as the node's featured/hero image. The actual generation
happens through the AI module's image-generation provider, which means the
prompt (and any content used to build it) is sent to that provider, and each
generation may incur provider cost.

Because image generation is a paid, external call, treat it accordingly: confirm
the data egress is acceptable, keep the provider's API key as a secret in the AI
module's Key configuration, and be mindful that generating many images at once
adds up.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

AI Featured Image has no standalone settings route (`configure` is null). It adds
its image-generation capability to the node workflow, gated by its own
permission, and generates through whatever image provider you have configured in
the AI module.

## How to use it

1. Make sure the AI module has an image-generation provider configured, with its
   API key stored as a **Key** entity (never in plain config).
2. Grant the module's permission to the users who should be able to generate
   featured images.
3. When a node needs a featured image, use the module's generation action to
   have the AI create one; it is saved as a file and attached to the node.

Because each generation is a billable AI call, keep an eye on provider cost, and
review generated images before relying on them for published content.
