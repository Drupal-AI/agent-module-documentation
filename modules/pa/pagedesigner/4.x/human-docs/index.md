# Pagedesigner — manual setup guide

**Pagedesigner** (`pagedesigner`) is a drag‑and‑drop page builder for Drupal. Instead
of filling in fields on a node form, editors compose a page visually: they drag
**rows** onto the canvas (single column, two columns, three columns and so on), nest
them as needed, and drop **components** — text, images, icons, quotes, video, galleries,
webforms and more — anywhere inside those rows. Everything is edited on the page itself
and updates in real time (WYSIWYG), and elements can be moved, copied, deleted, and
styled (margins, padding, borders, colours) directly in the editor. Responsive modes
let editors preview and tune the layout for different screen sizes.

The visual editor is built on the **GrapesJS** web‑builder framework, and Pagedesigner
itself is the *framework*: the actual set of things you can drop onto a page comes from
its **component submodules**. The base module ships around nineteen of them (image,
image‑edit, audio, video, document, gallery, media, SVG, embed, link, layout, webform,
page‑tree, multitheme, duplication, Yoast SEO, front‑end publishing, and more), and you
enable only the ones you actually need. Several **companion projects** extend it further —
Pagedesigner Parts (reusable sections), Effects, Megadropdown, Responsive Images, TMGMT
translation, Block Adaptable, and View Modes Display — each documented separately.

A word on safety worth knowing up front: because a page builder embeds authored content,
the components that render potentially untrusted markup deserve attention. The **embed**
component can pull in external content or scripts, and the **SVG** component handles SVG,
which can carry scripts if it isn't sanitised. Enable only the components you use, review
how the embed and SVG components handle their input and who is allowed to configure them,
and restrict page building to trusted editorial roles. Pagedesigner is
**security‑advisory covered** and is *minimally maintained* (maintenance fixes only) at
this version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (note the
   bundled patches and dependencies), enable it, and pick the component submodules you
   need.

Pagedesigner has **no single settings form** of its own (its configure route is empty);
you build pages within the visual editor when editing content, and you turn capabilities
on and off by enabling or disabling component submodules. So there is no separate
Configuration page in this guide.

## Where it lives in the admin menu

Pagedesigner does not add one central configuration screen. Instead it augments the
**content editing experience**: when you edit a node whose display uses Pagedesigner,
the drag‑and‑drop editor opens on that content. Which components appear in the editor is
determined by which component submodules are enabled (see Installation).

## How to use it

1. Enable Pagedesigner plus the component submodules you want (for example
   `pagedesigner_image`, `pagedesigner_layout`, `pagedesigner_video`).
2. Edit a piece of content set up to use Pagedesigner. The visual editor opens.
3. Drag a **row** layout onto the canvas, then drop **components** into it. Edit and
   style each element in place; switch responsive modes to check smaller screens.
4. Save. What you built renders on the page.

> **Installation note:** Pagedesigner's `composer.json` bundles two required patches
> (for `drupal/linkit` and `drupal/ui_patterns`). These apply automatically when you
> install via Composer with patching enabled — see [Installation](installation/index.md).
