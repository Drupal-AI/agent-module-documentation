# Field Config Cardinality — manual setup guide

**Field Config Cardinality** (`field_config_cardinality`) lets you set a field's
**cardinality — the allowed number of values — per field instance (per bundle)**,
instead of only once for the shared field storage. In Drupal, cardinality is normally a
property of the field *storage*, so every content type that reuses the same field is
stuck with the same limit. This module breaks that tie: one shared field can be
single-value on Pages and multi-value on Articles, so you no longer have to create
duplicate fields (and duplicate database tables) just to vary the limit between
bundles.

It works by adding an **"Allowed number of values (Cardinality Instance)"** section to
each field instance's edit form. You choose **Limited** (with a number) or
**Unlimited**, and the module stores that as a per-instance override — with one rule:
the instance limit can only be **lower than or equal to** the storage's cardinality (if
the storage is unlimited, any per-instance number is allowed). At form-render time the
module actually enforces the limit in the widget: it caps the number of value rows,
removes the extra "Add more" button, and adapts several core widgets (media library,
image, entity-reference autocomplete) — even turning a single-value checkbox list into
radio buttons. It also offers optional custom "empty label" text per
cardinality/required combination.

There is **no central settings page, permission, or Drush command** — the override
lives on the individual field, so it exports and deploys like any other field setting.
The module has no dependencies beyond Drupal core, and it optionally adds a
cardinality-aware Inline Entity Form (simple) widget when the **Inline Entity Form**
module is installed.

This guide is written for a **human** configuring a field in the admin UI. If you want
terse, token-cheap references for an AI coding agent — the third-party settings keys,
the storage-limit rule, and the widget swaps — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set a per-instance cardinality on a
   field, field by field.

## Where it lives in the admin menu

There is no global configuration page. The module's **"Allowed number of values
(Cardinality Instance)"** fieldset appears on the edit form of a field instance — for
example under **Structure → Content types → (type) → Manage fields → (your field) →
Edit**.
