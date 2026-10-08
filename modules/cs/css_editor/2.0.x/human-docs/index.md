# CSS Editor — manual setup guide

**CSS Editor** (`css_editor`) lets you add custom CSS to your site right from the
browser — no subtheme, no theme deployment, no touching the codebase. It adds a
**Custom CSS** box to every theme's settings page, complete with CodeMirror syntax
highlighting and a live-preview iframe, and then injects whatever you save *after*
all of that theme's other stylesheets so your rules reliably win the cascade.

It is a handy tool for quick, safe tweaks: nudging colours or spacing, hiding an
element a contrib module renders that you can't configure away, adding print-only
rules, overriding a modern theme's CSS custom properties, or applying an
accessibility fix — all without a code release. Because the CSS is stored as
Drupal **configuration** (one config object per theme), it moves cleanly between
environments with your normal config export/import, and you can roll back a bad
change by reverting a single config object.

The CSS is applied **per theme**, and only while that theme is the active one. So
front-end tweaks go on your front-end theme and admin tweaks go on your admin
theme (e.g. Claro) — you edit each on its own appearance-settings page. The saved
CSS is written out to a generated file and rebuilt automatically on every cache
clear, so the file is disposable and the config is always the source of truth.

There is no dedicated permission — access follows core's **Administer themes**
permission, since the editor lives on the theme settings form. The module works on
Drupal 9, 10, and 11.

One practical note: the CodeMirror editor is loaded from a public CDN, so it needs
outbound network access. On a locked-down site with no internet access, tick **Use
plain text editor** and you get a normal textarea instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the Custom CSS box, field by field,
   and how per-theme CSS works.

## Where it lives in the admin menu

CSS Editor has no page of its own. It adds a **Custom CSS** section to each theme's
settings page at **Appearance → Settings → <theme>**
(`/admin/appearance/settings/<theme>`).

## How to use it

1. Go to **Appearance → Settings** and choose the theme you want to style (for the
   front end, that's usually your default theme; for the admin UI, Claro).
2. Open the **Custom CSS** section, tick **Enable custom CSS**, and type your rules
   into the editor. Watch the live preview update as you go.
3. Save. Your CSS now loads on every page rendered with that theme, after the
   theme's own stylesheets.
