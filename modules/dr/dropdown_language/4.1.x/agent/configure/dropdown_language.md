# Configure — Dropdown Language Switcher

Two layers of configuration: **global settings** (one form, applies to every dropdown) and
**per-block instance settings** (custom labels, only when the global label mode is Custom).

## Global settings form

- UI: **Admin → Configuration → Regional and language → Dropdown Language Switcher**
- Path: `/admin/config/regional/dropdown-language-switcher`
- Route: `dropdown_language.setting`
- Permission required: `administer site configuration`
- Config object: `dropdown_language.setting` (schema type `config_object`, exportable)

### Keys in `dropdown_language.setting`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `display_language_id` | integer | `0` | Label style for every dropdown: `0` = Language Name, `1` = Language ID (code, uppercased), `2` = Native Name (falls back to name; adds real name as `title` attr), `3` = Custom Labels (per-block textfields). Stored/read as a string in the block, e.g. `'1'`. |
| `wrapper` | boolean | `false` (installs as `true` in default config `wrapper: true`) | Wrap the dropbutton in a `<fieldset>` titled "Switch Language". Enabled in the form via the "Show block with fieldset wrapping" checkbox. |
| `filter_untranslated` | integer | `0` | SEO: when `1`, on entity routes remove links to translations that don't exist or that the current user's role can't `view`. Only affects objects implementing `getTranslationStatus()`/`getTranslation()`. |
| `always_show_block` | integer | `0` | When truthy, still render the block even if fewer than two switch links are available. |

Note: the form's checkboxes submit integer-ish values; `filter_untranslated` /
`always_show_block` are compared as `== '1'` / truthy in the block. `display_language_id`
is compared as a string (`'1'`,`'2'`,`'3'`).

### Set via drush

```bash
drush cset dropdown_language.setting display_language_id 2 -y   # native names
drush cset dropdown_language.setting wrapper 1 -y               # fieldset decor
drush cset dropdown_language.setting filter_untranslated 1 -y   # SEO filter
drush cset dropdown_language.setting always_show_block 0 -y
drush cget dropdown_language.setting                            # inspect
```

## Placing the block

The block is provided by plugin `dropdown_language`, **derived per configurable language
type**, so in Block layout you'll see one entry per type (e.g. "Dropdown Language
(Interface text)", "Dropdown Language (Content)"); if only one language type is
configurable the label is just "Dropdown Language". Block admin category: *Dropdown
Language*.

- UI: **Admin → Structure → Block layout** (`/admin/structure/block`) → place in a region.
- The block auto-hides on monolingual sites (`blockAccess` = allowed only when
  `languageManager->isMultilingual()`), and returns nothing on 403/404 responses.
- `getCacheMaxAge()` is `0` (block is uncacheable); cache tag
  `config:configurable_language_list` is added.

## Per-block custom labels (`display_language_id` = 3)

When the global label mode is **Custom Labels**, each placed block instance's config form
(the block settings) shows a required textfield per language under "Custom Labels for
Language Names". Values are stored in the **block's own** configuration under `labels`
(a sequence keyed by langcode), schema `block.settings.dropdown_language:*`, not in the
global settings object. The module recommends creating one block instance per language and
using core Block **Language visibility** to target each, since custom labels bypass the
normally-translatable language strings.

## Translating strings

The "Switch Language" fieldset title and default (non-custom) labels are ordinary
translatable interface strings — translate them via **User interface translation**
(`locale` module) rather than the Custom Labels option when you want them to follow the
interface language.
