<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Icon Field — agent index

Provides an **SVG icon field type** (choose/store an SVG icon from an icon set and render it). Depends on core
`field`. Version **8.x-1.0-alpha11**. Core `^10||^11`.

Fields/media — **rendered inline SVG is active markup** (can carry `<script>`): use a **trusted** icon
set/source, avoid untrusted SVG (stored-XSS surface). No access role.
