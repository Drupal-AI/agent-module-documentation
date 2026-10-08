<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Field Example is the demonstration submodule of Extra Field: eight ready-to-copy plugin classes (five `ExtraFieldDisplay`, three `ExtraFieldForm`) that show every base class, the bundles wildcards, dependency injection, cacheability, multilingual handling and custom form validation.

---

The submodule ships no config, no services and no settings — it only registers plugins. The display plugins are `all_nodes` (`ExtraFieldDisplayBase`, `bundles = node.*`, `weight = -30`, `visible = true`, prints static markup), `article_only` (`node.article`, static markup), `formatted_field` (`ExtraFieldDisplayFormattedBase`, returns three markup items with the label "Three items" displayed *above*, demonstrating `#is_multiple`), `multilingual_field` (concatenates the labels of `field_tags`, adds each term as a cacheable dependency, overrides `getLabel()`, `getLabelDisplay()` to *inline*, `isTranslatable()` to TRUE and `getLangcode()` from the source field, and sets `$this->isEmpty = TRUE` when there is nothing to print) and `ExampleWithDependencyInjection` (implements `ContainerFactoryPluginInterface` to inject `request_stack` and print the request scheme). The form plugins are `example_markup` (`node.*`, `visible = true`, three ways of emitting markup on a form: `#markup`, a `container`, an `item`), `example_custom_submit` (`node.*`, `weight = 100`, `visible = true`, adds an extra submit button with its own handler that shows a message) and `example_custom_input` (`user.user`, `visible = true`, a "Voucher code" textfield with an `#validate` callback that looks up a `voucher` entity and writes its id into a hidden entity-reference field). `extra_field_example_install()` clears the discovery cache bin so the new pseudo-fields show up immediately. Two caveats: `ExampleWithDependencyInjection` declares the **same** plugin id `article_only` as `ExampleArticle`, so only one of them survives discovery; and `example_custom_input` references a `voucher` entity type that does not exist in Drupal core, so its validation callback is illustrative code, not something to enable on a real site.

---

- Copy `ExampleAllNodes` as the starting point for a plugin that runs on every node bundle.
- Copy `ExampleArticle` when the extra field belongs to exactly one bundle.
- Copy `ExampleFormattedField` when the output must look and theme like a real field.
- Learn how to emit multiple items so `#is_multiple` and `#items` deltas are set correctly.
- Copy `ExampleMultilingualField` to combine data from an existing reference field into one line.
- See how to attach `CacheableMetadata` from referenced entities so the extra field invalidates correctly.
- See how to make an extra field language-aware (`isTranslatable()` + `getLangcode()`).
- See how to suppress the field wrapper for empty output via `$this->isEmpty = TRUE`.
- Copy `ExampleWithDependencyInjection` as a template for injecting a service into a plugin.
- Copy `ExampleMarkup` to learn the three usable markup patterns inside an entity form.
- Copy `CustomSubmit` to add an extra submit button with its own handler to node forms.
- Copy `ExampleCustomInput` as the pattern for a non-stored input that resolves to a real field value.
- Demonstrate to a team how `visible = true` makes a pseudo-field appear on existing displays.
- Demonstrate how `weight` orders an extra field relative to real fields on *Manage display*.
- Verify an Extra Field installation quickly: enable the example and check the Article displays.
- Use it as a smoke test after upgrading Extra Field to a new major version.
- Practise `hook_extra_field_display_info_alter()` against `all_nodes` (the api.php example targets it).
- Show the difference between `ExtraFieldDisplayBase` and `ExtraFieldDisplayFormattedBase` side by side.
- Use `{{ content.extra_field_all_nodes }}` in a Twig template to see explicit extra-field printing.
- Illustrate the duplicate-plugin-id pitfall (`article_only` declared twice) in a code review.
- Train site builders to enable/disable extra fields per view mode without touching code.
- Provide a scratch plugin to test that discovery caching (`drush cr`) behaves as expected.
