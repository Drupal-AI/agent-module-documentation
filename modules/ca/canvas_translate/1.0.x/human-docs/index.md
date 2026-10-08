# Canvas Translate — manual setup guide

**Canvas Translate** (`canvas_translate`) adds content translation directly to
**Canvas**, Drupal's Experience Builder page builder. It is delivered as a Canvas
page extension, so editors translate Canvas content in place, within the same
authoring flow they use to build pages — rather than juggling a separate
translation screen.

It builds on core **Content Translation** and **Language**, and it declares its
own permissions. An optional submodule, **Canvas Translate AI**
(`canvas_translate_ai`), adds AI‑assisted translation by connecting to the AI
module's configured provider. It depends on **Canvas** (version 1.8 or newer) and
targets Drupal 11.3.

Please note the data‑handling implication of the AI option: if you enable the AI
submodule, the content being translated is sent to the configured AI provider —
that is, it leaves your site. Treat that content accordingly, and handle the AI
provider's credentials as **secrets**: store an API key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --ai-api-key=<value>` then
`ddev restart`) and reference it through a Key entity rather than pasting it into
exported configuration or committing it. Without the AI submodule, translation
stays entirely in‑house. Either way, translation respects your normal
content‑translation access rules.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and the optional AI submodule.

## Where it lives in the admin menu

Canvas Translate adds no settings form of its own — it works as an extension
inside the Canvas editor. It declares permissions, so review them at **People →
Permissions** (`/admin/people/permissions`) and grant translation access to the
appropriate roles. Site languages and translatable entities are configured with
core Language and Content Translation as usual.

## How to use it

Set up multilingual on your site (enable and configure **Language** and **Content
Translation**), then enable this module. Editors can then translate Canvas content
in place from within the builder. If you want AI‑assisted translation, also enable
the **Canvas Translate AI** submodule and configure the AI provider and its
credentials as described above — remembering that content sent for AI translation
leaves the site.
