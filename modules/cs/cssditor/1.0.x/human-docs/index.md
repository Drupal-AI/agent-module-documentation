# Custom CSS Adder (CSSditor) — manual setup guide

**Custom CSS Adder** — project name **CSSditor** (`cssditor`) — lets
administrators add custom CSS to a theme directly from the browser, without
touching the codebase. It adds a **CSS customization** section to each theme's
settings page in Appearance, complete with a text editor (an optional CodeMirror
editor with syntax highlighting, a plain‑text toggle, and a live‑preview iframe).
When you save, the CSS is written to a public file
(`public://custom_css_adder/<theme>.css`) and attached to that theme with a high
weight, so it overrides the theme's own styles.

An important naming detail: although the **project/repo is `cssditor`**, the actual
**module machine name is `custom_css_adder`**. You install it with the `cssditor`
Composer package but enable it as `custom_css_adder` — see
[Installation](installation/index.md).

Because editing is gated behind the theme settings form (the `administer themes`
permission), only trusted administrators can set the CSS, which keeps the
stored‑CSS risk limited to trusted users. CSS is stored **per theme**, so each
theme has its own customization and file. It supports Drupal 9 and 10.

> **Heads up:** this project is marked **Unsupported / Obsolete** and is **not
> covered** by Drupal's security advisory policy. Its documentation also notes a
> known bug in the preview theme‑switch path (a coding error that would fatal if
> the theme negotiator runs). Weigh that before using it, especially on new sites —
> core's own asset handling or a maintained CSS‑injection module may be a better
> choice.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the `cssditor` package with
   Composer and enable the `custom_css_adder` module.

There is **no dedicated module settings page** — you add CSS from each theme's
own settings form under Appearance, as described in "How to use it" below.

## Where it lives in the admin menu

Custom CSS Adder adds no admin page of its own. Its editor appears as a **CSS
customization** section inside each theme's settings at **Appearance → Settings →
*(theme)*** (`/admin/appearance/settings/<theme>`).

## How to use it

1. Go to **Appearance → Settings** and choose the theme you want to customize
   (each theme is configured separately).
2. Find the **CSS customization** details section and **tick the enabled**
   checkbox.
3. Paste your custom CSS into the editor. Optionally enable the plain‑text editor
   (instead of CodeMirror) and the automatic live preview.
4. **Save** the theme settings. Your CSS is written to
   `public://custom_css_adder/<theme>.css` and attached to that theme, overriding
   its styles immediately (caches are flushed on save).
5. To remove your customizations, clear the textarea or untick the enabled
   checkbox and save. Note that uninstalling the module leaves the generated files
   under `public://custom_css_adder/` behind — delete them manually if you want
   them gone.
