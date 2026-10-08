<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Convert Bundles has **no settings page** — you never configure it, you run it.
This page covers the permissions you need and the three ways to start a
conversion.

## Permissions first

Grant permissions at **People → Permissions**:

- **Administer convert_bundles** — required for the whole-bundle conversion form
  and the conversion wizard. This is a restricted, powerful permission (it can
  rewrite large amounts of content), so grant it only to trusted roles.
- **`convert <entity type> bundle`** — a per-entity-type permission (for example
  *Content: Convert bundle*, *Taxonomy term: Convert bundle*). Grant one of these
  to let a role convert a specific entity type's bundles from the per-entity tab
  without the blanket administer permission. For example:
  `drush role:perm:add editor 'convert node bundle'`.

## Three ways to run a conversion

All three lead to the same field-mapping wizard.

### 1. Convert a single entity

Open the entity (for example a node) and click its **Convert Bundle** tab. This
requires the matching `convert <entity type> bundle` permission.

### 2. Convert a selection (bulk action)

Go to **Content** (`/admin/content`) — or any Views Bulk Operations view — tick
the rows you want, choose the **Convert … Entity Bundles** action from the
dropdown, and click **Apply**.

### 3. Convert a whole bundle

Go to **Configuration → Content authoring → Convert Bundles**
(`/admin/config/content/convert_bundles`). Pick an entity type and a source
bundle to load every entity of that bundle for conversion.

## The wizard steps

1. **Choose the target bundle** — the bundle you are converting to.
2. **Map the fields** — for each source field, choose a target field to copy its
   value into. Only fields whose data type is compatible are offered, plus two
   special choices:
   - **Remove** — discard the source field's value.
   - **Append to body** — append the value (labelled) to the target's body field;
     a media reference is appended as a `<drupal-media>` embed.
3. **Convert** — the change runs as a batch process. On revisionable entities a
   new revision is created with a "Converted from X to Y" log message.

## Doing it in code

There is no Drush command. Developers can call the static helpers on the module's
`ConvertBundles` class, and can adjust each converted entity just before it is
saved with `hook_convert_bundle_alter()`. See the
[`agent/`](../agent/start.md) docs for details.

> **Reminder:** back up your database before converting, and test on a copy first
> — the conversion rewrites entity data directly.
