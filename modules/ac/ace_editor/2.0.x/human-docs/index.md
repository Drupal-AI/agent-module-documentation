# Ace Editor — manual setup guide

**Ace Editor** (`ace_editor`) integrates the JavaScript [Ace](https://ace.c9.io/)
code editor into Drupal, turning plain textareas into a proper code editor with syntax
highlighting, line numbers, colour themes, and optional autocomplete. It is aimed at
technical fields — a "Raw HTML" or "Custom code" long‑text field, a snippet body, a
stored configuration blob — where editors and developers want the comfort of a real
code editor instead of a bare textarea.

It plugs into Drupal through three of core's existing extension points, so you can use
whichever fits your need:

- **A text‑editor plugin** — assign the Ace editor to any text format on the *Text
  formats and editors* page, so its textareas become the Ace code editor.
- **A field formatter** (`ace_formatter`) — render a stored `text_long` or
  `text_with_summary` field as read‑only, syntax‑highlighted code.
- **A text filter** (`ace_filter`) — turn `<ace>…</ace>` tags in body content into
  highlighted code snippets, with optional per‑tag `theme` and `syntax` attributes.

Two things are worth knowing up front. First, the **Ace JavaScript library is not
bundled** — you must download it into your site's `libraries/` directory, and until you
do, the editor falls back to a plain textarea and the Status Report shows an error (see
[Installation](installation/index.md)). Second, there is **no admin settings form**: the
module's site‑wide defaults (theme, syntax, size, and so on) live in a single
configuration object that you edit with Drush or config import, while the per‑format
options are set right on each text format. The module targets **Drupal 10 or 11** and
depends on core's **Editor** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and download the Ace JavaScript library (required).

## Where it lives in the admin menu

Ace Editor adds no settings page of its own. You wire it up in the places core already
provides:

- **Assign the editor:** **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`).
- **Read‑only display:** the **Manage display** tab of any entity bundle (choose the
  *Ace Editor* formatter for a long‑text field).
- **Site‑wide defaults:** the `ace_editor.settings` config object, edited via `drush
  config:set` (there is no UI).

## How to use it

### Assign the Ace editor to a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and configure
   (or add) a text format — for example a dedicated *Snippets* or *Raw HTML* format.
2. Set **Text editor** to **Ace Editor**.
3. Open the **Ace Editor Settings** fieldset and choose the options for this format —
   the colour **theme** (Cobalt, Monokai, Twilight, Solarized, and the rest of Ace's
   catalogue), the **syntax/mode** (the highlighting language — HTML, PHP, JavaScript,
   CSS, JSON, YAML, SQL, and roughly 130 more), the editor **height/width** and **font
   size**, and toggles for **line numbers**, the 80‑character **print margin**,
   **invisible characters**, **word wrap**, and Ctrl+Space **autocomplete**.
4. Save. Every textarea using that format now renders as the Ace code editor.

These per‑format choices are stored on the format's `editor.editor.<format>`
configuration entity, so they export and deploy like any config.

### Show a field as read‑only highlighted code

On a `text_long` or `text_with_summary` field, open the entity bundle's **Manage
display** tab, set that field's format to **Ace Editor** (`ace_formatter`), and adjust
its theme/syntax/size settings. The field then renders as a read‑only, syntax‑highlighted
view — handy for displaying stored code, logs, or configuration.

### Embed code snippets in body text

Enable the **Ace filter** on a text format (on the format's filter list). Editors can
then wrap code in an `<ace>` tag inside content:

```html
<ace syntax="php" theme="monokai">
  <?php echo "hello"; ?>
</ace>
```

Any attribute you put on the tag — `syntax`, `theme`, `height`, `width`, `font_size`,
`line_numbers`, and so on — overrides the filter's defaults for just that snippet, so
you can mix languages and themes on one page.

### Change the site‑wide defaults

Because there is no settings form, the module's global defaults live in the
`ace_editor.settings` config object and are edited with Drush. For example:

```bash
drush config:set ace_editor.settings theme monokai -y
drush config:set ace_editor.settings auto_complete 0 -y
```

The available keys are `theme`, `syntax`, `height`, `width`, `font_size`,
`line_numbers`, `show_invisibles`, `print_margins`, `auto_complete`, and
`use_wrap_mode`. These values seed the defaults for all three integration points; you
can then override them per format, per display, or per `<ace>` tag as above.

> **Note on permissions:** the module ships a file that was intended to register an
> `administer ace_editor` permission, but it is mis‑named, so that permission is **not**
> actually registered. Access to the editor and its settings is governed by the usual
> core permissions (administering text formats, managing display, and administering
> configuration for the Drush‑edited defaults).
