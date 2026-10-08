<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "E-mail formatter (with options)" formatter

## Install & enable

```bash
composer require drupal/email_formatter
drush en email_formatter -y
```

Only dependency is core **`field`**. No sub-modules, no permissions, no services, no Drush
commands. `hook_install()` (`email_formatter.install`) just prints two status messages.

## Enable it on a field

Plugin id **`email_formatter`**, label **"E-mail formatter (with options)"**, applies to **core
Email fields** only (`field_types = { "email" }` on the class annotation; the legacy
`hook_field_formatter_info()` in `email_formatter.module` lists `email_field` but the active
plugin definition is the annotation).

UI path: *Structure → (bundle) → Manage display* → set an Email field's format to **E-mail
formatter (with options)** → click the gear to set the options below.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_email.type email_formatter -y
drush cr
```

## Settings

Class: `EmailFormatter`, `src/Plugin/Field/FieldFormatter/EmailFormatter.php`. Defaults from
`defaultSettings()` (note: the legacy `hook_field_formatter_info()` in `.module` lists slightly
different defaults — `icon => envelope` there vs. `icon => none` in `defaultSettings()`, and the
plugin uses `defaultSettings()`).

| Setting key | Type | Default | Meaning |
|---|---|---|---|
| `mailto` | boolean | `TRUE` | Wrap the (possibly truncated) address in a `mailto:` `Link`. If off, the address renders as plain text. |
| `truncate` | integer | `40` | Max characters of the address to show; longer values are cut and get a trailing `&hellip;`. Blank or `0` = no truncation. |
| `text` | string | `''` | Plain text prefix before the address. Escaped with `Html::escape()`. Add a trailing space yourself. |
| `HTML` | string | `''` | HTML prefix before the address, intended to pass `Xss::filterAdmin()`. **See the broken-option caveat below — leave empty.** |
| `icon` | string | `none` | Font Awesome icon prefix. One of: `none`, `envelope`, `envelope-square`, `envelope-open`, `envelope-open-text`, `paper-plane`, `reply`, `reply-all`, `inbox`, `mail-bulk`. Rendered as `<i class="fas fa-<icon> fa-fw"></i>`. |
| `iconlink` | boolean | `TRUE` | Wrap the icon in a `mailto:` `Link` to the address. |

Config schema: `config/schema/email_formatter.schema.yml` defines
`field.formatter.settings.[email_formatter]` with exactly these six keys (`mailto`/`iconlink`
boolean, `truncate` integer, `text`/`HTML`/`icon` string). `settingsSummary()` prints a single
line like *"Output mailto: link, truncated to 40 characters, preceded by a mailto: linked envelope
icon"* on the Manage-display page.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_email:
    type: email_formatter
    label: above
    settings:
      mailto: true
      truncate: 40
      text: ''
      HTML: ''
      icon: envelope
      iconlink: true
```

## How output is built (`viewElements()`)

For each field item, `$address = $item->getValue()['value']`, then:

1. **Icon** — if `icon != 'none'`, build `<i class="fas fa-<icon> fa-fw"></i>`. If `iconlink` is
   on, wrap it via `Link::fromTextAndUrl(Markup::create($icon), Url::fromUri('mailto:' . $address,
   ['attributes' => ['title' => $address, 'target' => '_blank']]))`. If `iconlink` is off the icon
   variable is set to `''` (so an unlinked icon is effectively dropped — a known quirk).
2. **Text** — start from `$address`; if `truncate` is non-empty and non-zero and
   `mb_strlen($address) - 1 > truncate`, cut with `substr($address, 0, (int) truncate - 1)` and
   append `&hellip;`.
3. **mailto on text** — if `mailto` is on and the text is non-empty, wrap it in a `mailto:` `Link`
   the same way as the icon.
4. **Prefixes** — if `HTML` set: `$text = Xss::filterAdmin($HTML) . $text`. If `text` set:
   `$text = Html::escape($text_setting) . $text`.
5. Concatenate `icon + (space if both non-empty) + text` and return
   `['#markup' => Markup::create($markup)]` per delta.

## Caveats / gotchas

- **Custom HTML option is broken.** `viewElements()` calls `XSS::filterAdmin(...)` but the class is
  **not imported** (only `Drupal\Component\Utility\Html` is `use`d). Because an unqualified `XSS`
  resolves to the plugin's own namespace, setting a non-empty **Custom HTML** value throws a
  "class not found" fatal when the field renders. Practical guidance: **leave the HTML field
  empty**; use the plain-text `text` option instead. (`HTML::escape` works only because PHP class
  names are case-insensitive and `Html` *is* imported.)
- **Truncation is off-by-one and byte-based.** The comparison uses `mb_strlen($address) - 1` and
  the cut uses byte `substr(..., truncate - 1)`, so the visible length is one short of the setting
  and multibyte addresses can be cut mid-character. Fine for ASCII addresses.
- **Unlinked icon disappears.** With `icon` set but `iconlink` off, step 1 sets the icon to `''`,
  so no icon renders. To show an icon, keep `iconlink` on.
- **Two conflicting default sets.** `defaultSettings()` (`icon => none`) is authoritative for the
  plugin; the commented-legacy `hook_field_formatter_info()` (`icon => envelope`) is dead history.
- **Font Awesome is external.** The module emits `fas fa-*` markup but declares no library/asset —
  install a Font Awesome module/library (README suggests `drupal/fontawesome` 8.x-2.x+) or the
  icon shows nothing.
- **No Twig template.** The commented-out `hook_theme()` / `template_preprocess` in `.module`
  shows a template was planned but never shipped; output is a raw `#markup` string.
