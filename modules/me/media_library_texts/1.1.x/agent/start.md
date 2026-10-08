<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Library Widget Texts — agent index

**Configurable Media Library widget texts**. Version **1.1.x** (release 1.1.0). Core `^11.3 | ^12`.

Depends on core `media_library`. Machine name: `media_library_texts`.

## What it does

Overrides the built-in strings shown in Drupal core's **Media Library widget** (the
entity-reference widget used on media fields). Lets you replace, per field-and-form-mode:

- **Add button text** — the "Add media" open-dialog button label (default: `Add media`).
- **Empty selection text** — shown when no items are selected (default: `No media items are selected.`).
- **Remaining item text** — singular cardinality message (default: `One media item remaining.`).
- **Remaining items text** — plural cardinality message, `@count` placeholder (default: `@count media items remaining.`).
- **No remaining items text** — shown when the field is full (default: `The maximum number of media items have been selected.`).

## Mechanism (no settings page, no permission)

There is **no** admin settings form, route, service, or module-provided permission. The
texts are stored as **field-widget third-party settings** (`third_party_settings.media_library_texts`)
on each field's **Manage form display** entry. Configure at
`admin/structure/types/manage/<bundle>/form-display` (or the equivalent for any entity type):
set the widget to **Media library**, click the gear/cog, and fill the five text fields.

Access is therefore gated by core's **`administer <entity_type> form display`** permission
(e.g. `administer node form display`) — a site-builder permission. No dedicated
`media_library_texts` permission exists.

Implementation lives in `src/Hook/FieldHooks.php` (OOP `#[Hook]` attributes):

- `field_widget_third_party_settings_form` — builds the five textfields on the widget's gear form (all `#required`).
- `field_widget_settings_summary_alter` — shows the overrides in the Manage-form-display summary.
- `field_widget_single_element_form_alter` (runs `Order::Last`) — applies the overrides to the live widget: sets `open_button['#value']`, `#field_prefix.empty_selection['#markup']`, and rebuilds `#description` with a `PluralTranslatableMarkup` cardinality line (only when cardinality is limited).

Config schema: `field.widget.third_party.media_library_texts` (5 translatable string keys).

## Behavior notes

- All five fields are `#required` in the gear form, so once you open it you must supply values (defaults are pre-filled).
- The cardinality message is appended to the field's own description (with a `<br />` separator) and is only added when the field cardinality is **not** unlimited.
- Unlimited-cardinality fields get no remaining-items message.

## Diff 1.0.x → 1.1.x

Real, source-verified changes (both versions are the same third-party-settings design; no
settings page or permission was ever present in either — 1.0.x docs that implied a
"Configuration → Media settings form" / dedicated permission were inaccurate):

1. **Procedural → OOP hooks.** The `media_library_texts.module` file is removed; all hooks
   move to `src/Hook/FieldHooks.php` as a `FieldHooks` class using `#[Hook(...)]` attributes
   and `StringTranslationTrait`. The old `hook_module_implements_alter()` used to push the
   form-alter last is replaced by `#[Hook(hook: 'field_widget_single_element_form_alter', order: Order::Last)]`.
2. **Core requirement bump.** `core_version_requirement` `^10 || ^11` → `^11.3 | ^12`
   (drops Drupal 10, requires 11.3+ for OOP hooks, adds Drupal 12). `composer.json`
   `drupal/core` updated to match.
3. **Cardinality message bugfix.** 1.0.x used `if ($remaining === 1)` to pick the
   singular/plural `PluralTranslatableMarkup` path, so **2+ remaining slots** wrongly fell
   through to the "no remaining items" message. 1.1.x uses `if ($remaining > 0)`, so any
   positive remaining count now renders the correct pluralized "N media items remaining."
   message (covered by the new `testCardinalityMessagePluralRemaining` regression test).
4. **Strictness / null-safety.** Adds `declare(strict_types=1)`, explicit `is_array()` guards
   on `open_button` / `#field_prefix.empty_selection`, `(string)` casts on the messages passed
   to `PluralTranslatableMarkup`, `assert($items instanceof EntityReferenceFieldItemListInterface)`,
   and a typed `$cardinality`/`$description_original` handling.
5. **Tests expanded.** Kernel test grows from button/empty-text coverage to also cover
   singular/plural/none/unlimited cardinality messages, description reset-and-append,
   settings-summary output, and other-widget guard clauses.

Unchanged: config schema, README, the five text keys and their defaults, dependency on
core `media_library`, absence of any route/service/permission.
