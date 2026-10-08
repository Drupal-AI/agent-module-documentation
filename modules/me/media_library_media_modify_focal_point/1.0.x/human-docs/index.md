# Media Library Media Modify Focal Point — manual setup guide

**Media Library Media Modify Focal Point** (`media_library_media_modify_focal_point`)
is a small bridge module that adds **Focal Point** support to the modals provided by
the **Media Library Media Modify** module. It lets editors set an image's focal
point — the crop‑focus point that focal‑point image styles use — right inside the
media‑modify modal, instead of having to do it as a separate step elsewhere.

The reason it exists is practical: without this bridge, changes to the Focal Point
made inside a Media Library Media Modify modal wouldn't take effect when the modal
form is submitted. This module stores the global focal point setting for the media
when you save the modify modal, so the focal point you pick actually sticks.

It's an editorial convenience that affects how images are cropped; it does not
change media access in any way. It only makes sense installed **alongside** both the
*Media Library Media Modify* module and the *Focal Point* module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its companion modules.

There is **no settings form** for this module — it simply wires Focal Point into the
Media Modify modal once its companion modules are set up. How it fits into the
workflow is described below.

## How to use it

1. Make sure both the **Media Library Media Modify** module and the **Focal Point**
   module are installed and configured (see Installation), including a focal‑point
   image field on your image media and focal‑point image styles where you want them.
2. With this bridge module enabled, editors open the **Media Modify** modal from the
   Media Library and set the image's focal point there.
3. On submitting the modal, the focal point is stored globally for that media, so
   focal‑point‑based image styles crop around the point the editor chose.
