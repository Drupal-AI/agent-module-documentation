<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Multilingual (canvas_multilingual) — agent index

Multilingual support for **Drupal Canvas**. Version **1.0.0-beta1**, `lifecycle: experimental`.
Core `^11`. Depends on `canvas`, `content_translation`, `language`.

**Read its description as a list of bugs** — language-prefixed URLs, autosave translation *fix*,
preview title *fallback*, translation *guards*. Each names something that does not work when a page
builder meets translations: layout is stored per entity, translations are separate entities, and
every visual editor has to decide what a layout means across languages.

**Experimental + beta on a hard problem.** Verify the behaviours you depend on — whether layout is
shared or per-language, what autosave in one language does to another, what a translator sees in
preview — rather than assuming.

**Documented from source** — `canvas` could not be kept enabled (SDC assertion fatal, characterised
in wave 85 and recurring here against a different module set).