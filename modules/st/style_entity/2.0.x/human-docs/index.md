# Entity Style — manual setup guide

**Entity Style** (`style_entity`) lets site builders define reusable "styles" —
named sets of CSS classes — and apply them to nodes, blocks, and paragraphs. You
define a Style once as a configuration entity, then apply it to your content, and
the module adds its CSS classes to the rendered markup. It is a small,
site-building-oriented way to keep styling consistent and reusable rather than
sprinkling one-off classes through your content.

The problem it solves is repetition and drift in presentational classes. Instead
of remembering and re-typing the same class names on many pieces of content, you
capture them once as a named Style and reuse it wherever you need that look. The
module is built around a configuration entity that describes a style applicable to
block, paragraph, or node entities.

Entity Style depends on core **Field** and **Node**, provides its own permissions,
and lives in the Theming package. It is purely a theming and site-building
feature: the styles are administrator-defined configuration, added to markup as
class names, and the module carries no access-control role beyond its own
permission. Because the class values are set by administrators, they are output as
class names on your markup — define them as valid CSS class values.

This guide is written for a **human** working through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Entity Style is driven by the Style configuration entities you create rather than
by a single settings form. In broad strokes: define one or more **Style** entities
(each naming the CSS class or classes it represents), then apply a Style to the
nodes, blocks, or paragraphs you want to carry that styling. When those entities
render, the Style's classes are added to their markup, and your theme's CSS for
those classes does the rest. Keep the class values to valid CSS class names, and
add the styling rules for them in your theme.
