<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Schema.org Education (schema_education) — agent index

Vocabulary add-on for **Schema Metatag** (`schema_metatag`). Registers the Schema.org
**`EducationalOccupationalProgram`** type as a Metatag group with **28 properties**, so
education/training programmes can be described in JSON-LD structured data.

- **Version:** 1.0.1 · **Core:** `^9 || ^10 || ^11` · **License:** GPL-2.0-or-later · **Package:** SEO
- **Requires:** `schema_metatag` (which requires `metatag`).
- **Declares `php: 7.2.0`** — stale floor metadata; irrelevant on a Drupal 11 site.

## Mechanism (what it actually is)

- **No runtime logic.** `schema_education.module` is empty. No routes, controllers, forms,
  services, hooks, permissions, or Drush commands.
- Entire contribution = **Metatag plugin definitions**:
  - **1 `@MetatagGroup`** — `src/Plugin/metatag/Group/SchemaEducationalOccupationalProgram.php`,
    id `schema_educational_occupational_program`, extends `schema_metatag`'s `SchemaGroupBase`.
  - **28 `@MetatagTag`** — `src/Plugin/metatag/Tag/*.php`, each a thin subclass of
    `SchemaNameBase` carrying only annotation metadata. Only two override methods:
    `...Type.php` fixes `@type` to `EducationalOccupationalProgram` via `labels()`.
- **Config schema** — `config/schema/schema_educational_occupational_program.metatag_tag.schema.yml`
  declares the config type (`text`) for each of the 28 tags. This is `provides_config_schema: true`;
  it does **not** define new plugin types (`provides_plugin_types: []`).
- **Schema Metatag owns everything downstream**: plugin discovery, the per-bundle config form,
  token replacement, JSON-LD assembly, and output escaping/serialization.

## How it's used

1. Enable `schema_education` (pulls in `schema_metatag` + `metatag`).
2. Go to **Admin > Configuration > Search and metadata > Metatags** (`/admin/config/search/metatag`).
3. Edit a Metatag default (global, or an entity-type/bundle), expand the
   **"Schema.org: EducationalOccupationalProgram"** fieldset, and map properties to fields/tokens.
4. Schema Metatag renders the JSON-LD `<script type="application/ld+json">` on matching pages.

No config UI of the module's own — it only adds the group/fields to Metatag's existing screens.

## Files
- `agent/metatags/educational-occupational-program.md` — the group and full 28-property reference.

## Security
No custom output, no input handling — escaping is Schema Metatag's responsibility. **Clean.**
