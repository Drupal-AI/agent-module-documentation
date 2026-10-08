<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `doi_field` field type, widget & DOI validation

## Install & enable

```bash
composer require drupal/doi_field   # pulls in drupal/doi_search:^2.0 automatically
drush en doi_field -y               # also enables doi_search (hard dependency)
```

Only dependency is the contrib **`doi_search`** module. No permissions, no settings form.

## Field type — `DoiFieldItem`

`src/Plugin/Field/FieldType/DoiFieldItem.php`, extends `FieldItemBase`.

- Annotation `@FieldType(id="doi_field", label="Doi Field", category="general",
  default_widget="string_textfield", default_formatter="doi_field_formatter")`.
- **Storage** (`schema()`): a single column `value`, `varchar` length **255**, `not null = FALSE`.
- **Property** (`propertyDefinitions()`): `value`, a `string` DataDefinition, `setRequired(TRUE)`.
- `isEmpty()` returns TRUE when `value` is `NULL` or `''`.
- `getConstraints()` adds a `ComplexData` constraint that applies the **`Doi`** constraint to
  `value` — so every non-empty value is format-checked on validation/save.
- `generateSampleValue()` returns a random word (devel/testing only; it is not a valid DOI).

Because the type stores one plain string, it holds exactly one DOI per field value; make the field
multi-value in field storage settings to store several DOIs on one entity.

## Widget — `DoiFieldWidget`

`src/Plugin/Field/FieldWidget/DoiFieldWidget.php`, extends `WidgetBase`.
`@FieldWidget(id="doi_field_widget", label="Doi Field", field_types={"doi_field"})`.
`formElement()` renders a single `#type => 'textfield'` bound to `value`. Note the field type's
`default_widget` is core's `string_textfield`; this custom widget is an equivalent alternative you
can select on **Manage form display**.

## DOI validation constraint — `Doi`

`src/Plugin/Validation/Constraint/DoiConstraint.php` (`@Constraint(id="Doi", type="string")`) and
`DoiConstraintValidator.php`.

- Validator `validate()` returns early (valid) for `NULL`/`''`.
- Otherwise it requires `preg_match('/^10\.\d+(\.\d+)*\/\S+$/', $value)`: the value must start with
  `10.`, then a numeric registrant code (optionally with dot-separated numeric sub-codes), a forward
  slash, and a non-empty suffix with **no whitespace**. Valid: `10.1000/182`, `10.47366/sabia.v5n1a3`.
- On mismatch it adds the constraint `message` (`%value is not a valid DOI…`) as a violation, which
  Drupal surfaces as a form/API validation error.

## Add the field to an entity

UI: **Structure → Content types → *(bundle)* → Manage fields → Add field**, choose **Doi Field**,
finish the field settings. Set the input on **Manage form display** and the output on **Manage
display** (see [formatter.md](formatter.md)).

Config equivalent (storage + instance on `node.article`):

```bash
# Create field storage of type doi_field, then a field instance, e.g. field_doi.
# Then point the form/view displays at the module's plugins:
drush cset core.entity_form_display.node.article.default \
  content.field_doi.type doi_field_widget -y
drush cset core.entity_view_display.node.article.default \
  content.field_doi.type doi_field_formatter -y
drush cr
```
