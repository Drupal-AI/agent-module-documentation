A demonstration module that installs ready-made entity browsers, a sample content type, and fields so you can see Entity Browser working end to end.

---

Entity Browser example ships default configuration only — it has no code beyond a demo. On install it creates an "Entity browser test" content type (`entity_browser_test`) wired with several reference fields: multi-file browsers, an image browser, an over-AJAX file browser, and a node reference browser. It provides four preconfigured browsers (`test_files`, `test_files1`, `test_files_ajax`, `test_nodes`) plus two supporting Views (`files_entity_browser`, `nodes_entity_browser`) that back the "view" widgets. Together these show the modal/iframe displays, tabbed widget selectors, upload and view widgets, and multi-step selection working against real fields. It is meant as a learning and testing aid — a working reference you copy from — not something to enable on production. Depends on Entity Browser plus Views, Field, File, Node, Image, and Path.

---

- See a fully working entity browser without configuring one by hand.
- Learn how a `view` widget is wired to a View with an Entity Browser display.
- Inspect the exported `entity_browser.browser.*` config as copyable examples.
- Try a modal file browser on a real image field.
- Try an AJAX-loaded file browser widget.
- Try a node reference browser backed by a curated View.
- Study how field widgets (`entity_reference_browser`, file browser) are configured on a form display.
- Demonstrate multi-value selection and reordering to stakeholders.
- Use the `entity_browser_test` content type as a scratch space for QA.
- Copy the sample Views (`files_entity_browser`, `nodes_entity_browser`) into your own project.
- Verify Entity Browser works after an upgrade using known-good config.
- Reproduce bugs against a standard configuration when filing issues.
- Teach editors the browse/select/submit flow in a sandbox.
- Compare upload vs. view widget behavior side by side.
- Prototype a picker UX quickly before building the real one.
- Explore how display plugins (modal/iframe) differ visually.
- Reference for setting field cardinality against a browser.
- Demonstrate image thumbnail field widget display.
- Provide a baseline for automated/functional tests.
- Onboard developers new to the Entity Browser framework.
