<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Computed Field (views_computed_field) — agent index

Adds one **Views field handler** (`field_computed_field`) whose value is a **formula over the other
fields already in the view** — e.g. `(field_price * field_quantity) - field_discount`. The formula
is entered in the Views UI field-options form and evaluated **per row in PHP**, at render time, after
the referenced fields have rendered. It is a *display-only* value: `query()` is intentionally empty
(no SQL), so the column cannot be sorted or filtered in the database.

**Evaluation is sandboxed by construction — cite as a positive.** The formula is run through
**Symfony `ExpressionLanguage`**, *not* `eval()` / the PHP filter. ExpressionLanguage can only invoke
functions explicitly registered with it; this module registers exactly **`round`** and **`ceil`**
(plus ExpressionLanguage's own built-in `constant`), so a formula cannot reach arbitrary PHP. Every
bareword identifier in the formula is first validated against the view's actual field handlers
(`getPreviousFieldLabels()`); an unknown name throws `Invalid field`. Field values are coerced to
numbers before evaluation (`convertToNumeric()` strips non-numeric characters; empty → `0`).

- Depends on: **core Views only** (implicit — it is a Views plugin; no `dependencies:` in info.yml).
  Composer requires the PHP lib **`symfony/expression-language:^6.4`** (ships with Drupal core).
- Core: `^9 || ^10 || ^11`. Package: `Views`. Version `1.0.0`.
- **No settings page / `configure` route, no permissions, no services, no drush, no config schema, no
  submodules.** All configuration is per Views-field-instance in the Views UI (needs the
  `administer views` permission, which core marks *restrict access*).
- Defines **no plugin type** — it *provides* one Views field plugin of the existing `views.field`
  type.

## What you'd do → where

- **Add the computed field to a view, write a formula, pick options (functions, empty-handling, error
  mode), understand evaluation & the field-name allowlist** →
  [plugins/computed-field.md](plugins/computed-field.md)

## Key facts (real machine names)

- Views field plugin: **`field_computed_field`** (`@ViewsField("field_computed_field")`),
  `src/Plugin/views/field/FieldComputedField.php`, extends `views\...\field\FieldPluginBase`.
- Views-data hook: `hook_views_data_alter()` in `views_computed_field.module` registers the pseudo
  field under **`$data['views']['computed_field']`** → id `field_computed_field`, so it appears as
  **Global: Computed field** in *Add fields*.
- Field option keys (`defineOptions()`): **`formula`** (string, required), **`hide_empty_fields`**
  (bool, default `TRUE` — empty → `0`), **`error_handling`** (`show` | `zero` | `hide`, default
  `show`).
- Registered ExpressionLanguage functions: **`round(num, precision=0)`**, **`ceil(num)`** only.
  (`floor`, `min`, `max`, `avg` appear in the field-name-detection regex as reserved words but are
  **not registered** — using them in a formula throws an ExpressionLanguage error.)
- Operators available (from ExpressionLanguage): `+ - * / %`, `**`, comparisons `> < >= <= == !=`,
  `and/or/not`, ternary `? :`, string concat `~`.
- Output: `ViewsRenderPipelineMarkup::create($result)`; errors logged to the
  **`views_computed_field`** logger channel and, per `error_handling`, shown / rendered as `0` /
  hidden.
- Rule: reference only fields placed **before** the computed field in the view's field list (the
  formula reads their `last_render`); order the computed field last.
