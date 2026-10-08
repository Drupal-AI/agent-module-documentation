<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Link Title" formatter

## Install & enable

```bash
composer require drupal/link_title_formatter
drush en link_title_formatter -y
```

Only dependency is core **`link`** (declared `drupal:link` in `link_title_formatter.info.yml`).
No sub-modules, no permissions, no Drush commands, no config schema, no hooks, no services.

## Enable it on a field

The plugin (id **`link_title`**, label *"Link Title"*) applies to **core link fields**
(`field_types = { "link" }`). It does not apply to any other field type.

UI path: *Structure → (bundle) → Manage display* → set a **Link** field's format to **Link Title**.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_my_link.type link_title -y
drush cr
```

(README calls it the *"Link Title Text"* formatter, but the plugin's actual label is **"Link
Title"**.)

## What it renders

Class `LinkTitle` (`src/Plugin/Field/FieldFormatter/LinkTitle.php`) **extends core's
`LinkFormatter`** and overrides just two methods:

- `viewElements(FieldItemListInterface $items, $langcode)` — for each `$item` where
  `!empty($item->title)`, it builds `$element[$delta] = ['#markup' => Html::escape($item->title)]`.
  Items with an empty title are skipped (nothing rendered for that delta). The link's **URI is
  never used** and **no `<a>` element is produced** — the output is the title text only.
- `defaultSettings()` — returns `['trim_length' => ''] + parent::defaultSettings()`.

Because the title is passed through `Html::escape()` (`Drupal\Component\Utility\Html`), a title
containing markup such as `<b>` or `<script>` is displayed as literal text, not rendered as HTML.

## Settings are inherited but inert

`LinkTitle` does **not** override `settingsForm()` or `settingsSummary()`, so on Manage display it
still shows the settings it inherits from `LinkFormatter` — **Trim link text length**, **URL only**,
**Show URL as plain text**, **Add rel="nofollow"**, **Open link in new window** (`target=_blank`).

**None of these affect the output.** The overridden `viewElements()` reads only `$item->title` and
ignores every setting, including `trim_length` — even though `defaultSettings()` adds a
`trim_length` key (set to an empty string). Treat the settings form as decorative for this
formatter; long titles are not trimmed regardless of the value entered.

## When to use it

Use it to surface a link field's label without a clickable anchor — e.g. to feed a UI Patterns
button that takes URL and label as separate fields (see the module README), to avoid a nested
anchor inside a card that is already a link, or to show the label in a print/email view mode. To
render the URL separately, pair it with a copy of the field (README suggests the Display Copy Field
module).
