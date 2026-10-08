# Shortcode SVG — manual setup guide

**Shortcode SVG** (`shortcode_svg`) lets content editors drop individual icons from
an uploaded SVG sprite into their content using a simple `[svg …]` shortcode. Instead
of pasting raw SVG markup into the body of a page — which is ugly to maintain and easy
to get wrong — an editor writes a short tag, and the module renders the matching icon
from the sprite as a crisp, scalable vector.

The appeal is keeping the messy markup out of the content. You upload an SVG sprite
once, and from then on editors reference its icons by shortcode. Because the icons are
vectors, they stay sharp at any size, and because they come from a shared sprite, the
whole site's iconography stays consistent.

This is a lightweight helper built on top of the **Shortcode** module — it adds a new
shortcode rather than any admin settings screen, so there is nothing you *must*
configure beyond enabling it and making sure the shortcode filter is available on the
text formats where you want to use it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and its Shortcode dependency.

## How to use it

Once the module and the Shortcode module are enabled, upload your SVG sprite and use
the `[svg …]` shortcode inside content on any text format that has the Shortcode
filter turned on. Each shortcode renders a single icon from the sprite inline, so you
never have to paste SVG markup into the body yourself.
