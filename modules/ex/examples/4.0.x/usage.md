Examples for Developers is a collection of 31 heavily-documented example submodules, each demonstrating one Drupal core API (forms, AJAX, batch, blocks, entities, plugins, queues, theming, and more) so developers can learn by reading and running working, tested code. The top-level `examples` module itself is a stub that only adds an "Examples" toolbar tray linking to whichever example submodules are installed.

---

The `examples.module` file is intentionally minimal: it depends only on core `toolbar` and implements `hook_toolbar()` (`examples_toolbar()`) to build an "Examples" tray listing each installed example submodule via a hard-coded route map in `_examples_toolbar_routes()`, plus an "Enable Examples" link to the Extend page. The real content is in the 31 submodules under `modules/`, each a self-contained tutorial for a specific subsystem — `action_example`, `ajax_example`, `batch_example`, `block_example`, `cache_example`, `config_entity_example`, `config_simple_example`, `content_entity_example`, `cron_example`, `dbtng_example`, `email_example`, `events_example`, `field_example`, `field_permission_example`, `form_api_example`, `hooks_example`, `image_example`, `js_example`, `menu_example`, `node_type_example`, `page_example`, `pager_example`, `plugin_type_example`, `queue_example`, `render_example`, `session_example`, `stream_wrapper_example`, `tabledrag_example`, `tablesort_example`, `testing_example`, and `theming_example`. Each submodule is enabled independently; the parent has no configuration page, no permissions, no Drush, and no config schema. A shared `DescriptionTemplateTrait` (`src/Utility/`) lets each example render its intro page from a translatable Twig `description.html.twig`. This is a learning/reference project: install the specific example you want to study, read its richly commented code and tests, then uninstall it. It is not meant to remain enabled on production sites.

---

- Learn the Form API by studying and running `form_api_example`.
- See how AJAX callbacks and AJAX-enabled forms work via `ajax_example`.
- Learn the Batch API with `batch_example`.
- Study custom block plugins with `block_example`.
- Understand the Cache API using `cache_example`.
- Learn config entities vs simple/translatable config via `config_entity_example` and `config_simple_example`.
- Build a content entity type by example with `content_entity_example`.
- See cron and queue patterns in `cron_example` and `queue_example`.
- Learn the database abstraction layer (DBTNG / dynamic queries) via `dbtng_example`.
- Study sending and altering mail with `email_example`.
- Learn event subscribers and dispatching with `events_example`.
- Create a custom field type/widget/formatter via `field_example`.
- See field-level access control in `field_permission_example`.
- Learn implementing, defining, and invoking hooks with `hooks_example`.
- Study image styles and image.module APIs via `image_example`.
- Attach and use JavaScript with `js_example`.
- Build routed pages and menu links with `page_example` and `menu_example`.
- Implement pagers and table sorting with `pager_example` and `tablesort_example`.
- Define a custom plugin type and manager via `plugin_type_example`.
- Learn render arrays with `render_example`.
- Use the session and private tempstore with `session_example`.
- Implement a stream wrapper with `stream_wrapper_example`.
- Build draggable tables with `tabledrag_example`.
- Provide a node content type from a module with `node_type_example`.
- Define custom actions bound to triggers with `action_example`.
- Write Unit/Kernel/Functional tests by example with `testing_example`.
- Theme output (hooks, templates, preprocess) via `theming_example`.
- Reuse `DescriptionTemplateTrait` to render a translatable Twig intro page in your own module.
- Use the Examples toolbar tray to jump between the enabled example pages.
- Copy any submodule as scaffolding for your own custom module.
