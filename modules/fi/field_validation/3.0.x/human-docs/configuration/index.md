# Configuration

Field Validation is configured through rule sets and rules. A **rule set** is a
container tied to one entity type and bundle; a **rule** inside it validates one
field. You will spend all your time on the admin pages under **Structure → Field
validation rule sets** (`/admin/structure/field_validation`).

## Open the rule-set list

1. Log in as a user with the **Administer field validation rule set** permission.
2. Go to **Structure → Field validation rule sets**, or navigate directly to
   `/admin/structure/field_validation`.

This collection page lists every rule set you have created and links to add a new
one.

## Create a rule set

Click **Add rule set** (`/admin/structure/field_validation/add`). You provide:

- **Name** — the machine name that identifies the rule set (it becomes the config
  id `field_validation.rule_set.<name>`).
- **Label** — a human-friendly title shown in the list.
- **Entity type** — which entity type this set validates (for example *Content*
  for nodes, *User*, or *Taxonomy term*).
- **Bundle** — which bundle within that entity type (for example the *Article*
  content type).

Save it, and you land on the rule set's manage page, ready to add rules.

## Add a rule

On the rule set's manage page
(`/admin/structure/field_validation/manage/<rule_set>`), add a rule by choosing a
validation type. Each type corresponds to a rule plugin — most are named
`*_constraint_rule`. When you add one you fill in a form with these common fields:

- **Title** — an admin label for this rule instance, so you can tell rules apart
  in the list.
- **Field name** — the machine name of the field to validate (for example `body`,
  `title`, or `field_phone`).
- **Column** — the property within that field to check. For most fields this is
  `value`.
- **Error message** — the message shown to the editor when the rule is violated.
  Leave it blank to fall back to the constraint's built-in wording.
- **Roles** — optionally restrict the rule so it only applies to users in the
  chosen roles. Leaving this empty applies the rule to everyone.
- **Condition** — optionally make the rule fire only when another field meets a
  condition (a *field / operator / value* triple). Leave it empty to always
  validate.
- **Rule-specific settings** — the fields that depend on which validation type you
  picked (see the next section).

Rules within a set have a **weight** that controls the order they run in; drag
them to reorder. You can edit a rule later at
`/admin/structure/field_validation/manage/<rule_set>/rules/<rule_uuid>` and delete
it from the adjacent delete link.

## Choosing a validation type

The 3.0.x module ships roughly 48 constraint-backed rule types. A few of the most
common, with the extra settings each one asks for:

| Rule type | What it checks | Its own settings |
|-----------|----------------|------------------|
| **Length** (`length_constraint_rule`) | Minimum and/or maximum character length | `min`, `max`, plus optional min/max/exact messages |
| **Regex** (`regex_constraint_rule`) | The value matches a regular expression (SKU, postcode, etc.) | `pattern`, `message` |
| **Range** (`range_constraint_rule`) | A number falls between a min and max | `min`, `max`, messages |
| **Email** (`email_constraint_rule`) | A well-formed email address | `message` |
| **Unique field** (`unique_field_constraint_rule`) | The value is unique across all entities of the bundle | `message` |
| **Not blank / Blank** (`not_blank_constraint_rule` / `blank_constraint_rule`) | The field is required to be non-empty, or forced empty | `message` |
| **Count** (`count_constraint_rule`) | The number of values on a multi-value field | `min`, `max`, messages |
| **True / False** (`true_constraint_rule` / `false_constraint_rule`) | A checkbox/boolean is checked or unchecked | `message` |
| **Comparison** (`equal_to_`, `not_equal_to_`, `greater_than_`, `less_than_`, `divisible_by_`, …) | The value compares to a fixed value | `value`, `message` |
| **Expression** (`expression_constraint_rule`) | A Symfony ExpressionLanguage expression evaluates true | `expression`, `message` |

Beyond these, the module includes rules for numeric sign (positive/negative),
date/datetime/time formats, country/language/locale codes, and a large family of
financial and identifier codes — IBAN, BIC, credit-card scheme, currency, Luhn
checksum, ISBN, ISSN, ISIN, ULID, UUID, hostname, IP, CIDR, CSS color, and JSON.
Every rule also carries a `validate_mode` setting used internally by the
constraint machinery. If you enabled the **field_validation_legacy** submodule,
its older hand-written rules (pattern, phone, words, plain-text, item-count) also
appear in the rule-type list.

## Deploying rule sets between environments

Rule sets are plain configuration, so there is no separate export step — they move
with your normal config workflow:

```bash
drush config:get field_validation.rule_set.<name>   # read a rule set
drush config:export                                  # capture it into config sync
drush config:import                                  # apply it on another environment
drush config:delete field_validation.rule_set.<name> # remove a rule set
```

If you need to create rule sets non-interactively, prefer the entity API over
hand-writing YAML so that rule UUIDs and defaults are generated correctly — see
the [agent API notes](../../agent/api/field_validation.md).

## When rules run

Because each rule is added as an extra constraint on the field, validation fires
wherever Drupal validates the entity: on the add/edit form (blocking submission
and showing your error message), and on programmatic `$entity->validate()` /
`$entity->save()` calls, including migrations. This makes the rules enforce
consistently no matter how content enters the site.
