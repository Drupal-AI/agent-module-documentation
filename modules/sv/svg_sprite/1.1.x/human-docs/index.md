# SVG Sprite — manual setup guide

**SVG Sprite** (`svg_sprite`) adds a new field type — **SVG Sprite** — that lets
editors pick an icon from a dropdown by its symbol id and renders it as a tiny
`<svg><use href="file.svg#symbol-id"></svg>` reference to a shared sprite file.
Instead of storing an image per icon, you point the module at a single SVG sprite
file (the kind icon toolchains generate, containing many `<symbol id="…">`
entries) and it reads out every symbol so editors can choose one.

The problem it solves is running a consistent, lightweight icon system across a
site. Because the rendered markup only *references* the external sprite via
`<use>`, icon markup stays tiny, you can swap the whole icon set by pointing
config at a different sprite file, and everything shares one cached asset. The
module gives you three ways to place an icon: the **SVG Sprite field** (with a
`<select>` widget and a matching formatter), a **Twig function**
`{{ svg_sprite('lightbulb') }}` for use in templates, and an experimental **token**
`[svg_sprite:sprite:lightbulb]`.

It needs a small amount of configuration to be useful: you must tell it where the
sprite file lives on its settings form at **Configuration → Content → SVG Sprite
settings** before the field and Twig function have anything to list or render. It
has no module dependencies beyond Drupal core (10.3 or 11). One optional
submodule, **SVG Sprite CKEditor 5** (`svg_sprite_ckeditor5`), adds a button to
insert sprites into the CKEditor 5 rich‑text editor.

On the security side, this module is deliberately conservative: it does **not**
inline uploaded SVG content — it references an external sprite file that an
administrator configures (the settings form needs the *administer site
configuration* permission). Both the `href` and the symbol id pass through Twig's
autoescaping, and widget option labels are stripped of tags and decoded. One thing
to know: the experimental token, and rendering sprites in some restricted contexts
like Views, may require allow‑listing the `svg` and `use` HTML tags — do that
knowingly, since loosening the allowed‑tags list has XSS implications.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) enable the CKEditor 5 submodule.
2. [Configuration](configuration/index.md) — point the module at a sprite file,
   add the SVG Sprite field, and render sprites in Twig or via the token.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Content → SVG Sprite
settings** (`/admin/config/content/svg_sprite`). It requires the *administer site
configuration* permission.
