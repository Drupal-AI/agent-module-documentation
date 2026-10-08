# Configuration

Structured Data Generator works as soon as it is enabled — the built-in breadcrumb
generator is on by default. The settings form's job is to let you turn individual
generator plugins on or off.

## Open the settings form

1. Log in as a user with the **Administer structured_data_generator** permission
   (a restricted permission, not one you would grant broadly).
2. Go to **Configuration → Development → Structured Data Generator**
   (`/admin/config/development/structured_data_generator`).

## Enable or disable generators

The form lists the structured-data generators available on your site — the bundled
`breadcrumb_sdg` breadcrumb generator, plus any generators added by other modules.
Tick or untick each one to control whether it emits its structured data into the
page head. A disabled generator is skipped entirely when the page is built.

For example, if you handle breadcrumb structured data through another SEO module,
you can disable the built-in breadcrumb generator here to avoid emitting it twice.

## Adding your own generators

New structured data comes from writing a generator plugin (a developer task) — a
small class in your module's `src/Plugin/StructuredDataGenerator/` directory,
annotated with `@StructuredDataGenerator`, that returns a Schema.org type built
with the bundled `spatie/schema-org` builder. Once such a plugin exists, it shows
up on this form so you can enable or disable it like the others. There is a code
example in the sibling [`agent/extend/plugins.md`](../../agent/extend/plugins.md)
doc.

## Save

Save the form to apply your choices. Reload a page and view its source (or run
Google's Rich Results Test) to confirm the expected generators are emitting and the
disabled ones are not.
