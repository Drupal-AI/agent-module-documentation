# Dual Path Image Save — manual setup guide

**Dual Path Image Save** (`dual_path_image_save`) copies the files uploaded to
selected image fields into a second, custom directory every time a node is saved —
while leaving the original upload exactly where core put it. You end up with two
copies of the same image: the normal one Drupal manages, and a mirror in a folder
you choose.

The classic reason to want this is visibility. If an image field stores its files
in a **private** folder, those files are not directly reachable by the public web
server, so the image can appear "missing" in contexts that expect a public URL.
Point Dual Path Image Save at a **public** destination and it quietly keeps a
public copy alongside the private original. It's equally handy for feeding an
external process that watches a particular directory, or for standardising where
certain assets land across content types.

Nothing happens until you tell the module which fields to mirror, so there are two
small setup steps: list the target image fields on the module's settings page, then
set a custom destination path on each of those fields. The module depends on core's
**Image**, **Views**, and **Field** modules, and it also ships a small Views field
handler so the dual‑path image can be surfaced in a view.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — list the fields to mirror and set each
   field's custom destination path.

## Where it lives in the admin menu

The module's settings page sits at **Configuration → Media → Dual Path Image Save**
(`/admin/config/media/dual-path-image-save`), where you list the image fields to
mirror. The per‑field destination path is then set on each individual field's
settings form under **Structure → Content types → *(type)* → Manage fields**. See
[Configuration](configuration/index.md) for both steps.
