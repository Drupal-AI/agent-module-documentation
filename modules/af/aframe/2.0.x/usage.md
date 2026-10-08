<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A-Frame Integration brings the A-Frame WebVR/WebXR framework into Drupal as field formatters and widgets, so editors can upload 3D models and build VR scenes that render on content.

---

A-Frame Integration wires the A-Frame WebVR/WebXR JavaScript framework into Drupal's Field API. It ships two field formatters — `aframe_model` renders an uploaded 3D model file (glTF/GLB/OBJ/COLLADA) inside an interactive `<a-scene>` via the `aframe_model_viewer` theme template, and `aframe_scene` renders a stored A-Frame scene into an embedded viewer — plus two matching widgets: `aframe_model_widget` (a file-upload widget extending core's `FileWidget`, with a live 3D preview) and `aframe_inspector` (a scene-builder textarea wired to the visual A-Frame Inspector). A global settings form at `/admin/config/media/aframe` (route `aframe.settings`) stores site-wide defaults in the `aframe.settings` config object: the A-Frame library source/version, background color, fog, ambient/directional lighting, and which roles may open the Inspector. The A-Frame JS library and its Inspector/orbit-controls add-ons are declared in `aframe.libraries.yml` and loaded from the jsDelivr CDN. The module targets Drupal 10 and 11 and has no submodules.

---

- Upload a 3D model (glTF, GLB, OBJ, or COLLADA/DAE) to a core file field and display it as an interactive WebGL scene.
- Add the "A-Frame 3D Model Viewer" formatter (`aframe_model`) to a file field on Manage display.
- Configure per-display model dimensions, camera position/rotation, model position/scale/rotation, background color, and lighting.
- Offer viewers an optional "Download 3D Model" button next to the rendered model.
- Auto-rotate a displayed model for a turntable effect.
- Use the "A-Frame 3D Model Upload with Preview" widget (`aframe_model_widget`) to preview a model right in the edit form.
- Attach a full A-Frame scene to a `text_long`/`string_long` field and render it with the "A-Frame Scene Viewer" formatter (`aframe_scene`).
- Build scenes visually with the A-Frame Inspector using the `aframe_inspector` widget (Ctrl+Alt+I / Cmd+Option+I).
- Seed new scene fields with a starter template (scene, camera, lighting, sample primitives) via the widget's "Include base scene structure" setting.
- Restrict which roles may open the visual Inspector via the settings form's "Roles allowed to use inspector".
- Set site-wide default background color and lighting (ambient/directional color and intensity).
- Enable linear or exponential fog with configurable color and near/far distances as a scene default.
- Choose the A-Frame library source (CDN or local self-hosted) and pin the A-Frame version in settings.
- Publish immersive WebVR/WebXR content that works across desktop, mobile, and headsets.
- Present product, museum, or educational 3D assets on nodes without hand-writing scene bootstrap code.
- Combine the model formatter with core file-field access and display settings.
- Automatically pick the right A-Frame model loader (`gltf-model`, `obj-model`, `collada-model`) from the file extension.
- Show a "Loading 3D Scene…" placeholder until the A-Frame runtime initializes.
- Target Drupal 10 and 11 sites.
