# DLF AIM 3D Viewer — manual setup guide

**DLF AIM 3D Viewer** (`dlf_aim_3d_viewer`) embeds an interactive 3D model viewer
into your Drupal site so visitors can rotate, zoom and explore 3D assets — think
cultural‑heritage artefacts, scanned objects or product models — directly in the
browser. It was originally built to display 3D data as an extension for a WissKI
based repository, but it also works as a standalone integration in other
environments. The viewer is written in JavaScript on top of the **three.js**
library, with PHP/bash scripts handling server‑side operations.

It supports a wide range of 3D file formats out of the box — OBJ, DAE, FBX, PLY,
IFC, STL, XYZ, JSON, 3DS and glTF. It also ships a pre‑configured workflow that can
handle more formats and render thumbnails: when an uploaded file is in one of the
compression‑supported formats (obj, fbx, ply, dae, abc, blend, stl, wrl, x3d, glb,
gltf), it is compressed on the fly and converted to GLB, triggering automatic
rendering (using a Blender utility). Note that this conversion/thumbnail pipeline
relies on server‑side tooling (such as Blender), so that part of the setup depends
on your server environment.

You add the viewer through a **field**: it depends on core **Field** and defines
its own permissions. Models are assets provided by administrators/editors and
loaded by the viewer library; beyond its permissions the module has no special
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** — you set it up by adding the viewer field
to an entity and placing it on the display, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You work with it through the field system —
adding the viewer field to a content type and arranging it on the *Manage
display* tab — and grant its permissions on **People → Permissions**.

## How to use it

1. Enable the module and grant its permissions to the appropriate roles on
   **People → Permissions**.
2. Add the module's 3D‑viewer field to the content type (or other fieldable
   entity) that will hold your 3D models, via its **Manage fields** tab.
3. On the entity's **Manage form display**, position the field so editors can
   upload a 3D model file.
4. On **Manage display**, place the field where the interactive viewer should
   appear.
5. Upload a supported 3D file. Compression‑supported formats are converted to GLB
   and thumbnails are rendered automatically where the server‑side tooling (e.g.
   Blender) is available; other supported formats are displayed directly.
