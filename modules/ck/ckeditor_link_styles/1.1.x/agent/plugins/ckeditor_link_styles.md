<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CKEditor 5 Link Styles plugin

The module **defines no plugin types of its own** — it *provides* one CKEditor 5 plugin and
plugs into core's Link feature. This doc explains how that plugin is built, so you can reason
about its config and behaviour (or model a similar CKEditor 5 configurable plugin).

## Plugin definition — `ckeditor_link_styles.ckeditor5.yml`

- **Plugin id:** `ckeditor_link_styles_linkStyles`
- **PHP class:** `Drupal\ckeditor_link_styles\Plugin\CKEditor5Plugin\LinkStyles`
- **No JS plugin / no toolbar item:** `ckeditor5.plugins: []`, `library: false`. It ships no
  new button — it reconfigures the existing Link plugin.
- **Elements:** `<a class>` (so the format's allowed HTML permits classed anchors).
- **Condition:** `plugins: [ckeditor5_link]` — it only activates when the core **Link**
  button is enabled on the format. If Link is not on the toolbar, the Link styles UI does not
  appear.

## How it works — Link manual decorators

`LinkStyles` implements `CKEditor5PluginConfigurableInterface` (a settings form) and
`CKEditor5PluginElementsSubsetInterface` (dynamic allowed elements).

- **`buildConfigurationForm()`** renders a single textarea. Editors type
  `a.classA.classB|Label` lines; `validateConfigurationForm()` parses them with the regex
  `^(a)((\.[\w-]+)+)$` on the selector — anchor tag + one or more classes required, then a
  `|Label`. Bad lines raise "Line N does not contain a valid value."
- **Stored form:** each parsed line becomes `{label, element}` where `element` is the
  CKEditor 5 element string, e.g. `<a class="btn">` (see the configure doc for the config
  path `settings.plugins.ckeditor_link_styles_linkStyles.styles`).
- **`getElementsSubset()`** returns `['<a class>']` when at least one style exists (empty
  otherwise) — this is what auto-updates the format's allowed HTML.
- **`getDynamicPluginConfig()`** is the heart of it: for each configured style it appends a
  CKEditor 5 **Link manual decorator** to the editor's runtime config:

  ```php
  $config['link']['decorators'][] = [
    'mode' => 'manual',
    'label' => $style['label'],
    'attributes' => ['class' => 'btn large-button'],
  ];
  ```

  CKEditor 5 then shows each decorator as a **checkbox inside the Add/Edit-link balloon**, so
  applying a class is part of creating the link — no separate Styles-dropdown step. Only `a`
  tags are supported (non-anchor elements are skipped).

## Config schema — `ckeditor5.plugin.ckeditor_link_styles_linkStyles`

```yaml
styles:                 # sequence, unique by label
  - label:              # ckeditor5 label
    element:            # ckeditor5.element, must be an <a> with >= 1 class
```
`element` is validated by `CKEditor5Element` (exactly the `class` attribute, ≥1 class value)
and `StyleSensibleElement`.

## Why decorators instead of the Styles dropdown

Core's Styles dropdown applies classes awkwardly to links (upstream CKEditor 5 issue
#11709). By generating Link decorators, this module makes the class a first-class option in
the link dialog — the module's whole reason to exist. See the project README for the
upstream issue links.
