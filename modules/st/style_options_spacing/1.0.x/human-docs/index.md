# Style Options: Spacing — manual setup guide

**Style Options: Spacing** (`style_options_spacing`) adds ready-made spacing
controls — margins and paddings — to the
[Style Options](https://www.drupal.org/project/style_options) framework, so site
builders and editors can adjust the spacing around a component or layout without
writing any CSS or PHP.

The Style Options module already lets you attach presentational choices to
layouts and components, but adding spacing normally means the more involved
"property" style option, which takes enough coding work to put people off. This
module removes that friction. It contributes spacing options in two flavours:
**preset drop-downs** — a fixed list of choices such as the spacing scale from
Tailwind, Bootstrap, or whatever scale you define in your own Style Options YAML,
emitted as CSS classes — and a **free input field** where an editor types a value
with a CSS unit (for example `1.5rem`) that is applied as an inline style.

There is no dedicated settings page. You enable the module, then reference its
spacing options from the Style Options YAML that describes your components and
layouts; the controls then appear wherever Style Options are used. It depends only
on the **Style Options** module. This is a presentation feature — it emits spacing
classes or inline styles and has no content or access-control role.

This guide is written for a **human** wiring spacing options into a site's
components. If you are an AI coding agent, read the terser sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Style Options.

## How to use it

After enabling, declare the spacing options you want in the Style Options YAML for
your theme or module — either as preset drop-downs (each preset mapped to a CSS
class in your scale) or as a free CSS-unit input. Editors then see spacing
controls on the relevant component/layout style form, and their choices apply as
classes or inline styles to the rendered output.
