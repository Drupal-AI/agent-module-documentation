# Style Options — manual setup guide

**Style Options** (`style_options`) is an API module that lets site builders define
reusable "style" controls — CSS classes, background colors, background images, and
arbitrary properties — in a YAML file, and expose them on **Layout Builder**
layouts/regions and on **Paragraph** types. The payoff: editors get friendly dropdowns
and color pickers to style components, without ever touching raw HTML or CSS, and you keep
the whole set of approved options in version control.

You declare which controls exist, and where they appear, in a discovery file named
`[module_or_theme].style_options.yml` at the root of a module or theme. That file has two
parts: `options:` (each entry picks one of the shipped plugins — `css_class`,
`background_color` with a Spectrum color picker, `background_image`, or a generic
`property` — and configures its label, choices, palette, and so on) and `contexts:` (which
options are offered on each layout and each paragraph type, with defaults, per‑plugin
overrides, and disable lists). Selected values are stored on the layout or paragraph
component and rendered as CSS classes, inline styles, or themed markup.

Two integration points wire the options into Drupal: your Layout Builder layouts must
extend the module's layout plugin to gain the controls, and each Paragraph type that should
get them needs the **Style Options** behavior enabled. There's no admin settings page — the
only route is a one‑time migration form for importing configuration from the older Option
Plugin module. Developers extend it by adding their own `@StyleOption` plugin or altering
the available options in code.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

Style Options is configured with a **YAML discovery file**, not through the config UI.
The typical workflow:

### 1. Declare your options in YAML

Create a file called `[your_theme].style_options.yml` (or `[your_module].style_options.yml`)
at the **root** of your theme or module. It has two top‑level sections:

- **`options:`** — the controls. For example a `css_class` option offering a list of
  approved classes ("Style 1", "Style 2"), a `background_color` picker with a curated brand
  palette (with optional alpha), a `background_image` control, or a generic `property`.
  Options can allow multiple selections and can apply a color as a class or as an inline
  style.
- **`contexts:`** — where each option appears. Under `layout:` you list which options show
  on Layout Builder sections (flag each as `layout: true` for the section itself and/or
  `regions: true` for each region); under `paragraphs:` you list which options show on each
  paragraph type. Use `_defaults` to apply options everywhere, per‑plugin/per‑type keys to
  override, and `_disable` to remove an inherited option.

The module's shipped `example.style_options.yml` is a full reference.

### 2. Wire it into Layout Builder

Your layout plugins must extend the module's `StyleOptionLayoutPlugin` (a `LayoutDefault`
subclass) so the option forms are added to the layout's configuration form. Point your
`*.layouts.yml` at that class (or a subclass of it).

### 3. Wire it into Paragraphs

Enable the **Style Options** behavior on each paragraph type that should get the controls:

1. Go to **Structure → Paragraph types**, edit a type, and open its **Behaviors** section.
2. Tick **Style Options** and **Save**.

Editors then see your declared controls when placing/editing Layout Builder sections and
paragraphs, and the chosen classes/styles are attached to the rendered components so your
theme's CSS can style them predictably.

### Migrating from Option Plugin

If you're coming from the legacy `option_plugin` module, rename its YAML files to
`[ext].style_options.yml`, then visit `/admin/config/style-options/migrate` and press the
button — it copies each paragraph's Option Plugin behavior settings over to Style Options.
