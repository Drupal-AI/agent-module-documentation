# Simple Image Rotate — manual setup guide

**Simple Image Rotate** (`simple_image_rotate`) adds a small **"Rotate image
clockwise"** button next to each uploaded picture on entity edit forms. An editor
can straighten a sideways phone photo right in the node (or media, user, term…)
form, and when the entity is saved the rotation is applied to the actual image
file — no external image editor, no touching the filesystem.

It's a lightweight way to cut down on "my picture is sideways" support requests.
The button works on any core **image** field, on any entity type, and on
multi‑value fields each image gets its own button. Because rotation rewrites the
source file, any image styles you use simply regenerate from the corrected
original.

Under the hood the rotation preview happens in the browser; on save Drupal
rotates the real file using your configured image toolkit (GD, etc.), saves it
under a new name with an `_r1`, `_r2`, … suffix, updates the stored
width/height/filesize, and resets the angle. That last step makes the operation
idempotent — an already‑rotated image won't be re‑rotated on the next save. It
depends only on core's **Image** module.

There is **no settings page**. Turning rotation on takes just two things: a
per‑field checkbox (**"Enable rotate function"**) and the **Rotate images**
permission. Both are covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## Where it lives in the admin menu

The module has no configuration page of its own. You switch rotation on **per
image field** from that field's settings, and you control who can use it from the
core permissions screen:

- **Field setting:** on the image field's edit form (**Structure → Content types
  → [your type] → Manage fields → [image field] → Edit**) tick **"Enable rotate
  function"**. This is stored as a third‑party setting on the field, so it's
  included when you export configuration.
- **Permission:** at **People → Permissions** (`/admin/people/permissions`) grant
  **Rotate images** to the roles that should see the button (for example editors
  or photographers).

## How to use it

1. Enable rotation on an image field: edit the field (**Manage fields → [image
   field] → Edit**), tick **"Enable rotate function"**, and save.
2. Make sure the relevant roles have the **Rotate images** permission. The button
   only appears when *both* the field setting is on *and* the user has this
   permission.
3. Edit a piece of content that uses the field. Next to each uploaded image
   you'll see a **Rotate image clockwise** button — click it to spin the preview
   90° at a time.
4. **Save** the entity. The rotation is written to the actual file (stored under a
   new `_rN` name), and the image's dimensions are updated to match.

This gives you basic image editing without pulling in a heavy media‑library
integration — ideal for correcting orientation at upload time.
