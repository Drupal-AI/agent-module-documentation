# lang_dropdown block plugin

The module **defines no plugin type of its own** — it provides one core Block plugin.

## The block plugin

- **Class:** `Drupal\lang_dropdown\Plugin\Block\LanguageDropdownBlock`
- **Base id:** `language_dropdown_block`
- **Annotation:** `@Block(id = "language_dropdown_block", admin_label = "Language dropdown switcher", category = "System", deriver = ...)`
- **Deriver:** `Drupal\lang_dropdown\Plugin\Derivative\LanguageDropdownBlock`

### Derivatives (per language type)

The deriver creates one derivative per **configurable language type** returned by the
language manager. On a standard multilingual site the interface language type yields:

```
language_dropdown_block:language_interface
```

Other configurable types (e.g. content/URL language) produce
`language_dropdown_block:language_content` etc. when they are made configurable at
`/admin/config/regional/language/detection`. When only one type is configurable its
admin label is simply "Language dropdown switcher". Use the **full derived id**
(`language_dropdown_block:language_interface`) as the `plugin` of a `block` config entity
and as `settings.id`.

### Key methods
- `defaultConfiguration()` — baseline settings (see [configure/lang_dropdown.md](../configure/lang_dropdown.md)).
- `blockForm()` / `blockSubmit()` — the per-block settings UI writing the keys above.
- `build()` — renders the switcher; attaches the JS library for the chosen `widget`.
- `blockAccess()` — allowed only when the site is multilingual
  (`languageManager()->isMultilingual()`), forbidden otherwise; the block is hidden on
  single-language sites regardless of placement.

## Enumerated setting values (from `LanguageDropdownConstants`)

Output type (`widget`):
`LANGDROPDOWN_SIMPLE_SELECT=0`, `LANGDROPDOWN_MSDROPDOWN=1`, `LANGDROPDOWN_CHOSEN=2`,
`LANGDROPDOWN_DDSLICK=3`.

Display format (`display`):
`LANGDROPDOWN_DISPLAY_TRANSLATED=0`, `LANGDROPDOWN_DISPLAY_NATIVE=1`,
`LANGDROPDOWN_DISPLAY_LANGCODE=2`, `LANGDROPDOWN_DISPLAY_SELFTRANSLATED=3`.

Flag position (`languageicons.flag_position`):
`LANGDROPDOWN_FLAG_POSITION_BEFORE=0`, `LANGDROPDOWN_FLAG_POSITION_AFTER=1`.

ddSlick image position (`ddslick.imagePosition`): `'left'` / `'right'`.

## Extending

To reuse or subclass, extend `LanguageDropdownBlock` and register your own `@Block`, or
just place the existing derived block. There is no manager service or hook API to
implement — customization is done entirely through the block `settings` mapping.
