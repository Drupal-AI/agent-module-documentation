<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle form examples (bundle_form_examples) — agent index

Submodule of **bundle_form**. Ships example `@BundleForm` plugins so you can see the per-bundle form override pattern and copy it. No config, routes, permissions, services, or hooks of its own — only plugin classes.

- **Version:** 1.0.x (1.0.2). Core `^11 || ^12`. Package `AB`. Requires **bundle_form** (extends `BundleFormPluginBase`); paragraph example is meaningful only when **paragraphs** is installed.
- Parent module → [../../../../agent/start.md](../../../../agent/start.md); plugin API → [../../../../agent/api/plugins.md](../../../../agent/api/plugins.md).

## The example plugins (`src/Plugin/BundleForm/`)

| Class | id | entity_type | bundle | weight | overrideForm does |
|---|---|---|---|---|---|
| `Node/FirstArticleForm` | `bundle_form_examples_first_article` | node | article | -10 | `$form['title']['#access'] = TRUE` (runs first) |
| `Node/ArticleForm` | `bundle_form_examples_article` | node | article | 10 | `$form['title']['#access'] = FALSE` (runs after) |
| `Node/PageForm` | `bundle_form_examples_page` | node | page | 10 | `$form['body']['#access'] = FALSE` |
| `Term/TagsForm` | `bundle_form_examples_tags_form` | taxonomy_term | tags | 10 | `$form['name']['#access'] = FALSE` |
| `Paragraph/Type1Form` | `bundle_form_examples_type_1_form` | paragraph | type_1 | 10 | `$form['subform']['field_test']['#access'] = FALSE` |

## What it teaches

- **Weight ordering:** the two `article` plugins run in ascending weight (-10 then 10). Because `ArticleForm` (weight 10) runs last, on the Article form the title ends up hidden — a later, higher-weight plugin overrides an earlier one on the same bundle.
- **Paragraph access:** `Type1Form` reads the widget context via `$form_state->get('context')` and mutates `$form['subform']`, since paragraph plugins receive the subform element (not a top-level entity form) and no `$entity`.
- All examples only toggle `#access`; they add no fields and change no access rules — core still enforces entity/field access. Use them as templates, not as production behavior.
