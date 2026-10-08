<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Predefined titles + the `linkicon` formatter

Link Icon works on a **core `link` field**. Setup is two steps: (1) enable *Predefined* titles
on the field, (2) choose the *Link icon* formatter on Manage display.

## Step 1 — field settings (Manage fields)

On the link field's settings (`FieldConfig` for a `link` field), Link Icon adds a *Predefined*
choice to the "Allow link text" (`title`) option:

- `title` = integer **`5`** (`LinkIconManagerInterface::LINKICON_PREDEFINED`; legacy string `'predefined'`
  is also honored). Core values are 0 disabled / 1 optional / 2 required.
- `title_predefined` = multiline text of **`key|value[|tooltip]`** lines. The **key** becomes the
  icon-class suffix; the **value** is the option label shown to editors; optional third part is a
  (tokenizable) tooltip. Example:

```
facebook|Visit my Facebook page
x-twitter|X
google-plus|Google+|[node:title]
```

When *Predefined* is on, the link widget's Title field becomes a `<select>` of these values, so
editors pick an allowed title (which fixes the icon) instead of typing free text.

Set via config (`field.field.node.article.field_li_social` → `settings`):

```yaml
settings:
  title: 5
  title_predefined: "facebook|Facebook\nx-twitter|X"
```

## Step 2 — display formatter (Manage display)

Choose formatter **`linkicon`** ("Link icon, based on title") on the field's `entity_view_display`
component. It extends the core Link formatter, so all core options (trim length, url_only,
url_plain, rel, target) apply, plus Link Icon's own settings (defaults in parentheses):

| Setting | Purpose |
|---|---|
| `linkicon_prefix` (`icon`) | class prefix; final icon class is `<prefix>-<key>` (e.g. `icon-facebook`) |
| `linkicon_icon_class` / `linkicon_wrapper_class` / `linkicon_label_class` | extra CSS classes |
| `linkicon_load` (false) | let the module emit its starter CSS assets |
| `linkicon_vertical` (false) | stack icon above text |
| `linkicon_style` / `linkicon_color` (`''`) | built-in square/rounded/color presets |
| `linkicon_tooltip` (false) | render title as a pure-CSS tooltip |
| `linkicon_no_text` (false) | visually hide the title text (icon only) |
| `linkicon_maxlength` (60) | max length of title/tooltip |
| `linkicon_position` (`''`) | icon position relative to text |
| `linkicon_link` (false) | add the classes to the `<a>` tag itself |
| `linkicon_global_title` (`''`) | tokenized title overriding each link's text |
| `linkicon_size` / `linkicon_bundle` (`''`) | icon font size / icon-module integration (e.g. fontawesome) |

Config lives in `core.entity_view_display.<entity>.<bundle>.<mode>` →
`content.<field>.type: linkicon` with the above under `settings`. Config schema:
`field.formatter.settings.linkicon`.

### Scriptable example

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_li_social', [
  'type' => 'linkicon',
  'label' => 'hidden',
  'settings' => ['linkicon_prefix' => 'fa', 'linkicon_tooltip' => TRUE],
])->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_li_social`.
