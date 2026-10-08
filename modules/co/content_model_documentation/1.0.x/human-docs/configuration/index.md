# Configuration

Content Model Documentation works as a set of reports the moment it's enabled, but
its settings form is where you decide **what** can be documented and **where**
exported documents are stored.

## Open the settings form

1. Log in as a user with the **Administer content model documentation** permission
   (an administrator by default).
2. Go to **Configuration → System → Content Model Documentation**, or navigate
   directly to `/admin/config/system/content_model_documentation`.

## Choose documentable entity types

The core setting controls **which entity types are documentable** — that is, which
parts of your site can have a Content Model Document attached. Enable the entity
types you care about (content types, vocabularies, media types, and so on). Fields
can be added to Content Model Documents as well, so your authored documentation can
carry whatever structured notes you need.

## Set the export module (for YAML export/import)

If you plan to export documents so they can travel with your code, set the **machine
name of the local custom module** that should contain the exported YAML files. This
tells the module where to write files when you run the export.

## Grant permissions

The module ships granular permissions at
`/admin/people/permissions/module/content_model_documentation`:

- **Administer content model documentation** — access this settings form.
- **View content model documentation** — see the reports.
- **Add / administer content model document entities** — create and manage the
  authored documents.

Grant the viewing permission to stakeholder roles who should read the docs, and
keep the administer/create permissions with your architects and developers.

## Exporting and importing documents

Once the export module is set, the workflow is:

- **Export** — create or edit a Content Model Document and save it, then run
  `drush content-model-documentation:export`. A YAML file is written into your
  configured local module (under `/cm_documents/`), keyed by the document's entity
  ID. Commit it like any other code.
- **Import** — documents are imported by their page alias using a `hook_update_N()`
  in your local module's `.install` file, calling
  `CmDocumentImport::import($aliases, $strict)`. With `$strict = TRUE` the update
  fails if any document is rejected; `FALSE` lets rejections pass while still
  counting the update as a success. The import runs when you execute `drush updb`.

> **Using DDEV?** Run the Drush commands with the `ddev` prefix from your host —
> `ddev drush content-model-documentation:export` — or without it inside `ddev ssh`.
