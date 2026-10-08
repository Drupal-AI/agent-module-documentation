<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Label lets site builders define human-friendly singular and plural labels — including definite ("the") and indefinite ("a/an") article variants — for each content entity bundle, then render them anywhere via tokens or a Twig function.
---
The module adds a "Label settings" group to every bundle edit form (any `ConfigEntityBundleBase` such as node types, vocabularies, media types) and stores the five values (`label_singular`, `label_singular_definite_article`, `label_singular_indefinite_article`, `label_plural`, `label_plural_definite_article`) as third-party settings on the bundle config entity. It also extends the config schema so the values are properly typed/translatable. A helper `entity_label_render($entity, $type)` reads the setting for the entity's bundle, `strip_tags()`s it and statically caches it.

Output is available two ways: `hook_token_info`/`hook_tokens` expose tokens like `[node:label:singular]`, `[node:label:plural-definite-article]` on every content entity type with a bundle; and a Twig extension registers `entity_label(entity, 'plural')` for use in templates. There are no routes, permissions or services beyond the Twig extension, and no external calls — it is a purely presentational metadata module.
---
- Set a singular label (e.g. "Article") on a content type.
- Set a plural label (e.g. "Articles") on a content type.
- Define the definite-article form ("the article").
- Define the indefinite-article form ("an article").
- Define a plural definite form ("the articles").
- Configure labels on a taxonomy vocabulary.
- Configure labels on a media type.
- Configure labels on any custom bundle config entity.
- Print a bundle label in a Twig template with `entity_label(node)`.
- Print the plural form: `entity_label(node, 'plural')`.
- Use `[node:label:singular]` token in a message or view.
- Use `[node:label:plural-definite-article]` in emails.
- Localise labels through the config translation UI.
- Build UI copy like "Add a new {{ entity_label(node,'singular_indefinite_article') }}".
- Call `entity_label_render($entity, 'plural')` from custom PHP.
- Keep consistent terminology across templates without hardcoding strings.
- Provide editor-facing wording distinct from the machine bundle name.
