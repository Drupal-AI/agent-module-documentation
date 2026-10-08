# entity_browser_example — agent start

Demo/config-only submodule of [entity_browser](../../../entity_browser/2.15.x/agent/start.md).
No code, no plugins, no config UI. Enabling it installs default config:

- Content type `entity_browser_test` with reference fields (files, image, nodes, AJAX files).
- Four browsers: `test_files`, `test_files1`, `test_files_ajax`, `test_nodes`
  (`config/install/entity_browser.browser.*.yml`).
- Two backing Views: `files_entity_browser`, `nodes_entity_browser`.

Use it as a working reference: read the installed config, then copy patterns into your
own browsers. To build/configure real browsers see the parent module's
[configure/browsers.md](../../../entity_browser/2.15.x/agent/configure/browsers.md).
Nothing here to extend or call programmatically — start.md alone suffices.
