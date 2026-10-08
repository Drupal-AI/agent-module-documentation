# AI Translate Plus — manual setup guide

**AI Translate Plus** (`ai_translate_plus`) extends the **AI Translate** module
with finer control over how AI translates your content. Two things it adds:
**per-bundle translation prompts per language** — so you can give the model
different instructions for, say, a Product content type versus a Blog article,
and tailor them for each target language — and the ability to **disable
translation for selected fields**, so fields you never want machine-translated
are left alone.

It depends on the **AI** and **AI Translate** modules and provides its own
permissions to control who may manage these prompt and field settings.

The data-handling point is the usual one for AI translation: content is **sent
to the configured AI provider** to be translated — including drafts — so confirm
that egress is acceptable. Credentials for the provider live in the AI module as
secrets (a Key entity or an environment variable), never in plain config. Beyond
its own permission, the module has no access-control role. Note the release is a
beta (`1.0.0-beta1`) and it targets Drupal 11 only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside AI and AI Translate.

## Where it lives in the admin menu

AI Translate Plus builds on the AI Translate configuration under
**Configuration → AI** (`/admin/config/ai`) rather than adding an unrelated
admin area. That is where you set the per-entity-type/bundle prompts (per
language) and mark which fields should be excluded from translation. Grant the
module's permission to the roles that should manage these settings.

## How to use it

1. Configure an AI provider in the AI module (credentials stored as secrets) and
   set up AI Translate.
2. For each entity type/bundle you translate, write the translation **prompt**
   you want the model to follow, and set a per-language variant where the
   instruction should differ by target language.
3. Mark any fields that should **not** be translated so the model leaves them
   untouched.
4. Translate content as usual through AI Translate. Because content — including
   drafts — is sent to the provider, confirm the egress is acceptable and review
   the output before publishing.
