# Style Options — Media Reference — manual setup guide

**Style Options — Media Reference** (`style_options_media_reference`) adds a
media picker to the [Style Options](https://www.drupal.org/project/style_options)
framework. Once it is enabled, a component or layout style form can offer editors
a field for choosing a media entity — an image, a video, a document — and the
selected media is rendered and injected into the build so a template can print it,
for example as a background image.

The problem it solves is a small but common one. Style Options already lets you
attach presentational choices to layouts and components, but out of the box those
choices are simple values (a class, a colour, a number). This module contributes
a richer option type — a *media reference* — so a style can point at an actual
media entity from your library. Behind the scenes the chosen media is exposed to
Twig as `{{ style_options_media_[option_id] }}`, ready for your component template
to render. Where the Media Library Form Element is available it uses that friendly
picker; otherwise it falls back to a plain autocomplete, with no configuration
change needed either way.

There is nothing to configure on a settings page — the module works by providing a
plugin that you reference from your Style Options YAML definitions. It depends on
the **Style Options** module and core's **Media** module. The media you reference
follows normal media access, and the module itself plays no access-control role: it
is purely a theming and site-building helper.

This guide is written for a **human** setting the module up and wiring it into a
component. If you are an AI coding agent, read the terser sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Style Options and Media.

## How to use it

After enabling the module, define a `media_reference` style option in the Style
Options YAML for the theme or module that declares your component/layout options.
When an editor opens that component's style form they get a media picker; the
media they pick is rendered into the build array and made available to the
component's Twig template as `{{ style_options_media_[option_id] }}` (replace
`[option_id]` with the id you gave the option). A typical use is letting an editor
choose a background image for a section without touching code.
