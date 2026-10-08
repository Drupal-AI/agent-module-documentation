<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting Title help text (and the Linkit widget tweak)

Pipewrench has **no settings page of its own**. Its two behaviours are configured, respectively,
from the node type form and (automatically) from the presence of the Linkit module.

## Title help text

Enabling the module adds a **"Title field help text"** textfield to every content type's
add/edit form, under the *Submission form settings* section (`node_type_form`, in
`$form['submission']['title_description']`).

Where: `admin/structure/types/manage/{bundle}` (or `admin/structure/types/add`). Requires the
**Administer content types** permission (`administer content types`) — the standard gate on that
form.

On save, the module's custom submit handler (`PipewrenchHooks::nodeTypeFormSubmit`):
1. Loads or creates a `base_field_override` config entity for `node.{bundle}.title`.
2. Copies label / required / translatable / settings from the entity type's base `title`
   definition when creating a new override.
3. Calls `->setDescription($title_description)->save()` and clears cached field definitions.

Result: the Title field on that content type's node add/edit form now shows the help text as its
description. Clearing the field and saving removes the text (the override's description is set to
the empty string; the override entity itself is not deleted).

### Doing it in code / config

The same effect is a plain `base_field_override` — no Pipewrench API is involved, so you can also
create or export it directly:

```php
\Drupal::entityTypeManager()->getStorage('base_field_override')->create([
  'field_name'   => 'title',
  'entity_type'  => 'node',
  'bundle'       => 'article',
  'label'        => 'Title',
  'description'  => 'Keep under 60 characters for search results.',
])->save();
```

The override is exportable config (`core.base_field_override.node.article.title.yml`), so the help
text travels with the content type through a config sync.

## Linkit widget help text

There is nothing to configure. If (and only if) the contrib **Linkit** module is installed, the
`field_widget_info_alter` hook swaps the `linkit` widget's class to
`Drupal\pipewrench\Plugin\Field\FieldWidget\PipewrenchLinkitWidget`. That subclass extends Linkit's
own `LinkitWidget` and rewrites the URI element's `#description` to:

> "Start typing to find content or paste a URL and click on the suggestion below."

This applies wherever the Linkit widget is selected for a `link` field (Manage form display).
Because Linkit is not a declared dependency, on a site without Linkit this behaviour is simply
inert — the widget id `linkit` does not exist, so the alter does nothing.

## What the module does NOT provide

No routes, no permissions of its own, no `config/schema`, no Drush commands, and no plugin type
you can implement against. `pipewrench.module` is an empty stub; all logic lives in
`src/Hook/PipewrenchHooks.php` and the one widget class.
