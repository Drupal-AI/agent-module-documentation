# Make a daterange field's end date optional

The module has **no admin settings page** and no `configure` route. You opt in per Date range
field. Enabling `optional_end_date` alone changes nothing until you check the box on a field.

## Turn it on for a field (UI)

1. Enable the module (`drush en optional_end_date -y`). It requires core `datetime_range`.
2. Go to the daterange field's **Storage settings** form
   (**Manage fields → your Date range field → Field settings / Storage settings**).
3. Check **"Optional end date"** and save.

The checkbox is a **field storage setting** named `optional_end_date` (boolean, default
`FALSE`). Because it is a *storage* setting it applies to every instance of that field
storage across bundles.

Config schema (`config/schema/optional_end_date.schema.yml`) adds the key to
`field.storage_settings.daterange`:

```yaml
field.storage_settings.daterange:
  type: field.storage_settings.datetime
  mapping:
    optional_end_date:
      type: boolean
      label: 'Optional end date'
```

Set it in code instead of the UI:

```php
$storage = \Drupal::entityTypeManager()->getStorage('field_storage_config')
  ->load('node.field_event_dates');
$storage->setSetting('optional_end_date', TRUE)->save();
```

## What checking the box does (all in `daterange`, no new field type)

The module swaps core plugin classes via `hook_field_info_alter()`,
`hook_field_widget_info_alter()`, and `hook_field_formatter_info_alter()` — it does **not**
add a new field type, widget, or formatter you select. When `optional_end_date` is TRUE:

- **Field type** (`OptionalEndDateDateRangeItem` extends core `DateRangeItem`):
  `end_value` is set not-required; `isEmpty()` treats a value with only a start date as
  non-empty; the `NotNull` constraint on `end_value` is **not** added (it is only added when
  the setting is off).
- **Widgets** (`daterange_default`, `daterange_datelist`): the End date element gets
  `#required = FALSE` and its title becomes **"End date (optional)"**. The default widget
  also sanitizes a non-string `end_value` (a raw form array left by a Paragraphs form
  rebuild) to `NULL` before handing off to the core widget.
- **Formatters** (`daterange_default`, `daterange_plain`, `daterange_custom`): when the end
  date is empty (or equal to the start), only the start date is rendered — no separator, no
  empty end date. The shared `OptionalEndDateDateTimeRangeTrait::viewElements()` casts the
  separator display setting to a string so a `NULL` separator (possible after config
  translation/import) does not raise a TypeError.

## Hook implementation style (2.0.x)

Hooks are implemented as an autowired OOP class,
`Drupal\optional_end_date\Hook\OptionalEndDateHooks`, registered in
`optional_end_date.services.yml` and annotated with `#[Hook('…')]` attributes;
`optional_end_date.module` keeps thin `#[LegacyHook]` procedural shims that delegate to that
service. `field_info_alter`, `field_formatter_info_alter`, and `help` run through the class;
`field_widget_info_alter` remains a plain procedural function. `hook_help()` renders the
module README on `help.page.optional_end_date` (via the Markdown filter when the `markdown`
module is present, otherwise wrapped in `<pre>`).

## Existing fields / database

`hook_install()` runs once on enable and alters existing `daterange` storage so the
`<field>_end_value` DB columns allow NULL. `hook_update_8001()` re-saves daterange field
storage configs whose `optional_end_date` setting is not yet a proper boolean.

## Leaving it required

To keep both dates mandatory (core behavior), simply leave the checkbox **unchecked** — the
`NotNull` constraint on `end_value` stays in place and validation fails on an empty end date.

## Uninstalling

The module notes it mimics Drupal 8.9+ core optional-end-date support; once you rely on
core's implementation you can uninstall this module.

## Diff 1.4.x → 2.0.x

Behavior for editors and site builders is unchanged — the per-field **"Optional end date"**
storage checkbox, the widget relabelling, the dropped `NotNull` constraint, the start-only
formatter output, and the `hook_install()` column change all work exactly as in 1.4.x. The
2.0.x major bump is about platform support and internals:

- **BC break — core support window narrowed.** `core_version_requirement` changed from
  `^8 || ^9 || ^10 || ^11` to `^10.3 || ^11 || ^12`. Drupal 8, 9, and 10.0–10.2 are no
  longer supported; **Drupal 10.3+ is now the minimum** and **Drupal 12** is now supported.
  If you run older core, stay on 1.x.
- **Hooks moved to OOP `#[Hook]` classes.** Implementations were relocated from plain
  procedural functions into `src/Hook/OptionalEndDateHooks.php` (autowired service +
  `#[Hook]` attributes), with `#[LegacyHook]` shims kept in the `.module` file. This is the
  modern Drupal 11.1+ hook API; there is no behavioral change, but a new
  `optional_end_date.services.yml` now exists.
- **Formatter logic consolidated into a trait.** The three formatter overrides now share
  `OptionalEndDateDateTimeRangeTrait::viewElements()`, which adds a defensive `(string)` cast
  of the separator setting to avoid a TypeError from a `NULL` separator introduced by config
  translation/import.
- **Default widget hardening.** The default widget now coerces a non-string `end_value`
  (a raw form array from a Paragraphs rebuild) to `NULL` before delegating to core.

No config keys, setting names, plugin IDs, or update hooks were removed or renamed, so an
in-place update from 1.4.x on Drupal 10.3+ needs no configuration changes.
