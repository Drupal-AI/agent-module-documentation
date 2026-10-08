# Helper Class — manual setup guide

**Helper Class** (`helper_class`) is a lightweight site‑building tool that lets you
attach custom CSS classes to **entities**, **Views rows and wrappers**, and other
render elements — without writing a preprocess function or a custom template. It is
a handy way to hook a component library's utility classes (for example Bootstrap
card/grid classes) onto Drupal's output straight from the site‑building UI.

The idea is to keep the flexible, reusable pieces of a design system in the hands of
site builders: use Helper Class to handle "organism" and "template" level assembly
with plain helper classes, while Single Directory Components (SDC) handle the
smaller atoms and molecules. It pairs naturally with the Field Group and Field
Formatter Class modules.

One thing worth keeping in mind: the class values you enter are rendered into your
markup as‑is, so treat them as trusted, admin/editor‑supplied styling. The module
has no content or access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module — you set classes directly on
the elements you want to style, as described below.

## How to use it

Helper Class does not add an admin settings form. Instead it adds class‑entry
options where you build displays:

- **On entities** — configure the helper class on the entity's display so the class
  is added to its rendered wrapper.
- **On Views** — set helper classes on a view's rows and/or its wrapper to style
  the output (for example to build a responsive card grid).

Enter the CSS class names you want, save, and they appear in the rendered markup so
your theme's (or component library's) styles can target them.
