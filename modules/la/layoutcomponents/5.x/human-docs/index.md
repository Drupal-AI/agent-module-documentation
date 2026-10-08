# Layout Components — manual setup guide

**Layout Components** (`layoutcomponents`) is an extension of
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder) that
gives editors a much richer, more customizable building experience — an improved
interface, a **live preview of changes while editing**, and a large library of
ready‑made components you can drop into a layout out of the box.

Where core Layout Builder gives you sections, columns, and blocks with a modest set
of options, Layout Components adds fine‑grained control over almost every part of a
section and column — dynamic column selectors, Bootstrap column sizes, background
images and colors, sizing and height, paddings, borders, titles with their own
color/align/size/border settings, and custom classes and attributes. On top of
that it ships a catalogue of components — accordion, button, card, countdown,
iframe, image, social links, tabs, text, title, video, plus Slick and view‑carousel
integrations — each provided as a **submodule** you enable only if you need it.

For developers, the module also exposes an API to add your own fields and inherit
all the customization the module brings to the platform. It supports Drupal 9, 10,
and 11.

A note on safety: the components render authored content, so they carry no unusual
security surface beyond the usual. The one component to review deliberately is the
**iframe** component, which can embed arbitrary URLs — confirm who is allowed to
configure it and whether the URLs it can embed are constrained. As always,
components are placed by site builders and editors within Layout Builder's normal
access controls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and its dependencies, and pick the component submodules you need.
2. [Configuration](configuration/index.md) — the section, column, and component
   options you set while building a layout.

## Where it lives in the admin menu

Layout Components adds no central settings page; you use it entirely inside the
**Layout Builder** editor, wherever Layout Builder is enabled (typically under a
content type's **Manage display**, or on individual entities that allow layout
overrides). Its sections, columns, and components — and their extensive options —
appear directly in the layout editing UI.

## How to use it

1. Enable Layout Builder on the entity/display you want to build, and enable the
   Layout Components submodules for the components you plan to use.
2. Open the **Layout Builder** editor and add a section. Layout Components' section
   options (columns, sizing, background, title, paddings, classes, and more) appear
   in the section configuration — see [Configuration](configuration/index.md).
3. Add components into the columns from the component list (card, accordion, tabs,
   video, and so on), configuring each one in place with a live preview.
4. Save the layout when you are happy with the result.
