<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline SVG — agent index

A **field type/widget/formatter for storing and inlining raw SVG markup** (SVG becomes part of the DOM —
CSS-styleable/animatable). `inline_svg_media` submodule for Media. Depends on core `field`. Version **1.0.0**.
Core `^10||^11`.

**Security caveat:** inlined SVG is **active markup** (can carry `<script>`/handlers) — restrict SVG entry to
**trusted editors** and sanitize untrusted SVG (stored-XSS vector). No access role.
