# Layout Builder Kit — manual setup guide

**Layout Builder Kit** (`layout_builder_kit`) is a set of ready‑made components
for building pages with core's Layout Builder. Layout Builder ships deliberately
bare — sections, blocks, and a way to arrange them, but almost nothing to arrange —
so every project tends to rebuild the same primitives (an image, a rich‑text
block, a video embed, tabs) before it can build anything specific. Layout Builder
Kit supplies that starting set so you can spend the first week of a project on the
design rather than on the plumbing.

The current components include **Book Navigation**, **Image**, **Icon Text** (an
icon beside text), **Render** (render a node or media object through a view mode),
**Rich Text**, **Tab**, and **Video** (YouTube and Vimeo). Most share common
options such as hiding the component title and adding CSS classes for further
styling.

Two honest caveats. First, the project is now in **maintenance‑only** status — the
maintainer will keep it working through the life of Drupal 11 but recommends
evaluating alternatives for new work. Second, pre‑built components are quick to
adopt but awkward to diverge from: the markup and settings are the module's, so a
design the options do not cover means overriding templates, and your pages become
dependent on these components (removing the module later leaves sections
referencing blocks that no longer exist). Weigh that trade before standardising on
it.

Note also that it depends on **Hook Event Dispatcher** — a substantial module that
re‑expresses Drupal's hooks as Symfony events — so adopting Layout Builder Kit
brings an architectural dependency along with the components.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and its Hook Event Dispatcher dependency.
2. [Configuration](configuration/index.md) — the settings form and the module's
   access permission.

## Where it lives in the admin menu

- The kit's components appear in the Layout Builder **Add block** palette wherever
  you build a layout (for example **Structure → Content types → *(type)* → Manage
  display → Layout**).
- The module's settings form lives at **Configuration → Content authoring →
  Layout Builder Kit settings**
  (`/admin/config/content/layout_builder_kit/settings`) — see
  [Configuration](configuration/index.md).

## How to use it

1. In a Layout Builder layout, click **Add block** and choose one of the Layout
   Builder Kit components (Image, Rich Text, Video, Tab, Icon Text, Render, or Book
   Navigation).
2. Fill in the component's options — for example choose an image style and overlay
   text for the Image component, or pick a node/media object and view mode for the
   Render component — and place it in the layout.

> **Uploading images:** to upload images for the Image component you will almost
> certainly want a helper module such as IMCE, Editor File Upload, Insert, or
> CKEditor Upload Image.
