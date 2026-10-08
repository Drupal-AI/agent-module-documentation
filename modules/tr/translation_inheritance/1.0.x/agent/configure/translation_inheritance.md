<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Translation Inheritance

## Setup
1. Enable `translation_inheritance` (deps: `language`, `content_translation`) and make the target bundle translatable.
2. Add the **Inherit translation** field (`InheritTranslationItem`) to the bundle via Field UI; use `InheritTranslationWidget` on the form display.
3. Adjust module options at `/admin/config/content/translation-inheritance` (permission `administer translation inheritance`).

## Authoring
- On a non-default translation, editors set the field's `source_language` to inherit that language's content. The field is hidden on the default translation (`form_alter`).

## Rendering
- `TranslationInheritance::getCorrectTranslation()` follows `source_language` — possibly through several hops — to find the translation actually rendered; `hook_entity_view_alter` substitutes it at display time.

## Notes
- Inheritance can be recursive; the resolver loops until it reaches a translation with no source language.
