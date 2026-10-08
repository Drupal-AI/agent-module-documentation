# Automatic Entity Labels — manual setup guide

**Automatic Entity Labels** (`auto_entitylabel`) builds an entity's label — a node title, a comment subject, a taxonomy term name, a media name, or the label of a custom entity — automatically from a token pattern, and can hide the label field on the edit form so editors never type a title by hand. When a label is redundant, or is better derived from other fields on the content, this module takes the chore off your editors' hands and keeps titles consistent across the site.

Configuration is **per entity bundle**, not global. For every eligible bundle the module adds an **Automatic label** tab to that bundle's configuration page — for example, an Article content type gets one at `/admin/structure/types/manage/article/auto-label`. On that tab you pick one of four behaviors (disabled, generate‑and‑hide, generate‑only‑when‑empty, or prefill), write the token pattern that produces the label (such as `[node:field_first] [node:field_last]`), and choose a few options for stripping characters, preserving existing titles, and when the label is generated. You can also kick off a batch "re‑save" to apply a new pattern to content that already exists.

The module has no dependencies and enables cleanly on its own, but it does nothing visible until you configure at least one bundle. It has no central settings page — you always work bundle by bundle. Installing the **Token** module is recommended (it is only *suggested*, not required): it adds a token‑browser widget so you can pick tokens for your pattern instead of typing them from memory. Access is delegated with one permission per entity type, so you can let a role configure automatic labels for media, say, but not for nodes.

This guide is written for a **human** clicking through the admin UI. If you want terse, token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it.
2. [Configuration](configuration/index.md) — the per‑bundle Automatic label tab, field by field.

## Where it lives in the admin menu

Automatic Entity Labels has **no single settings page**. Instead, its configuration surfaces as an **Automatic label** tab on each entity bundle's edit page. For content types that means **Structure → Content types → (your type) → Manage fields**‑area tabs, where you'll find the **Automatic label** tab — e.g. `/admin/structure/types/manage/article/auto-label`. The same tab appears on taxonomy vocabularies, media types, comment types, and any other bundle that qualifies. See [Configuration](configuration/index.md) for a walk‑through of the form.
