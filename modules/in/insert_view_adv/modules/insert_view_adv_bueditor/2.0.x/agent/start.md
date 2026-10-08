# Advanced Insert View BUEditor Integration — agent index

Glue submodule of **insert_view_adv**. Adds a "Views Embed" button to the **BUEditor** editor
so editors can insert an Advanced Insert View `[view:...]` token from a dialog. No config,
routes, permissions or schema.

- **The BUEditor plugin and how the button/library are wired** →
  [api/bueditor-plugin.md](api/bueditor-plugin.md)

Key facts:
- Requires `insert_view_adv` **and** the contrib `bueditor` project.
- Defines one plugin: `@BUEditorPlugin(id="drupalviews", label="Embedded Views")`, class
  `Drupal\insert_view_adv_bueditor\Plugin\BUEditorPlugin\DrupalViews`.
- Button id `drupalviews` ("Views Embed"); JS library `insert_view_adv_bueditor/drupalviews`
  (depends on `bueditor/drupal.bueditor`).
- **Not enable-able on this site:** the `bueditor` contrib project is not installed here, so
  live introspection/execution eval tiers are omitted (see `eval/evals.json`).
