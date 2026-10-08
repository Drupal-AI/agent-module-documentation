<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Language Display provides field formatters that surface language information about translated content — the entity's original language and how many translations exist — and overrides the node view builder to support language-aware display.
---
The module ships two field formatters, `OriginalLanguageFormatter` (renders the source/original language of the content) and `OriginalLanguageTranslationCounterFormatter` (adds a count of available translations), plus a `LanguageDisplayNodeViewBuilder` that it swaps in for nodes via `hook_entity_type_alter()`. These let a site show, in the rendered display, which language a piece of content was authored in and how many translations are available, rather than that logic being hard-coded. Note the module's README warns the language formatter was historically hard-coded in core and references a core patch; treat this project as alpha (2.1.0-alpha1) and verify behaviour on your core version.

Setup: enable the module (requires core `language`), then on a translatable entity's *Manage display* assign the Original Language / Translation Counter formatters to the relevant field(s). Styling is provided by the `language-display` CSS library.
---
- Show the original/source language of a node
- Display a count of available translations
- Add language metadata to a rendered entity display
- Override the node view builder for language-aware display
- Assign the Original Language formatter on Manage display
- Assign the Translation Counter formatter on Manage display
- Indicate to visitors which language content was authored in
- Style language info via the provided CSS library
- Support multilingual sites that expose translation status
- Surface translation availability on content pages
- Present source-language badges on translated nodes- Add original-language badges to article displays
- Communicate translation coverage to editors
- Expose translation counts on listing displays
- Configure formatters per view mode
- Support editorial review of multilingual content
