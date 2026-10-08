Hidden helper for the advanced example: provisions the destination content structures, fields and REST configuration the advanced migration writes into.

---

Migrate Advanced Example Setup is the scaffolding counterpart to `migrate_example_advanced`, keeping site configuration separate from the migration definitions. It installs the content type, fields (text, image), taxonomy vocabulary and comment type the advanced migration targets, and enables/configures REST so the example's remote-source scenarios work. It is `hidden: true` and enabled automatically as a dependency of `migrate_example_advanced`. It contains no runnable migrations itself — only the destination structures and fixtures needed by the demo. Never keep it enabled in production.

---

- Provide the destination content type for the advanced example.
- Install the fields the advanced migration maps onto.
- Create the taxonomy vocabulary and comment type used by the demo.
- Configure REST support the advanced example relies on.
- Demonstrate separating destination setup from migration config.
- Illustrate `hidden: true` for helper modules.
- Show what must exist before an advanced `url`/XML migration runs.
- Serve as a template for provisioning a REST-enabled migration target.
- Study `config/install/` fixtures for advanced destinations.
- Understand the dependency chain `migrate_example_advanced` → this module.
- Reference when debugging missing-destination errors in the advanced demo.
- Reuse the pattern for repeatable advanced-migration environments.
- See how core `rest` is wired into an example.
- Learn how image/text fields are declared for an advanced target.
- Bundle fixtures alongside a specialized demo migration.
- Onboard developers to advanced migration setup requirements.
