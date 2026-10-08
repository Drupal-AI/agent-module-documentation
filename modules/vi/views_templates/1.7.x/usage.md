Views Templates is a developer API that lets modules ship pre-built Views as reusable templates and clone them into real, editable View entities.

---

Views Templates reintroduces the "dynamic default views" pattern: instead of shipping a View as fixed `config/install` YAML, a module defines a `ViewsBuilder` plugin (annotation `@ViewsBuilder`, discovered from `Plugin/ViewsTemplateBuilder`) that builds a View programmatically or clones one from a template file. Two base classes do the work: `ViewsBuilderBase`, whose `createView()` you override to assemble a `View` entity in code, and `ViewsDuplicateBuilderBase`, which loads a `*.yml` Views export from the providing module's `views_templates/` directory (via the `views_templates.loader` service) and runs token-style replacements to customise it. Site builders create a concrete View from any registered template at **Admin → Structure → Views → Add view from template** (`/admin/structure/views/template/list`), which lists every builder whose template exists and links to a form (`ViewTemplateForm`) that asks for a label, machine name and description, then saves a new View and redirects to its edit form. Replacements declared in the plugin's `replace_values` annotation are converted to `__UPPERCASE` placeholders and substituted recursively (including keys, and `NULL` to delete keys) so one template can spawn many variants. Builders can also add extra form fields by overriding `buildConfigurationForm()` and mutate the loaded array in `alterViewTemplateAfterCreation()`. The plugin manager exposes an alter hook, `views_template_builder_info`. The module ships no config, permissions (routes use core `administer views`), or Drush commands — it is purely scaffolding consumed by other modules.

---

- Ship a starter View with your module that users can clone and then freely edit, without it being overwritten on config sync.
- Provide several ready-made report or listing Views as templates for site builders to pick from.
- Clone an existing exported View (`*.yml`) into a new View entity from the admin UI.
- Define a View entirely in PHP by extending `ViewsBuilderBase` and overriding `createView()`.
- Build a View from a YAML template by extending `ViewsDuplicateBuilderBase` and setting `view_template_id`.
- Offer the same base template in multiple variants using `replace_values` placeholder substitution.
- Let one template generate many plugins via a derivative deriver (`derivative` annotation key).
- Substitute a title, machine name or field id into a cloned template with `__PLACEHOLDER` tokens.
- Remove keys from a template during cloning by mapping a replacement value to `NULL`.
- Add extra configuration fields to the create-from-template form via `buildConfigurationForm()`.
- Post-process the loaded template array (e.g. set pager items-per-page) in `alterViewTemplateAfterCreation()`.
- Give editors an "Add view from template" local action on the Views list page.
- Load a template's YAML from a module's `views_templates/` folder with the `views_templates.loader` service.
- Set the `base_table` of a code-built View from the plugin annotation.
- Show a browsable table of every available template with its admin label and description.
- Alter or add third-party template builder definitions with `hook_views_template_builder_info_alter()`.
- Seed installation profiles or distributions with optional Views users can opt into.
- Keep default Views out of active configuration so they don't reappear after deletion.
- Convert a hand-exported View into a distributable template by moving its YAML into `views_templates/`.
- Redirect the user straight into the Views UI edit form after a template is instantiated.
- Programmatically create the View without saving it, so calling code can adjust it first.
- Gate template creation behind the core `administer views` permission.
- Provide entity-specific starter Views (e.g. a node listing) tailored to a `base_table`.
- Bootstrap demo or example Views for documentation or training environments.
