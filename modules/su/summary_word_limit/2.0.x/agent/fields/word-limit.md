<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Summary word limit on text_with_summary fields

## Install & enable

```bash
composer require drupal/summary_word_limit
drush en summary_word_limit -y
```

No dependencies outside Drupal core. Enabling the module alone changes nothing — you must set a
limit on a specific field.

## Set a limit on a field (UI)

Only applies to fields of type **`text_with_summary`** (*Text (formatted, long, with summary)*),
e.g. the default *Body* field on content types.

1. *Structure → Content types → (type) → Manage fields → (the Text-with-summary field) → Edit*.
2. Ensure **Summary input** (`display_summary`) is checked — the limit field is hidden until it is
   (`#states` visible when `settings[display_summary]` is checked).
3. Enter a number in **Summary word limit count**. Empty or `0` = no limit.
4. **Save settings**.

Field: `summary_word_limit_count`, `#type => number`, description "Maximum number of words allowed
in the summary. Enter 0 for no limit." Added by
`summary_word_limit_form_field_config_edit_form_alter()` (only when the field type is
`text_with_summary`).

## Where it is stored

The value is a **third-party setting on the FieldConfig**, not a config object of this module —
there is no `summary_word_limit.settings` and no `config/schema`. Entity builder
`summary_word_limit_field_config_edit_form_builder()`:

- if *Summary input* is on and the count is non-empty →
  `$field_config->setThirdPartySetting('summary_word_limit', 'summary_word_limit_count', $count)`;
- otherwise → `unsetThirdPartySetting(...)` (so unchecking *Summary input* or clearing the number
  removes the limit).

Config-export equivalent (on the field's `field.field.*` config), e.g. Body on Article nodes:

```yaml
# field.field.node.article.body
third_party_settings:
  summary_word_limit:
    summary_word_limit_count: 30
```

## How it is enforced

`summary_word_limit_entity_bundle_field_info_alter()` walks the bundle's fields; for every
`FieldConfig` that has a non-zero `summary_word_limit_count`, it calls
`$field->addConstraint('SummaryWordLimit')`. Because the constraint is attached to the field
definition, it runs during **entity validation everywhere** — node form, REST, JSON:API,
migrations, and programmatic saves that call `->validate()` — not only in the form.

`SummaryWordLimitValidator::validate()` (`src/Plugin/Validation/Constraint/`):

```php
$count = $field_config->getThirdPartySetting('summary_word_limit', 'summary_word_limit_count');
if ($count && str_word_count($item->summary) > $count) {
  $this->context->addViolation($constraint->overWordLimit, [
    '%field_name'    => $field_config->getName(),
    '%limit_count'   => $count,
    '%current_count' => str_word_count($item->summary),
  ]);
}
```

- Word counting uses PHP's **`str_word_count()`** on the raw summary text. That counts
  space/punctuation-separated word tokens using the current locale — it does **not** parse HTML,
  so markup tokens in the summary can affect the count. It is a validation gate only; it never
  renders or alters the summary.
- The message (`SummaryWordLimit::$overWordLimit`) is:
  `The %field_name summary is over the limit of %limit_count words. You used %current_count words.`
  All placeholders use the `%` (escaped/emphasised) form.

## Notes / caveats

- Applies **only** to `text_with_summary` fields; plain long-text or string fields are ignored.
- The limit counts **words**, not characters. There is no character-limit option here.
- Constraint id is `SummaryWordLimit` (type `string`); the plugin is discovered via annotation, so
  no services.yml or plugin manager is added by this module.
- Fully removing the limit: uncheck *Summary input* or clear the count and save; the third-party
  setting is unset and the constraint is no longer attached.
