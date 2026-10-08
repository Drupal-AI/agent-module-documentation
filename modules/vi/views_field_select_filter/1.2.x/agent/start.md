# Field Select Filter — agent index

Adds a Views exposed filter that lists the **distinct stored values** of one string/integer field as a
dropdown. No config UI, no permission, no schema, no Drush — you just add the "(selector)" filter to a
View and expose it. Depends on core `views` + `field`.

- **The `fieldselect` filter plugin, its expose options, and how options are queried** →
  [plugins/filter.md](plugins/filter.md)

Key facts:
- `hook_views_data_alter` (in the `.module`) registers, for every `string` and `integer` field_config, an
  extra filter `<field>_value_fsf` with `id: fieldselect`, labelled "<Field> (selector)".
- Plugin `FieldSelectFilter` (`@ViewsFilter("fieldselect")`) extends core `InOperator`; value widget is a
  `select`. It only renders in the **exposed** form.
- Options come from `SELECT DISTINCT <field>_value` on the field data table (optionally bundle- and
  langcode-scoped). This listing query uses `\Drupal::database()` directly and is **not** node-access
  filtered, so options can include values from content the viewer cannot see — see plugins/filter.md.
