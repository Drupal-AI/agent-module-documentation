Hidden helper for the beer example: provisions the destination content type, fields, vocabulary and comment type the migration writes into, and seeds the source data tables.

---

Migrate Example Setup exists to keep the *site configuration* the beer example needs separate from the *migration definitions* themselves, mirroring real projects where destination structures pre-exist the migration. It installs the article-style content type, fields (including image/text/options fields), a taxonomy vocabulary and a comment type, and populates the example source tables that `migrate_example`'s custom source plugins read from. It is marked `hidden: true`, so it does not appear in the normal module list — it is pulled in automatically as a dependency of `migrate_example`. On its own it does nothing runnable; it is purely scaffolding for the demo. You never keep it in a production site.

---

- Provide the destination content type the beer nodes migrate into.
- Install the fields (text, image, options) the example maps onto.
- Create the taxonomy vocabulary used by `beer_term`.
- Set up the comment type consumed by `beer_comment`.
- Seed the example source database tables the migration reads.
- Demonstrate separating destination config from migration config.
- Show why a migration often depends on a "setup" module.
- Illustrate use of `hidden: true` for helper/support modules.
- Serve as a template for your own migration's setup/scaffold module.
- Study how config in `config/install/` provisions destination structures.
- Understand what must exist before `drush migrate:import` will succeed.
- See how images/text/options field types are declared for a migration target.
- Learn how example fixtures are bundled with a demo migration.
- Reference when debugging "destination field does not exist" migration errors.
- Reuse the pattern to make repeatable, config-driven migration environments.
- Understand the dependency chain `migrate_example` → `migrate_example_setup`.
