Typed Entity UI is a developer helper that adds an admin explorer for the Typed Entity module, letting you browse which wrapper and renderer classes apply to each entity-type/bundle pair and inspect their PHP class hierarchy.

---

The submodule adds an "Explore Typed Entity" admin page at `/admin/config/development/typed-entity` (route `typed_entity_ui.explore`, under *Configuration → Development*). You pick an entity type and bundle, and it renders the associated typed repository together with its wrapper and renderer `ClassWithVariants` (fallback + variants), plus a reflection-based summary of each PHP class: its namespace, `final`/`class` keyword, doc comment, parent class, interfaces, source file path, and — for repositories — the reconstructed `#[TypedRepository(...)]` attribute source. A details route (`/admin/config/development/typed-entity/{typed_entity_id}`) drills into a single repository. Everything is gated by the single permission it defines, **`explore typed entity classes`**. The module ships three theme hooks (`php_class_info`, `class_with_variants`, `php_class_summary`) with Twig templates and admin CSS/JS, and stores one State flag (`typed_entity_ui.hide_video_thumbnail`) for dismissing an intro video (cleared on uninstall). It has no configuration entities, no plugins, and no Drush; it depends on `typed_entity` and is purely a read-only inspection aid for developers.

---

- Browse every entity-type/bundle pair and see which typed repository (if any) handles it.
- Inspect the wrapper `ClassWithVariants` for a bundle: its fallback class and variant classes.
- Inspect the renderer variants declared for a repository.
- Read a repository's reconstructed `#[TypedRepository(...)]` attribute without opening the source.
- View a class's parent class and implemented interfaces at a glance (reflection summary).
- Find the source file path of a wrapper/renderer/repository class quickly.
- Confirm that a newly added repository plugin is discovered and registered.
- Verify which wrapper variant is expected to apply for a bundle before writing code.
- Onboard a developer to a project's typed-entity architecture visually.
- Drill into a single repository's details via `/admin/config/development/typed-entity/{id}`.
- Check the doc comment of a wrapped-entity class from the admin UI.
- Audit which bundles still lack a typed repository.
- Restrict access to the explorer with the `explore typed entity classes` permission on a role.
- Grant a developer role access to the Typed Entity explorer for diagnostics.
- Use it alongside the `typed_entity_example` submodule to see the Article/User classes rendered.
- Sanity-check that a `ClassWithVariants` fallback resolves (the UI shows "- None available -" when it does not).
- Explore class hierarchy while debugging why a particular wrapper is (not) selected.
- Provide a visual reference during code review of typed-entity plugins.
- Confirm a repository's entity type / bundle mapping matches expectations.
- Teach the Typed Entity pattern using a live site rather than reading code.
