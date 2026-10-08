A one-file submodule of Better Entity Reference that applies the demo_content recipe on install so an evaluation sandbox lands with a ready-to-try demo.

---

Better Entity Reference simplytest.me demo exists because evaluation sandboxes such as simplytest.me can only enable a module — they cannot run `drush recipe:apply` or take a config file from the project. Its `hook_install` (`better_entity_reference_simplytest.install`) locates the parent module's `recipes/demo_content` and runs it via `RecipeRunner::processRecipe()`, producing a *BER demo* content type with one field per Better widget. The parent module's `info.yml` lists this module under the simplytest.me `simplytest_dependencies` convention so a sandbox enables it automatically. It creates no content, and if the `ber_demo` content type already exists it skips quietly with a status message rather than failing (recipes throw when re-applied). It depends on `better_entity_reference` and is for evaluation only, not production.

---

- Get a working demo of every Better Entity Reference widget on a simplytest.me sandbox by ticking one checkbox.
- Reproduce, inside a sandbox, the same result as running `drush recipe:apply .../recipes/demo_content` on a local site.
- Land on a sandbox with the *BER demo* content type already built, ready to add a node at `/node/add/ber_demo`.
- Learn the pattern for shipping a simplytest-friendly demo module that applies a recipe on install.
- Safely re-enable the module without an error when the demo content type is already present.
