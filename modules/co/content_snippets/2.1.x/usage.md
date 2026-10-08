<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Snippets stores small named pieces of editable text as configuration and lets custom code, tokens, and Twig read them by machine name — with defining a snippet and editing its value gated by two separate permissions.

---

Every site has text that is neither a page nor a piece of code: a strapline, a legal footnote, a phone number that appears in four places, the sentence above a custom form, an out-of-hours notice. Hard-coded in a template it needs a deployment to change; built as a custom block it is heavy for one sentence and easy to lose track of; duplicated in several places it eventually disagrees with itself. Content Snippets gives those a home. An administrator with `administer content snippets` defines each snippet — a label, a machine ID, a storage type (Number, Line/plain, Paragraph/plain, or, with the Filter module, Paragraph/formatted), help text, an optional group and a weight — on an admin page; a content editor with `edit content snippets` then fills in the value on a dedicated "Snippets" page under Content. That **permission split** is the distinguishing feature: *which* snippets exist is a structural decision and *what they say* is an editorial one. Each snippet is then read by its machine name three ways: `content_snippets_retrieve('id')` in PHP, the token `[content_snippets:id]`, or the Twig variable `{{ contentSnippets.id }}`. Definitions live in the `content_snippets.items` config object and values in `content_snippets.content`, and — confirmed for this campaign — both are **ordinary configuration with no schema**: they deploy with the codebase, are reviewable in a diff, and are **overwritten by a configuration import**, so an editor's change on production is lost at the next `config:import` unless the workflow accounts for it. That is either exactly what you want (wording that is a design decision) or exactly what you do not (wording that is editorial). On output the module is safe by default: formatted snippets render through their chosen text format, plain snippets are auto-escaped by Twig, and token replacements are HTML-escaped by core's token system.

---

- Store a strapline in one place and read it from a template.
- Let a content editor change a legal footnote without a deploy.
- Keep a phone number or address consistent across many pages.
- Manage an out-of-hours or seasonal notice as a single editable string.
- Separate *defining* a snippet (admin) from *editing its value* (editor) by permission.
- Provide the help sentence above a custom form as editable copy.
- Expose reusable text to Twig as `{{ contentSnippets.id }}`.
- Insert editable copy anywhere tokens are accepted via `[content_snippets:id]`.
- Read a snippet from custom PHP with `content_snippets_retrieve('id')`.
- Offer a formatted (WYSIWYG) snippet by picking a text format for it.
- Offer a numeric snippet (e.g. a threshold or count) with the Number type.
- Group related snippets under a labelled section on the editor page.
- Order snippets on the editor page with per-snippet weights.
- Give a dynamic, editor-controlled title to a menu local task via the ContentSnippetLocalTask plugin.
- Keep copy changes out of code review by moving them to editable config values.
- Ship default wording in code (config export) while allowing later edits.
- Replace scattered `t()` hard-coded strings with one central, editable source.
- Manage a cookie or consent notice's exact wording centrally.
- Keep a call-to-action or disclaimer identical wherever it appears.
- Let marketing update campaign copy without touching templates.
- Provide the same editable snippet to several different templates at once.
- Prototype with placeholder copy that non-developers can finalise later.
- Delete an obsolete snippet through a confirmation form that shows its current value.
- Rename-proof references: code points at a stable machine name, not at copy.
- Audit copy history through configuration version control.
