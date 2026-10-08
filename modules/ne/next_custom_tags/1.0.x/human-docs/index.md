# Next Custom Tags — manual setup guide

**Next Custom Tags** (`next_custom_tags`) is a developer tool for decoupled
Drupal sites that use a **Next.js** front end. It gives you fine‑grained control
over Next.js tag‑based caching by letting you define **custom cache‑tag plugins**
for any Drupal entity type. When an editor creates, updates, or deletes content,
the module extracts the relevant tags and asks your Next.js site to revalidate
only the affected pages — no full‑site rebuild required.

The plugin system is entity‑agnostic: you can write plugins for nodes, blocks,
menus, webforms, custom entities, or anything else, and the tags they emit are
whatever your logic decides — not just entity IDs. That means you can mint
arbitrary tags that match your front‑end components, such as `collection:featured`,
`menu:main-footer`, or `taxonomy:term:123`. The module talks to the revalidate URL
from your Next.js site configuration, so it builds on the **Next.js** (`next`)
module, which is a required dependency.

Beyond automatic revalidation on content change, it offers a manual revalidation
screen for triggering specific tags on demand, and a place to register "custom
tag definitions" — tags that live outside of entities (for example global
settings tags) that you may want to revalidate by hand. Three optional submodules
add ready‑made extraction for common entity types: **Block**
(`next_custom_tags_block`), **Menu** (`next_custom_tags_menu`, so navigation
updates immediately when menu links change), and **Webform**
(`next_custom_tags_webform`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the Next.js dependency, and pick the submodules you need.

The module does have administrative screens (described below), but its behaviour
is driven by the plugins you enable and the Next.js site configuration it reads —
so setup is covered here in "How to use it" rather than in a separate
configuration guide.

## Where it lives in the admin menu

The module provides three administrative interfaces, all under **Configuration →
Web Services → Next Custom Tags**:

- **Plugin configuration** (`/admin/config/services/next-custom-tags/plugin-settings`)
  — enable or disable plugins per Next.js site, preview the example tags each
  plugin would generate, and configure manual revalidation options.
- **Manual revalidation** (`/admin/config/services/next-custom-tags/revalidate`)
  — trigger revalidation for specific tags on demand.
- **Custom tag definitions** (`/admin/config/services/next-custom-tags/custom-tags`)
  — register tags that are not automatically extracted from entities but may need
  manual revalidation.

## How to use it

1. **Configure** — on the plugin configuration screen, enable the plugins for the
   entity types you want to track (or enable one of the submodules to get block,
   menu, or webform extraction out of the box).
2. **Edit content** — when an editor saves a tracked entity, the module invokes
   the relevant plugin.
3. **Extract** — the plugin generates cache tags from whatever logic you defined.
4. **Revalidate** — the module sends a revalidation request to your Next.js site
   for exactly those tags, keeping the front end fresh without a full rebuild.

Use the settings form's example‑tag preview to confirm precisely what will be
sent to Next.js before you rely on it in production.
