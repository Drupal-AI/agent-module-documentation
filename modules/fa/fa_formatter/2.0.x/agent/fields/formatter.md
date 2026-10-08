<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "FA Int Formatter" formatter

## Install & enable

```bash
composer require drupal/fa_formatter
drush en fa_formatter -y
```

No module dependencies, no sub-modules, no permissions of its own, no Drush commands. The module
does **not** bundle Font Awesome — load an icon font yourself (theme, `fontawesome` module, or a
custom IcoMoon build) or the icons render as blank space.

## Enable it on a field

Plugin id **`fa_formatter_int`**, label *"FA Int Formatter"*
(`src/Plugin/Field/FieldFormatter/FAFormatterInt.php`). It applies **only** to core
**list(integer)** fields (`field_types = { "list_integer" }`) — not plain integer, string, or list
text fields.

UI path: create a **List (integer)** field with `allowed_values` (e.g. `1|1 … 5|5`), then
*Structure → (bundle) → Manage display* → set that field's format to **FA Int Formatter** → click
the gear → paste the icon HTML.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.book.default \
  content.field_rating.type fa_formatter_int -y
drush cr
```

## The one setting

`defaultSettings()` returns a single key:

| Setting key | Default | Meaning |
|---|---|---|
| `icon_class` | `<i class="fas fa-star"></i>` | The **icon HTML snippet** repeated for each slot. Despite the name it is a full markup string, not a bare class. Swap in any `<i class="…">` (or other icon-font markup). |

`settingsForm()` shows it as a plain **textfield**; `settingsSummary()` always prints the fixed
string *"Displays the Stars"* on the Manage-display line. The setting has config schema
(`field.formatter.settings.fa_formatter_int` → `icon_class: string` in
`config/schema/fa_formatter.schema.yml`).

Example view-display config:

```yaml
# core.entity_view_display.node.book.default
content:
  field_rating:
    type: fa_formatter_int
    label: above
    settings:
      icon_class: '<i class="fas fa-star"></i>'
```

## Exactly what markup it emits

`viewElements(FieldItemListInterface $items, $langcode)`:

1. Reads the icon: `$icon_setting = $this->getSetting('icon_class');`
2. Derives the maximum row length from the field's own allowed values:
   `$allowed_values = $items->getFieldDefinition()->getSettings();`
   `$maximum_value = count($allowed_values['allowed_values']);`
3. For each item, `$on = $item->value; $off = $maximum_value - $item->value;` and builds a string:

```php
$markup  = "<span class='fa-formatter'>";
$markup .= "<span class='rate-value'>$item->value</span>";
// on
for ($i = 1; $i <= $on; $i++) {
  $markup .= "<span class='rate-image star-on odd s1'>$icon_setting</span>";
}
// off
for ($i = 1; $i <= $off; $i++) {
  $markup .= "<span class='rate-image star-off odd s1'>$icon_setting</span>";
}
$markup .= "</span>";

$element[$delta] = [
  '#markup'   => $markup,
  '#attached' => ['library' => ['fa_formatter/fa_formatter.usage']],
];
```

So each rendered item is: a wrapper `<span class="fa-formatter">`, an off-screen
`<span class="rate-value">N</span>` (the numeric value, hidden by CSS `left:-9999px`), then
`value` "on" icons and `max - value` "off" icons. **Total icons = number of allowed values**, and
"on" vs "off" are distinguished only by CSS (`star-on` yellow `#f8d420`, `star-off` grey `#484848`;
see `css/fa_formatter_style.css`).

If the field has no value, `viewElements()` instead outputs a single element with the literal German
string **`t('Noch keine Bewertung.')`** ("No rating yet.") — this text is hard-coded, not
translatable per-site beyond the `t()` string table, and there is no configurable empty message.

## Operating notes / caveats

- **Bring your own icon font.** The `#attached` library is CSS-only styling; the actual glyph comes
  from whatever `<i class="…">` you paste and whichever icon font the page has loaded.
- **Fixed maximum, not "that many icons".** The row is always `count(allowed_values)` icons long;
  the value only controls how many are `star-on`. Adding/removing allowed values changes every
  rendered row's length.
- The `icon_class` name is misleading — it stores a whole HTML tag, and the default is a `<i>`, not
  a class string.
- No settings/admin route (`configure` is null); everything is per view-display. No `.module`,
  `.install`, `.routing.yml`, `.services.yml` or permissions file exists.
