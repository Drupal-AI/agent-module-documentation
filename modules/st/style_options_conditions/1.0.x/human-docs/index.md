# Style Options Conditions — manual setup guide

**Style Options Conditions** (`style_options_conditions`) extends the Style
Options module with a condition system, so a paragraph's style options can appear
and apply only when they make sense in context. Instead of every style option
always showing up in the editor for every paragraph, you can gate each option on
conditions — and Style Options only shows an option to editors, and only applies
it to rendered output, when all of that option's declared conditions pass.

The problem it solves is context-aware styling without custom PHP per paragraph
type. Site builders declare the conditions right in a paragraph type's
`*.style_options.yml` file, alongside the options they guard. Multiple conditions
on one option are combined with AND — all must pass — and because conditions are
plugins, other modules can add new condition types. Typical uses include showing a
"Container Width" option only when a paragraph sits at the top level of a page (not
inside a grid), showing a "Column Span" option only inside a specific multi-column
layout, or exposing a layout-specific option only in certain regions.

The module ships one submodule, **Style Options Conditions: Layout**
(`style_options_conditions_layout`), which provides a condition plugin that
evaluates visibility based on Layout Paragraphs context. Layout Paragraphs is not
a hard dependency — the plugin checks for the module at runtime and, if it is not
installed, simply passes (fails open) rather than erroring.

Style Options Conditions depends on **Paragraphs** and **Style Options**, provides
its own permissions, and supports Drupal 10 and 11. It is a theming and
site-building enhancement with no content or access role of its own, and it is
configured entirely through YAML rather than an admin form.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no settings screen. You declare conditions in a paragraph type's
`*.style_options.yml` file, placed next to the style options they guard. Give an
option one or more conditions (multiple conditions are ANDed), and Style Options
will only offer and apply that option when they all pass. To use Layout Paragraphs
context in your conditions, also enable the **Style Options Conditions: Layout**
submodule (see [Installation](installation/index.md)). If you need a condition type
that isn't provided, a developer can add one as a plugin.
