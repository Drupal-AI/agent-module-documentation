# @font-your-face — manual setup guide

**@font-your-face** (`fontyourface`) gives you an admin interface for browsing,
importing, and applying web fonts to your Drupal site — without hand-editing
`@font-face` rules in your theme's CSS. You import fonts from a provider, enable the
ones you want, and either load them site-wide or bind specific fonts to specific CSS
selectors on specific themes. It manages the underlying `@font-face` CSS for you.

The core module is the framework — it ships **no fonts of its own**. Each font
source is a **provider submodule** you enable separately: **Google Fonts**, **Adobe
Edge Fonts**, **Typekit / Adobe Fonts**, **Fonts.com**, **Font Squirrel**, and
**Local Fonts** (for self-hosting font files instead of calling a third-party CDN).
Some providers (Google, Typekit, Fonts.com) need an API key or token, which you
enter on the settings form before importing.

Once fonts are imported they become `font` entities you can preview, enable, and
disable from a font manager. To apply a font precisely — say, "use this font for
`h1, h2` on the Olivero theme, with a sans-serif fallback" — you create a **Font
display** rule. Fonts are also tagged by foundry, designer, classification, and
language (which is why the module needs Taxonomy), and the font manager itself is
built with Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the provider hook
API and helper functions — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the core
   module, and pick the provider submodules you need.
2. [Configuration](configuration/index.md) — the settings form, importing fonts,
   enabling them, and creating Font display rules, step by step.

## Where it lives in the admin menu

Everything sits under **Appearance → @font-your-face**:

- **Settings & import:** **Appearance → @font-your-face → Settings**
  (`/admin/appearance/font/settings`).
- **Font manager (enable/disable):** **Appearance → @font-your-face**
  (`/admin/appearance/font`).
- **Font display rules:** `/admin/appearance/font/font_display`.

All admin routes are gated by the single **Administer font entities**
(`administer font entities`) permission.

## How to use it

1. Enable the core module plus at least one provider submodule (for example
   `google_fonts_api`).
2. On the **Settings** form, enter any required API key/token, then click the
   provider's **Import** button to pull its fonts in.
3. On the **font manager**, enable the fonts you want (AJAX enable/disable links).
4. Either leave "load all enabled fonts" on to make every enabled font available
   site-wide, or create a **Font display** rule to target specific selectors and
   themes.

See [Configuration](configuration/index.md) for the details of each step.
