<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloner Examples (cloner_examples) — agent index

Submodule of **[cloner](../../../../agent/start.md)**. Worked example plugins to read and copy when writing
your own cloners. Not intended for production. Package `Development`. Depends on `cloner`, `node`,
`image`. Core `^9.5 || ^10 || ^11`.

## What it ships (from source)

- **`src/Plugin/Cloner/ContentEntity/NodeArticle.php`** — `@ClonerContentEntity(id =
  "cloner_examples_node_article")`. `cloneEntity()` only acts when a `form_state` is in `$context`:
  sets the clone's title from the form's `new_title` value. (No form_state ⇒ verbatim duplicate.)
- **`src/Plugin/Cloner/ConfigEntity/ImageStyle.php`** — `@ClonerConfigEntity(id =
  "cloner_example_image_style")`. Sets a new id + label on the destination; from `form_state` when
  present (`machine_name`, `new_title`), else `{id}_cloned` / same label. Uses the base's
  `getDefinitionKey()` to find the id/label keys.
- **`src/Plugin/Cloner/Form/NodeArticleCloneForm.php`** — `@ClonerForm(id =
  "cloner_examples_node_article_clone_form", cloner_plugin_type = "content_entity", cloner_plugin_id
  = "cloner_examples_node_article", entity_operation_label = "Clone")`. `isApplicable()` →
  `node` + bundle `article`. Form adds a required `new_title`; validate rejects a title equal to the
  original.
- **`src/Plugin/Cloner/Form/ImageStyleCloneForm.php`** — `@ClonerForm(id =
  "cloner_examples_image_style", cloner_plugin_type = "config_entity", cloner_plugin_id =
  "cloner_example_image_style", entity_operation_label = "Clone")`. `isApplicable()` →
  `image_style`. Form adds required `new_title` + `machine_name`; validate rejects unchanged
  title/id.
- **`cloner_examples.module` + `src/Hook/Form/NodeArticleEditFormAlter.php`** —
  `hook_form_node_article_edit_form_alter` adds a "Clone" submit button to the article **edit** form,
  `#access` gated on `access all entity cloner || access node cloner`. Its handler
  `cloneNodeArticleSubmit()` shows the programmatic path: `createInstance('cloner_examples_node_article')`,
  `createDuplicate()`, `cloneEntity()`, `save()`, redirect to the clone. Demonstrates that content/
  config cloner plugins work standalone, without the generated clone route.

## No config, permissions, schema, install hooks, or services of its own.

See the parent module's [plugins/writing-plugins.md](../../../../agent/plugins/writing-plugins.md) and
[architecture/clone-flow.md](../../../../agent/architecture/clone-flow.md) for the plugin contracts these
examples implement.
