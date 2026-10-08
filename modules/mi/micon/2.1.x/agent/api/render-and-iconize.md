<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering icons & the iconize API

An icon is addressed by its **selector**: package prefix + name, e.g. `fa-user`.
`\Drupal::service('micon.icon.manager')->getIconMatch('fa-user')` returns a `MiconIcon`
(or `NULL`). `getIcons()` / `getFlattenedIcons()` return all icons (results cached
permanently, tag `micon.icons`).

## Twig
```twig
{{ micon('fa-user') }}   {# TwigExtension\Micon::renderIcon -> #theme 'micon_icon' #}
```

## Render arrays (two theme hooks)
```php
// Icon only.
$build['i'] = ['#theme' => 'micon_icon', '#icon' => 'fa-user'];

// Icon + text.
$build['it'] = [
  '#theme' => 'micon',
  '#icon' => 'fa-user',
  '#title' => t('Profile'),
  '#position' => 'after',   // 'before' (default) | 'after'
  '#icon_only' => FALSE,
  '#icon_attributes' => [],
  '#attributes' => [],
];
```
`#icon` accepts either an id string or a `MiconIcon`. `micon_theme()` also declares
`micon_package`, `micon_icon_list`, `micon_icon_font`, `micon_icon_image`; suggestion hook adds
`micon_icon__font` / `micon_icon__image`. SVG packages render as inline
`<svg><use xlink:href=".../symbol-defs.svg#<selector>"></use></svg>`.

## Form element
```php
$form['icon'] = [
  '#type' => 'micon',        // Element\Micon (renders a fonticonpicker <select>)
  '#title' => t('Icon'),
  '#default_value' => 'fa-star',
  '#packages' => ['fa'],     // restrict to these micon ids; [] = all
  '#required' => FALSE,
];
```
The submitted value is the icon selector string (e.g. `fa-star`).

## The `micon()` iconize helper (translatable text + icon)
`micon($string, $args, $options)` (global function in `micon.module`) returns a
`MiconIconize`, a `TranslatableMarkup` subclass — usable anywhere a `t()` result is, and it
renders as icon-decorated markup:
```php
micon('Save');                       // no icon unless one is matched/set
micon('Save')->setIcon('fa-check');  // explicit icon by id
```
Fluent methods (all return `$this`):
- `setIcon($icon_id)` — set the icon explicitly (skips auto text lookup).
- `setIconOnly($bool = TRUE)` — hide the title, show only the icon.
- `setIconBefore()` / `setIconAfter()` — icon position.
- `addMatchPrefix($string)` — prepend a namespace before auto-matching (e.g. `local_task`).
- `setMatchString($string)` — override the string used for auto icon lookup.

Auto lookup: if no icon is set, `MiconIconize` asks `plugin.manager.micon.discovery`
(`getDefinitionMatch`) to map the (lowercased, tag-stripped) string to an icon id via the
`micon_icons` definitions — see [../plugins/micon-icons.md](../plugins/micon-icons.md).

In a class, use the trait instead of the global function:
```php
use Drupal\micon\MiconIconizeTrait;
class Foo {
  use MiconIconizeTrait;              // provides $this->micon(...)
  public function label() { return $this->micon('Delete')->setIcon('fa-trash'); }
}
```

`MiconIcon` object helpers: `getSelector()`, `getType()` (font|image), `getHex()` (font code),
`getNames()`/`getAliases()`, `addClass()`, `setAttribute()`, `toRenderable()`, `toMarkup()`.
