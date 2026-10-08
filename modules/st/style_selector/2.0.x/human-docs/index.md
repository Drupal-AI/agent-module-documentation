# Style Selector — manual setup guide

**Style Selector** (`style_selector`) gives editors a friendly, visual way to pick
a CSS class or a color instead of typing class names or hex codes into a plain
text field. It provides two field types — a **Style list** (a CSS class chosen
from a curated set) and a **Color list** (a color chosen from a palette) — that
render as clickable swatches, and formatters that apply the chosen value to the
rendered content.

The point is control with a nice UX. A designer defines the allowed classes or
colors, and editors can only pick from those swatches — so you get the flexibility
of per-item styling without letting anyone paste in arbitrary CSS. Two widgets are
available: a large **tile** picker with thumbnail-style swatches, and a **compact**
picker using radios or checkboxes. Fields can be single- or multi-select, and can
offer an explicit "None" option.

When content is displayed, the formatters do the work. The **CSS Class** formatter
appends the chosen class(es) to the rendered entity's wrapper, and the **CSS
Color** formatter writes an inline style (for example `background-color: … !important`)
onto the wrapper — the target CSS property is configurable, so the same color
field can drive text color or background color. Colors are validated and
normalised for you: hex values are converted and stored as RGB/A, and rgb/rgba,
hsl/hsla, named/system colors, and keywords like `transparent` and `currentColor`
are all accepted.

There is also a reusable `style_selector` **Form API render element**, so
developers can embed the same swatch picker in custom or Layout Builder settings
forms. The module depends only on core's **Options** module, adds no permissions,
and ships an optional demo submodule with sample CSS libraries. One important
thing to understand: **Style Selector ships no design CSS of its own** — the
actual look of each class comes from CSS libraries your theme provides, which you
attach on the settings page.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the demo submodule.
2. [Configuration](configuration/index.md) — the global settings page, adding a
   field, and the widget/formatter options.

## Where it lives in the admin menu

The global settings form is at **Configuration → User interface → Style
Selector** (`/admin/config/user-interface/style-selector`), reachable by users
with **Administer site configuration**. The rest of the setup happens on the
**Manage fields**, **Manage form display**, and **Manage display** screens of
whatever content type, media type, or other entity bundle you add a field to.

## How to use it

1. On the settings page, attach the CSS libraries that define your classes and,
   optionally, register global class/color values (see
   [Configuration](configuration/index.md)).
2. On a bundle's **Manage fields**, add a field of type **Style list** or **Color
   list** and define its allowed values (the swatches editors can choose from).
3. On **Manage form display**, choose the **tile** or **compact** widget and set
   its options.
4. On **Manage display**, choose the **CSS Class** or **CSS Color** formatter so
   the selection is applied to the rendered entity.
5. Editors now see the swatch picker when they edit content, and their choice is
   reflected on the rendered page.
