# AI Dropsolid — manual setup guide

**AI Dropsolid** (`ai_dropsolid`) is a convenience bundle for sites hosted on
the Dropsolid platform. It ships preconfigured AI provider settings for
Dropsolid's own AI provider, so instead of wiring the provider up from scratch
you enable this module and get a ready-made configuration to build on.

It is a thin integration layer: it depends on the Dropsolid AI provider module
(`ai_provider_dropsolidai`) and, through it, on the Drupal AI module. Once
enabled, AI features across your site can use the Dropsolid provider like any
other AI provider.

As with every AI provider, using it means your prompts and content are sent to
the provider's service (an external egress) — confirm that is acceptable for the
content you send. The provider's credentials are a secret and are stored through
the AI module's Key configuration, never pasted into plain settings.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Dropsolid provider dependency, and store the credentials
   securely.

## Where it lives in the admin menu

AI Dropsolid has no settings page of its own (`configure` is null). Its job is
to supply preconfigured provider settings; you manage the AI provider itself
through the AI module's provider configuration.

## How to use it

1. Store your Dropsolid AI credentials in an environment variable and reference
   them through a **Key** entity (see [Installation](installation/index.md)).
2. Enable the module to load the preconfigured Dropsolid provider settings.
3. In your AI-powered features (chat, automators, and so on) select the
   Dropsolid provider as you would any other AI provider.

Because prompts and content are sent to Dropsolid's service, treat this as an
external transfer and handle confidential material deliberately.
