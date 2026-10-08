# Configuration

The base **Parade** module has **no settings form of its own**. What people think
of as "configuring Parade" is really two separate activities:

1. **Building your content model** — creating Paragraph types and choosing Parade's
   widgets and formatters on their form and display settings. That work is
   described in [How to use it](../index.md#how-to-use-it) on the overview page,
   and it happens under **Structure → Paragraphs types**, not on a Parade settings
   screen.
2. **The optional submodule admin pages** — only the `parade_demo` and
   `parade_pack` submodules add pages under **Configuration → Content**. Those are
   covered below.

If you have not enabled the submodules, there is nothing on this page you need to
open — Parade works from the content model alone.

## Parade Demo settings

Available only when the `parade_demo` submodule is enabled.

- **Where:** **Configuration → Content → Parade demo**
  (`/admin/config/content/parade_demo`).
- **Who:** users with the **Administer site configuration** permission.

This page controls the demo‑content feature — the sample pages and components
`parade_demo` provides so you can see Parade's building blocks assembled into real
sections. Use it on a scratch or staging site to explore the toolkit; you would
not normally leave demo content on a production site.

## Parade Pack settings

Available only when the `parade_pack` submodule is enabled.

- **Where:** **Configuration → Content → Parade pack**
  (`/admin/config/content/parade_pack`).
- **Who:** users with the **Administer site configuration** permission.

This page exposes the extra feature settings bundled in the `parade_pack`
submodule. Enable it only if you want the additional features it provides on top of
the base module.

## Conditional fields

The `parade_conditional_field` submodule does not add a central settings page.
Instead you manage conditional fields per Paragraph type at
`/admin/structure/paragraphs_type/<type>/parade-conditional-fields/add`, which
requires the **Administer paragraph types** permission. Use it to tie a Paragraph's
view mode to layout and colour‑scheme classes so editors can pick a preset look
without being able to break your corporate style guide.

## Save

Each submodule page has its own **Save configuration** button; your changes take
effect once saved and the cache is rebuilt if prompted.
