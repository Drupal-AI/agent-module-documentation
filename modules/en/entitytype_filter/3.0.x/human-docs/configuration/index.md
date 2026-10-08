# Configuration

Entity Fields Search has no persistent settings to save — instead of a settings
form, it gives you an interactive **search page** where you filter for fields and
optionally export the results. This page walks through that form field by field.

## Open the search page

1. Log in as an administrator.
2. Go to **`/admin/entitytypes-filter`**.

You'll land on the **Entity Fields Search** page.

## The search form, field by field

- **Entity Type** — select which kind of entity to inspect: Content Types, Block
  Types, Paragraph Types, Media Types, or a custom entity type. This determines
  which bundles and fields the rest of the form searches.
- **Search Entity Type By Title** — type the name (title) of the specific bundle
  or entity you want. This narrows the results to the matching bundle rather than
  every bundle of the selected type.
- **Field Type** *(optional)* — narrow the results further to a single field type
  (for example only text, entity reference, or image fields). Leave it empty to
  list all field types.
- **Search** — click this button to run the query. The page then lists every
  field attached to the matching entity/bundle, showing the field name, label,
  and type.

## Reading the results

After you click **Search**, all related fields for the selected entity and bundle
appear together on the one page — so you can understand the field configuration at
a glance without opening each field's own settings page.

## Export to CSV

The filtered field list can be exported as a **CSV file**. The export includes the
entity type, bundle, field name, field label, and field type for each row —
useful for audits, migration planning, refactoring, and documentation. Run a
search first so the export reflects the filters you have applied.
