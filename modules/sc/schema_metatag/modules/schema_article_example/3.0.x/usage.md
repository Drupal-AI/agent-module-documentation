A demonstration submodule showing how to extend Schema.org Metatag with additional custom fields/tags, using Article as the worked example.

---

This is an example/developer module, not something you run in production. It sits on top of `schema_article` and illustrates the mechanics of adding extra Schema.org properties to an existing type: defining new Metatag Tag plugins, wiring them to a group, choosing the right PropertyType, and having the values roll up into the page's JSON-LD. Read its source alongside `schema_metatag`'s base classes when you need to build your own per-type submodule or add properties Google has newly introduced. Enable it only in a development environment to inspect the generated markup. It depends on `schema_article`.

---

- Learn how to add a custom property to an existing Schema.org type.
- See a reference implementation of a Metatag Tag plugin.
- Study how a Tag maps to a PropertyType plugin.
- Copy the pattern to create your own schema submodule.
- Understand how tokens flow into JSON-LD values.
- Inspect generated `application/ld+json` output during development.
- Prototype support for a Schema.org type not yet shipped.
- Test how `hook_metatag_tags_alter()` overrides behave.
- Explore extending Article with extra fields.
- Verify custom structured data in the Rich Results Test.
- Serve as a teaching aid for onboarding developers.
- Compare a minimal submodule against the full schema_article.
- Experiment with multi-value and nested sub-properties.
- Validate a new property before contributing it upstream.
- Demonstrate the group/tag/property-type three-part structure.
- Confirm your dev environment renders schema JSON-LD correctly.
