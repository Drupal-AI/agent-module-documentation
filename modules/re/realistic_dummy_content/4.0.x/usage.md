<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Realistic Dummy Content makes Devel's `devel_generate` produce demo content that looks real — portraits, stock photos and proper sentences supplied from files — instead of lorem-ipsum text and grey placeholder boxes.

---

Install both this module and Devel's `devel_generate` (`ddev composer require drupal/devel drupal/realistic_dummy_content`, then `ddev drush en realistic_dummy_content devel_generate`); the parent module pulls in its `realistic_dummy_content_api` submodule automatically. With that in place, generating content the normal Devel way (`drush devel-generate-content`, `drush devel-generate-users`, or the *Configuration → Development → Generate content* forms) yields articles with real stock images and body text, and users with real profile portraits — because a `hook_entity_presave` in the API module rewrites each generated entity's fields from a directory of example files. To use **your own** content, reproduce the directory layout `MYMODULE/realistic_dummy_content/fields/{entity_type}/{bundle}/{field_name}/` in a custom module and drop in `.txt` files (text) or `.jpg/.png/.gif` files (images), optionally with `*.format.txt` / `*.alt.txt` companion files for a body's text format or an image's alt text; if you want only your content, keep `realistic_dummy_content_api` enabled and disable the example `realistic_dummy_content` module. For scripted, ordered generation (for example *4 pages then 10 articles*), write a **recipe** class and run `drush generate-realistic` (alias `grc`). Content selection is random by default; flip the `realistic_dummy_content_api_rand` config value off for reproducible output. The module is a **beta** in the Development package and its own description says *"Do not enable on production sites"* — keep it in `require-dev` and use it in development, CI and demo environments only.

---

- Generate realistic demo articles with stock photos instead of grey boxes.
- Give devel-generated users real profile portraits.
- Review a page design against real-length headlines and body text.
- Populate a fresh site for a stakeholder or sales demo.
- Fill a development environment with plausible content.
- Supply your own images/text by mirroring the `realistic_dummy_content/fields/...` directory.
- Add example content to a custom module for its own demo.
- Set a specific text format for generated body fields via `*.format.txt` files.
- Set alt text on generated images via `*.alt.txt` files.
- Script a fixed sequence of entities with a recipe and `drush generate-realistic`.
- Regenerate a bundle from scratch using the recipe `kill => TRUE` option.
- Produce reproducible fixtures by switching selection from random to sequential.
- Seed content for automated or manual QA testing.
- Test Views, pagers and search against meaningful, volume content.
- Check responsive image layouts with real photographs.
- Populate a training or documentation site with believable data.
- Keep only your custom content by disabling the example module and keeping the API submodule.
- Add realistic dummy support for a custom field type via the manipulator alter hook.
- Mark non-devel content as "dummy" for replacement via the dummy-detection hook.
- Prototype a content model quickly before real content exists.
