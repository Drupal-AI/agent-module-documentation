# Seeds Layouts — manual setup guide

**Seeds Layouts** (`seeds_layouts`) provides a set of layout plugins for Layout
Builder, written to work across CSS frameworks rather than assuming any one of
them. It aims to be a single alternative to a handful of older layout modules
(Bootstrap Layouts, Foundation Layouts, Layout Section Classes, Layout Builder
Styles), giving editors more section options and more per-section control.

Layout Builder ships four layouts — one, two, three, and four columns — and most
projects immediately need more: an asymmetric split, a wide band with a
constrained inner column, a sidebar arrangement that stacks in a particular order
on mobile, a grid that reflows differently at each breakpoint. Writing those by
hand means a layout plugin, a template, and a set of CSS classes per project — and
the classes are where portability dies, because a layout written for Bootstrap's
grid does not work on a Tailwind theme or a bespoke one. Seeds Layouts provides
framework-agnostic layouts so they can be reused. On top of the columns, it lets
you attach **custom options** to a section (rendered as a checkbox or a select
list whose choices become CSS classes on the section) and even **upload a
background image** for a section right inside Layout Builder.

Two things are worth keeping in mind. First, a layout's real interface is its
**breakpoint behaviour**: a two-column layout is only a design decision until the
viewport narrows, at which point it becomes a content-order decision, and which
column comes first when they stack is usually what an editor cares about. Second,
**layouts become a dependency of your content** — a page built with a layout keeps
referring to it, so removing or renaming a layout later can leave sections that
can no longer render. Treat layouts like paragraph types: easy to add, harder to
take away.

The module ships one optional submodule, **Seeds Layouts Classes Extractor**
(`seeds_layouts_classes_extractor`), which addresses a corollary of being
framework-agnostic: the classes a layout emits must be discoverable by whatever
builds your site's CSS, or a utility framework that purges unused classes will
strip them from the build.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide whether you need the classes-extractor submodule.
2. [Configuration](configuration/index.md) — where the settings live and how the
   per-section options surface in Layout Builder.

## How to use it

Once enabled, the new layouts appear in the layout picker whenever you add or
configure a section in **Layout Builder** — on a content type's *Manage display*
screen (with Layout Builder turned on) or when editing an individual entity's
layout. Pick a Seeds layout for the section, and its custom options (classes) and
background-image field appear in the section-configuration form.
