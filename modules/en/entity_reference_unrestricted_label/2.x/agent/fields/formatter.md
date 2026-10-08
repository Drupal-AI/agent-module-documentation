<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter: Label (access bypass)

Source: `src/Plugin/Field/FieldFormatter/EntityReferenceUnrestrictedLabelFormatter.php` — the module's
only PHP file.

## Identity

- Class `EntityReferenceUnrestrictedLabelFormatter` extends core
  `Drupal\Core\Field\Plugin\Field\FieldFormatter\EntityReferenceLabelFormatter`.
- `@FieldFormatter` annotation: id **`entity_reference_unrestricted_label_formatter`**,
  label *"Label (access bypass)"*, description *"Display the label of the referenced entities without
  performing any access check."*, `field_types = { "entity_reference" }`.
- Applies to any core-style entity_reference field (nodes, users, terms, media, etc.). Chosen on
  *Manage display* as the field's Format; no other UI.

## What it renders

- **Only the referenced entity's label** (`$entity->label()`), via the inherited
  `EntityReferenceLabelFormatter::viewElements()`. No body, no other fields, no edit/canonical link.
- Because `defaultSettings()` returns `[]`, the parent's `link` setting is never present, so
  `getSetting('link')` is falsy and `viewElements()` emits the label as a core `#plain_text` render
  element (HTML-escaped by the renderer) rather than a `#type => link`. Labels containing markup are
  escaped — no raw HTML output.

## How the access check is dropped

- Overrides `getEntitiesToView(EntityReferenceFieldItemListInterface $items, $langcode)`.
- It reproduces core `EntityReferenceFormatterBase::getEntitiesToView()` — iterate items, skip any
  where `$item->_loaded` is empty, translate via `entity.repository`
  `getTranslationFromContext()`, set `$entity->_referringItem` — but **omits** core's
  `$access = $this->checkAccess($entity)` and the `if ($access->isAllowed())` gate.
- Result: every referenced entity that could be loaded is returned and its label rendered,
  regardless of whether the current user may view the entity. This is the module's whole purpose and
  is stated in the plugin annotation and label.

## Settings

- `defaultSettings()` → `[]`; `settingsForm()` → `[]`. The formatter has **no configurable
  settings** and writes no config schema of its own.
- `settingsSummary()` returns a single translated caution line noting the formatter can lead to
  disclosure and should only be used deliberately. It shows on *Manage display*.

## Install / enable

- `composer require drupal/entity_reference_unrestricted_label` then
  `drush en entity_reference_unrestricted_label -y` (prefix with `ddev` on the host in DDEV).
- No dependencies beyond Drupal core; core requirement `^8.8 || ^9 || ^10 | ^11`.
- Enabling alone changes nothing — the behavior takes effect only after you select the
  *Label (access bypass)* format on a specific entity-reference field's *Manage display*.

## When to use / avoid

- Use it where you intend to reveal that referenced entities *exist* by their label while keeping the
  entities themselves access-restricted, and where those labels are not sensitive (e.g. a public
  taxonomy, exam/article titles you are content to expose).
- Avoid it on fields whose referenced entities' titles must stay hidden (unpublished nodes, private
  documents, restricted user names). For access-respecting output use core's standard
  *Label* formatter (`entity_reference_label`).
