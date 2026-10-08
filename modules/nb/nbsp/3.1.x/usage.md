<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NBSP is a small CKEditor 5 plugin that lets content authors insert a non-breaking space (`&nbsp;`) with a toolbar button or Ctrl+Space, plus a text-format filter that turns the stored `<nbsp>` markup back into a real non-breaking space on output.

---

The module has two moving parts, both wired through a text format's configuration. First, a **CKEditor 5 plugin** (`nbsp.Nbsp`, declared in `nbsp.ckeditor5.yml`) adds a **"Non-breaking space"** toolbar button (toolbar item id `nbsp`) and a Ctrl+Space keyboard shortcut; in the editor the inserted character is stored as a `<nbsp>` element and highlighted in blue so authors can see the otherwise-invisible character. The plugin declares the `<nbsp>` element and is conditioned on the `nbsp_cleaner_filter` being enabled. Second, a **filter plugin** `NbspCleanerFilter` (id `nbsp_cleaner_filter`, title "Cleanup NBSP markup", type TYPE_TRANSFORM_IRREVERSIBLE) runs on output and replaces both `<nbsp></nbsp>` tags and legacy `<span class="nbsp">` elements with the UTF-8 non-breaking space (`\xc2\xa0`). To use it on a text format you drag the NBSP button onto that format's active toolbar, enable the "Cleanup NBSP markup" filter, and — if "Limit allowed HTML tags" is on — add `<nbsp>` to the allowed tags. Everything is stored in the standard `editor.editor.<format>` (toolbar) and `filter.format.<format>` (filters) config entities; the module itself has no settings page, no configure route, no permissions, no Drush, and no config schema of its own. It requires the core `editor` and `ckeditor5` modules.

---

- Let authors insert a non-breaking space with a CKEditor toolbar button.
- Insert a non-breaking space with the Ctrl+Space keyboard shortcut.
- Keep a two-word company name (e.g. "Acme Corp") from wrapping across two lines.
- Prevent a number and its unit ("10 kg") from being split at a line break.
- Keep a title and a name together on the same line.
- Show the normally-invisible non-breaking spaces highlighted in blue while editing.
- Convert stored `<nbsp>` markup to a real `&nbsp;` on output via the cleanup filter.
- Keep backward compatibility with old `<span class="nbsp">` content (also converted).
- Enable NBSP on just the Full HTML format while leaving others untouched.
- Enable NBSP on the Basic HTML format by also allowing the `<nbsp>` tag.
- Add the non-breaking space capability to a custom text format.
- Give editors control over line breaks without hand-editing HTML source.
- Avoid typing literal `&nbsp;` entities in the source view.
- Standardise non-breaking-space entry across an editorial team.
- Combine with "Limit allowed HTML tags" by whitelisting `<nbsp>`.
- Provide accessible, valid output (a real NBSP character, not stray markup).
- Localize the toolbar button label via the module's interface translation.
- Remove NBSP from a format simply by removing the toolbar button and disabling the filter.
- Ensure clean markup by running the irreversible cleanup filter last in the chain.
- Use it as a lightweight alternative to hand-managing non-breaking spaces in Twig/HTML.
