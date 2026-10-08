<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set title help text for a content type

No settings page. You set the help text **per content type**, on that type's edit form, or
directly in config.

## Where it is stored

Config entity `node.type.<bundle>`, third-party setting:

```yaml
third_party_settings:
  node_title_help_text:
    title_help: 'Enter a short, descriptive title.'
```

Schema: `node.type.*.third_party.node_title_help_text` → single `title_help` (type `text`).

## Via the UI

1. Go to *Structure → Content types* and **Edit** the content type
   (`/admin/structure/types/manage/<bundle>`).
2. Scroll to the **Submission form settings** vertical tab.
3. Fill in **Title field help text** (description: "This text will be displayed at the bottom
   of title field when creating or editing content of this type.").
4. **Save content type**. The text now appears under the Title field on that type's add/edit
   form.

## Via drush

```bash
# read:
drush config:get node.type.article third_party_settings.node_title_help_text.title_help
# set:
drush config:set node.type.article third_party_settings.node_title_help_text.title_help 'Enter a short, descriptive title.' -y
```

## Via PHP

```php
$type = \Drupal\node\Entity\NodeType::load('article');
$type->setThirdPartySetting('node_title_help_text', 'title_help', 'Enter a short, descriptive title.');
$type->save();

// read it back:
$help = $type->getThirdPartySetting('node_title_help_text', 'title_help');
```

## Important behavior

- The help text is applied as the title widget's `#description` **only if the title field has
  no description yet** — if another module already set one, this module leaves it alone.
- It has no effect if `title_help` is empty/unset.
- It also applies inside Inline Entity Form node widgets (see
  [../api/mechanism.md](../api/mechanism.md)).
- Uninstalling the module removes `title_help` from every node type.
