<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: how schema_medical_entity plugs into Schema Metatag

## The stack
```
core Metatag  →  schema_metatag (JSON-LD assembly, tokens, override UI)  →  schema_medical_entity (+ submodules: vocabulary only)
```
This project adds **no rendering code**. Schema.org Metatag reads the Metatag tag plugins,
resolves tokens, and prints a `<script type="application/ld+json">` block in the page head.
`schema_medical_entity` and its submodules only supply *which tags exist* for the medical
branch of Schema.org.

## Plugin types this module implements (it defines none of its own)
- **`@MetatagGroup`** — one per type (e.g. `schema_medical_entity` → "Schema.org: MedicalEntity",
  `schema_drug` → Drug group). Groups the type's fields in the Metatag form.
- **`@MetatagTag`** — one per Schema.org property. Each extends
  `Drupal\schema_metatag\Plugin\metatag\Tag\SchemaNameBase` (or a base class in this module's
  `src/Plugin/metatag/Base/`). The annotation carries `property_type`, `tree_parent`,
  `tree_depth` and (for `@type` tags) a `labels()` method listing the allowed Schema.org types.
- **`@SchemaPropertyType`** — the base module ships two reusable ones, `hospital_affiliation`
  and `member_of` (used by `schema_physician`), each defining nested sub-properties.

Example (`schema_drug`'s type tag):
```php
@MetatagTag(
  id = "schema_drug_type",
  group = "schema_drug",
  property_type = "type",
  tree_parent = { "Drug" },
  ...
)
class SchemaDrugType extends SchemaNameBase { public static function labels() { return ['Drug']; } }
```

## No configuration of its own
There is **no settings form, route, permission or config entity** in this project. After
enabling a submodule, its `@type` and fields appear inside the normal Metatag config:
- **Global defaults** — `admin/config/search/metatag`
- **Per content type / bundle** override
- **Per entity** override on the node edit form (if the Metatag field is attached)

Values are hard-coded or driven by **tokens** (e.g. `[node:title]`,
`[node:field_active_ingredient]`), resolved by `schema_metatag`. Output escaping and JSON
encoding are handled by `schema_metatag`, not here.

## The `.module` files are empty
`schema_medical_entity.module` and every submodule `.module` contain only a file docblock —
no hooks. All behaviour is plugin-annotation-driven and discovered by Metatag.

## Drush: `schema_medical_entity:generate-tags` (developer tool)
`src/Commands/SchemaMedicalEntityCommands.php` provides one command:

```
drush schema_medical_entity:generate-tags --module="schema_drug" --type="Drug"
```
(alias `schema-medical-entity-generate-tags`). It reads the target submodule's
`config/schema/<module>.metatag_tag.schema.yml`, then **regenerates** the Tag plugin PHP
classes under that submodule's `src/Plugin/metatag/Tag/` — one class per schema property,
extending `SchemaNameBase`. It is a **code scaffolder for maintainers/contributors** adding or
refreshing a type, not part of runtime or of end-user setup. Note it calls
`deleteRecursive()` on the target `Tag` directory before regenerating, so run it only against
a submodule you are intentionally regenerating (it operates on module source on disk).

## Extending
To add a medical type not yet covered, model a new submodule on an existing one: depend on
`schema_metatag` + `schema_medical_entity`, add a Group plugin and a
`config/schema/<module>.metatag_tag.schema.yml` enumerating the Schema.org properties, then run
the generate-tags command to scaffold the Tag classes.
