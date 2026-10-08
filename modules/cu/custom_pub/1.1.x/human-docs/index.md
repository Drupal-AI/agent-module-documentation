# Custom Publishing Options — manual setup guide

**Custom Publishing Options** (`custom_pub`) lets you define your own per-node
publishing states, beyond core's built-in Published, Promoted, and Sticky. Each option
you create — "Archived", "Featured", "Approved by legal", "Show in newsletter" — adds a
checkbox to the node add/edit form and, because it is a real node field, becomes
available in Views as a field you can filter and sort on.

You manage the options from an admin collection page, where each option is a small
configuration entity with a machine name, a label, and a description. When you create
one, the module automatically installs a boolean field on the `node` entity named
after the option, so every content type instantly gains the new checkbox. Delete the
option and the field is removed again. Because the values are stored as ordinary node
fields, they also show up in JSON:API/REST responses and can be set programmatically
or in bulk.

Access is granular. Each option gets its own permission ("Can set node publish state
to …") controlling whether that checkbox is shown to a given role, plus there is an
"administer custom publishing options" permission for managing the option definitions
themselves. The module also ships a bulk **action** so you can set an option across
many nodes at once from a View or the content overview, a Rules action (if Rules is
installed), and a Drupal 7 migration source.

One thing worth knowing: your custom options are gated only by their own per-option
permission, but to *also* see core's own status/promote/sticky checkboxes a role still
needs the core "administer nodes" permission (or the Override Node Options module).

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the config-entity shape and the action plugin — read the
sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — create and manage publishing options,
   the permissions involved, and bulk-setting an option.

## Where it lives in the admin menu

The options collection sits at **Configuration → Content authoring → Custom Publishing
Options** (`/admin/config/content/custom_publishing_option`). The checkboxes it creates
appear on the node add/edit form (either under a "Custom Publish Options" group or,
optionally, alongside core's Promotion options).
