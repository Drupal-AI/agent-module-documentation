# Configuration

Custom Field has no admin settings page. You configure it the same way you
configure any field — through the Field UI — but with one extra step: defining
the **columns (subfields)** that make up the field. There are three stages:
define the columns, choose a widget for each on the form, and choose a formatter
for each on display.

## 1. Add the field and define its columns

1. Go to the entity you want to extend — for a content type, **Structure →
   Content types → (your type) → Manage fields** — and click **Add field**.
2. Choose **Custom** (in the *Field* category) as the field type, give it a
   label, and continue.
3. On the **field storage settings** you build the list of columns. Each column
   needs a machine name and a **type** — the kind of data it holds. Available
   column types include: `string`, `string_long`, `integer`, `decimal`, `float`,
   `boolean`, `email`, `telephone`, `uri`, `color`, `map`, `map_string`,
   `datetime`, `daterange`, `time`, `time_range`, `duration`, `entity_reference`,
   `file`, `image`, `link`, and `uuid` (plus `viewfield` if you enabled that
   submodule). Some types take extra options — a `string` column has a maximum
   length, a `datetime` column has a date/time type, and so on.
4. Set the field's **cardinality** (how many values it may hold) as usual — one
   Custom Field can still be multi-value, so a "team member" field with name,
   role, and photo columns can repeat for each person.
5. Finish and save. Behind the scenes each column becomes its own database
   column in the field's table (for example `field_spec_headline`,
   `field_spec_rank`). At least one column must exist.

> **Tip:** You can **clone** the whole column layout from a Custom Field that
> already exists on another entity type or bundle, which saves rebuilding a
> complex set of columns by hand.

## 2. Choose a widget for the field and each column

On **Manage form display** (`/admin/structure/types/manage/<type>/form-display`)
pick how the field is edited. First choose the **base widget** for the field as
a whole:

- **Custom Flex** (`custom_flex`) — arrange the columns in a configurable
  CSS-flexbox grid using visual settings.
- **Custom Stacked** (`custom_stacked`) — stack the columns one per row.

Then, in the widget's settings, choose an input **widget for each column**. The
right choices depend on the column type — for example a text/textarea/select for
strings, an integer/decimal/float input for numbers, a color picker, the date
and time pickers, entity-reference autocomplete or select, a file/image upload,
a key/value map editor, and more.

## 3. Choose a formatter for the field and each column

On **Manage display** (`/admin/structure/types/manage/<type>/display`) pick how
the field is shown. Choose a **base formatter** for the whole field:

- **Custom formatter** — themed output via the module's template.
- **Custom inline** — columns rendered inline.
- **Custom list** — columns as a list.
- **Custom table** / **Flipped table** — spec-sheet style HTML tables.
- **Custom template** — rewrite the output with a Twig template, much like a
  Views rewrite.

Then pick a display **formatter for each column** (a string, integer, decimal,
boolean, date, image, link, map table, entity-reference label, and so on).

## Adding or removing a column later

You can change a Custom Field's columns after it already holds content. The
safest way is the module's Drush commands, which update both the field's
configuration and the live database table:

```bash
drush custom_field:add-column      # prompts for the field, new column name, type, options
drush custom_field:remove-column   # prompts for the field and the column to drop
```

Both commands are interactive and also print the equivalent PHP call so you can
paste it into an update hook for a repeatable deployment. Removing a column drops
its data, so back up first. See the [`agent/`](../../agent/drush/updater.md) docs
for the scriptable service behind these commands.
