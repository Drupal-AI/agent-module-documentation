# Layout Options — manual setup guide

**Layout Options** (`layout_options`) lets you add styling controls — CSS classes,
an id attribute, custom classes — to Drupal layouts **declaratively through YAML
files**, in most cases with no PHP. It's aimed at Layout Builder (and Display
Suite) sites where you want site builders to pick from a controlled palette of
design classes on a section, rather than typing arbitrary markup or writing a new
layout for every visual variation.

Here's how it fits together. The module ships a special **LayoutOptions** layout
plugin. Any layout that uses this plugin class reads `*.layout_options.yml` files
provided by your modules and themes. Those files declare the available options
(each a title, default, and which **option plugin** renders it) and rules for
which options appear on which layouts and regions. When an editor configures a
section in Layout Builder, the options show up as form elements; their selected
values are validated (as proper CSS identifiers) and applied as classes or
attributes on the layout or region wrapper.

The base module has **no settings form** of its own (`configure` is null) — it is
driven by YAML. To make *existing* core or contrib layouts accept options without
redefining them, the bundled **layout_options_ui** submodule provides an admin form
that swaps those layouts over to the LayoutOptions plugin. Layout Options depends
only on core's **Layout Discovery** module. It provides one plugin type
(`LayoutOption`) with several built‑in option controls, and you can implement your
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and (recommended) the `layout_options_ui` submodule.
2. [Configuration](configuration/index.md) — write the YAML options file, enable
   options on existing layouts, and configure them on a section.

## Where it lives in the admin menu

The base module adds no admin page. With the **layout_options_ui** submodule
enabled you get an admin form for choosing which existing layouts should accept
options. The options themselves are configured inline on each **Layout Builder**
section (or Display Suite layout).

## How to use it

The typical flow is: define your option set in a `[theme].layout_options.yml` file
(a palette of CSS‑class selects, checkboxes, an id field, etc.), make your layouts
use the LayoutOptions plugin (directly, or via the UI submodule for existing
layouts), then let editors pick options when they add or configure a section. See
[Configuration](configuration/index.md) for the file format and the step‑by‑step
setup.
