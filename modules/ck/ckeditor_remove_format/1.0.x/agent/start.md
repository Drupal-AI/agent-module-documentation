<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Remove Format (ckeditor_remove_format) — agent index

A single **text-format filter**, not a CKEditor toolbar button. It provides one filter plugin,
`filter_remove_format` (title "Remove Format Filter"), whose `process()` runs PHP `strip_tags($text)`
— stripping **every HTML tag** from the content when the text format is rendered. Despite the project
name/README wording ("enhances CKEditor 5's Remove Format plugin", "remove format on save"), there is
**no JavaScript, no CKEditor 5 plugin, and no toolbar button** in the source; the cleanup is a
server-side output filter, and it removes all markup indiscriminately (not just inline bold/italic).

Version **1.0.0** (version dir `1.0.x`). Core `^10.1 || ^11`. Package "User interface". License
GPL-2.0-or-later. Not covered by the Drupal security advisory policy. No dependencies, no PHP/Composer
libraries, no permissions, no routes, no config schema, no submodules.

## What it provides (from source — the whole module)

- `src/Plugin/Filter/RemoveFormatFilter.php` — `@Filter` plugin id `filter_remove_format`, type
  `TYPE_TRANSFORM_IRREVERSIBLE`. `process($text, $langcode)` returns
  `new FilterProcessResult(strip_tags($text))`. `tips()` returns a static string. No settings form,
  no configurable behaviour.
- `ckeditor_remove_format.module` — only `hook_help()` for `help.page.ckeditor_remove_format`.
- `ckeditor_remove_format.info.yml` — module metadata (`core_version_requirement: ^10.1 || ^11`,
  package "User interface"). No `configure` link, no dependencies.
- `README.md`, `LICENSE.txt`.

That is the complete file inventory — there are no `js/`, `config/`, `templates/`, `*.routing.yml`,
`*.services.yml`, `*.permissions.yml`, `*.libraries.yml`, or `*.install` files.

## How it behaves

The filter is a text-format filter, so it runs when content in that format is **rendered for display**
(filters transform the stored value on output; the stored HTML is unchanged). Enable "Remove Format
Filter" on a text format at `/admin/config/content/formats`, and any content rendered through that
format has all HTML tags removed via `strip_tags()`, leaving only the text nodes. Because it strips
everything, enabling it on a rich-text format effectively flattens that format's output to plain text —
this is coarse, not a selective "clear inline formatting" tool. Filter execution order matters: place it
appropriately relative to other filters on the format.

## Notes / caveats

- The README's "remove format on save" and "enhances CKEditor 5's Remove Format plugin" descriptions do
  not match the code: it is an output-time filter, not a save-time or editor-side operation, and it is
  independent of CKEditor 5's own built-in Remove Format button (which is a core CKEditor feature).
- `strip_tags()` removes tags but keeps their inner text (e.g. `<b>hi</b>` → `hi`), and drops tag
  attributes entirely.
