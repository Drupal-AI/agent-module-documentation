# Configuration

All of Entity Usage's behavior is controlled from a single settings form, stored in
the `entity_usage.settings` config object.

## Open the settings form

1. Log in as a user who can administer the site configuration.
2. Go to **Configuration → Content authoring → Entity Usage Settings**
   (`/admin/config/entity-usage/settings`).

## What to track

- **Source entity types** — the entity types Entity Usage watches for outgoing
  references. By default this is all content entities except files and users.
  Narrow it (e.g. to nodes only) if you don't need to track everything.
- **Target entity types** — the entity types that get *recorded* when something
  references them. Restricting targets keeps the usage table smaller and faster.
- **Tracking method plugins** — which detection methods are active (entity
  reference, link fields, HTML links in text, embeds, inline images, Layout Builder
  blocks, and so on). All are enabled by default; disable any you don't need for
  performance.
- **Track referencing base fields** — off by default; enable it if you also need to
  track references made through base fields rather than only configurable fields.

## Where usage is shown

- **Usage local task (tab) entity types** — the entity types that get a **Usage**
  tab on their canonical page. **None** are enabled by default, so this is usually
  the first thing you'll want to turn on (for example, enable it for media and
  nodes so editors can see where items are used).
- **Rows per page** — how many rows the usage report shows per page (default 25).

## Protect content from accidental breakage

- **Edit warning** — choose the entity types that should display a warning on their
  **edit** form when the entity is still referenced somewhere.
- **Delete warning** — choose the entity types (and, if needed, the specific form
  classes) that should display a warning on their **delete** form when the entity
  is still referenced.

## Resolving links to local entities

- **Site domains** — the domains that count as "this site," so plain HTML links and
  link-field URLs pointing at those domains resolve to local entities and get
  tracked.

## Save and rebuild

Click **Save configuration**. Because tracking only happens when a source entity is
saved, **rebuild the usage table** after changing tracked types or plugins — use the
batch-update form provided by the module, or run:

```bash
drush entity-usage:recreate
```

This erases and regenerates all usage statistics so existing content is reflected
with your new settings.
