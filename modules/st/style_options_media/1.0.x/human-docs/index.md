# Style Options Media — manual setup guide

**Style Options Media** (`style_options_media`) adds a new style-option type for
**media** to the Style Options system. Style Options already includes an image
option, but that option only lets you upload an image as a managed file — which is
limiting if you want to use responsive image styles, reference existing library
media, or offer something like a background video. This module adds a Style Option
plugin that references media items through the **Media Library** instead, so
media placed in a layout can carry a proper media reference rather than a bare
file upload.

The problem it solves is richer media handling in the Style Options workflow. With
this plugin, a site builder can offer editors a media choice — picked from the
Media Library — as part of a component's styling options, opening the door to
responsive image styles and other media types that the built-in image option does
not support. It fits into the Style Options ecosystem used for styling layout
components, and it introduces no security surface of its own.

Style Options Media depends on the **Media Library Form Element** module and
supports Drupal 10 and 11. It is a theming and layout convenience: there is no
settings form to configure — enabling it makes the new media style-option plugin
available for use within Style Options.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, the module's media style-option plugin becomes available in the
Style Options system. Where you configure style options for your layout components
(in the usual Style Options way), you can now offer a media option that uses the
**Media Library** to reference a media item — for example an image you can then
render through a responsive image style, or another media type such as a
background video. There is nothing to switch on beyond enabling the module.
