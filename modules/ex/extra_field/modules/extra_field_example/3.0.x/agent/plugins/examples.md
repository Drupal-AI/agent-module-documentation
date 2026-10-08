<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example plugins

## Display plugins (`src/Plugin/ExtraField/Display/`)

| id | Class | bundles | weight / visible | Base class | Demonstrates |
|---|---|---|---|---|---|
| `all_nodes` | `ExampleAllNodes` | `node.*` | `-30` / **true** | `ExtraFieldDisplayBase` | simplest possible plugin; returns `['#markup' => 'This is output from ExampleAllNodes']` |
| `article_only` | `ExampleArticle` | `node.article` | `0` / false | `ExtraFieldDisplayBase` | single-bundle targeting |
| `article_only` | `ExampleWithDependencyInjection` | `node.article` | `0` / false | `ExtraFieldDisplayBase` + `ContainerFactoryPluginInterface` | injecting `request_stack`, printing `Request scheme: @scheme` |
| `formatted_field` | `ExampleFormattedField` | `node.article` | `0` / false | `ExtraFieldDisplayFormattedBase` | field-wrapped output, label "Three items" displayed `above`, three items → `#is_multiple` |
| `multilingual_field` | `ExampleMultilingualField` | `node.article` | `0` / false | `ExtraFieldDisplayFormattedBase` | reads `field_tags`, concatenates term labels, `CacheableMetadata` per term, label from the source field, `getLabelDisplay() = 'inline'`, `isTranslatable() = TRUE`, `getLangcode()` from the field, `$this->isEmpty = TRUE` when there are no tags |

Display plugins implement `view(ContentEntityInterface $entity)`
(`ExtraFieldDisplayBase`) or `viewElements(ContentEntityInterface $entity)`
(`ExtraFieldDisplayFormattedBase`).

## Form plugins (`src/Plugin/ExtraField/Form/`)

| id | Class | bundles | weight / visible | Demonstrates |
|---|---|---|---|---|
| `example_markup` | `ExampleMarkup` | `node.*` | `0` / **true** | three markup patterns on a form: bare `#markup`, a `container` with `#markup`, and an `item` with `#title`/`#description` |
| `example_custom_submit` | `CustomSubmit` | `node.*` | `100` / **true** | a `#type => submit` element whose `#submit` is `['::submitForm', [$this, 'addCustomMessage']]`, adding a message after save |
| `example_custom_input` | `ExampleCustomInput` | `user.user` | `0` / **true** | a required "Voucher code" textfield with an element-level `#validate` callback that looks up a `voucher` entity and writes `field_voucher` into `$form_state` |

All extend `ExtraFieldFormBase` and implement
`formElement(array &$form, FormStateInterface $form_state)`.

## What appears where after `drush en extra_field_example`

Because four plugins are `visible = true`, they are added to existing displays by
`EntityDisplayBase::init()` without any config being saved:

```
node/<any bundle>  display : extra_field_all_nodes
node/<any bundle>  form    : extra_field_example_markup, extra_field_example_custom_submit
user/user          form    : extra_field_example_custom_input
node/article       display : also extra_field_article_only, extra_field_formatted_field,
                             extra_field_multilingual_field (available, not visible by default)
```

Verify on a live site:

```bash
drush php:eval '$e = \Drupal::service("entity_field.manager")->getExtraFields("node","article");
  print implode(", ", array_keys($e["display"] ?? [])) . "\n";'
drush php:eval 'print implode(", ", array_keys(\Drupal::service("plugin.manager.extra_field_display")->getDefinitions())) . "\n";'
```

## Two pitfalls to know

1. **Duplicate plugin id.** `ExampleArticle` and `ExampleWithDependencyInjection` both
   declare `id = "article_only"`. Discovery keeps only one — on this site
   `getDefinitions()` returns a single `article_only` entry. Never copy both classes into
   the same module without renaming one.
2. **`example_custom_input` is illustrative only.** Its validator calls
   `$this->entityTypeManager->getStorage('voucher')`, and there is no `voucher` entity type
   in core, so submitting a user form with that pseudo-field enabled raises a
   `PluginNotFoundException`. On a shared/production site remove the component from
   `core.entity_form_display.user.user.default` (`removeComponent()` writes
   `hidden: true`, which also stops `visible = true` from re-adding it) or uninstall the
   submodule.

## Removing it cleanly

```bash
drush pm:uninstall extra_field_example -y
```

Uninstalling drops the plugins; any leftover `extra_field_*` keys in the `content`/`hidden`
sections of display config are inert but can be removed with `removeComponent()` /
unsetting the `hidden` key.
