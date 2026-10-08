# Smart Trim — manual setup guide

**Smart Trim** (`smart_trim`) provides a **"Smart trimmed"** field formatter — a
more robust, drop-in replacement for Drupal core's "Summary or trimmed" text
formatter. Where the core formatter gives you only limited control, Smart Trim
lets you shorten text precisely for teasers, cards, search results, and listings,
and can append a customizable "Read more" link.

You attach it as the display formatter on `text`, `text_long`,
`text_with_summary`, `string`, or `string_long` fields in a view mode, then set a
trim length measured in **characters or words**. Its truncation is **HTML-aware**:
it closes any tags it cuts through so the markup stays valid, and it can
optionally strip HTML entirely for a plain-text excerpt, honor a zero-length trim,
or run token replacement before trimming. A configurable suffix (such as an
ellipsis) and an optional "More" link — with its own text, CSS class, aria-label,
target, and "only when trimmed" behavior — round out the output. For
`text_with_summary` fields you choose whether an existing summary is used
verbatim, trimmed, or ignored.

Smart Trim has **no admin settings page of its own** — all of its options live in
the formatter settings on a field's **Manage display** screen, and they're stored
in the display configuration, so they export and deploy like any other display
config. Output renders through a themeable `smart-trim.html.twig` template with
granular per-entity/bundle/field theme suggestions, and a
`hook_smart_trim_link_modify` hook lets modules rewrite the read-more link. The
module requires the **Token** module (`drupal/token`) and core's `field`,
`filter`, and `text`. It ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the "Smart trimmed" formatter's
   settings, field by field, on the Manage display screen.

## Where it lives in the admin menu

Smart Trim adds **no top-level menu item and no global settings form**. It
surfaces as a formatter option wherever you configure how a field renders:
**Structure → Content types → *(your type)* → Manage display**
(`/admin/structure/types/manage/<bundle>/display`), for each view mode. Choose
**"Smart trimmed"** as the format for a supported field, then click the gear icon
to configure it. See [Configuration](configuration/index.md) for every setting.
