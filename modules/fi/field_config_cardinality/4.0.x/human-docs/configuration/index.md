# Configuration

This module has no settings page of its own. You set the cardinality override **per
field instance**, right on the field's edit form, and the choice is saved as part of
that field's configuration.

## Before you start: the storage limit rule

Cardinality on the **field storage** (set once, shared by all bundles) is the ceiling.
A per-instance override can only go **lower than or equal to** the storage limit — the
module never raises a storage's cap. So:

- If the storage is **Unlimited**, you can set any positive number (or Unlimited) on an
  instance.
- If the storage is limited to **N**, an instance can be limited to N or fewer, but not
  more.

If you need an instance to hold more values than the storage currently allows, raise
the storage cardinality first (on the field's storage settings), then set the
per-instance override.

## Set a per-instance cardinality

1. Go to the field instance you want to override, for example **Structure → Content
   types → (type) → Manage fields**, then **Edit** on your field.
2. On the field edit form, find the **"Allowed number of values (Cardinality
   Instance)"** fieldset.
3. Choose the limit for this bundle:
   - **Limited** — then enter the number of values allowed on this instance.
   - **Unlimited** — offered only when the storage itself is unlimited.
   Leave it unset to fall back to the storage's cardinality (no override).
4. Save the field.

That's all it takes: on the Article bundle you might set this shared field to
Unlimited, and on the Page bundle set it to 1 — same field storage, different limits.

## Optional: custom "empty label" text

The fieldset also offers a **"Use Cardinality Empty label config"** option. Tick it to
reveal an **"Empty label options (Cardinality Instance)"** fieldset where you can supply
your own placeholder/empty text for three situations:

- **Unlimited, not required**
- **Limited, not required**
- **Limited, required**

Leave the option unticked to use the default labels.

## What the limit actually does in the form

The stored value is just configuration — the real capping happens in the widget when
the edit form renders. The module:

- caps the number of value rows to your instance limit,
- removes the extra **Add more** button once the limit is reached,
- swaps several core widgets for cardinality-aware versions (media library, image,
  entity-reference autocomplete),
- hides over-limit file inputs on a multi-upload `managed_file` widget, and
- turns a single-value checkbox list into radio buttons.

So editors on that bundle simply see a field that behaves as if its own cardinality had
always been the instance limit.

## Deploying the override

The override is stored as a third-party setting on the field's config entity
(`field.field.<entity>.<bundle>.<field>` → `field_config_cardinality`), so you can
export and deploy it across environments with Drupal's configuration sync, or script it
in an update hook. For the exact keys and the widget internals, see the
[`agent/`](../agent/start.md) docs.
