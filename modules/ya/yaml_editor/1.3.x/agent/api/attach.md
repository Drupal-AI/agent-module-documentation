<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach the YAML editor to a field or a form

There is no service or PHP API to call — you opt a textarea in by giving it the
`data-yaml-editor` attribute (on an admin route). Two supported paths:

## 1. On a field (no code) — the `yaml_editor` widget

For any *Text (plain, long)* field (`string_long`):

1. Go to the entity's **Manage form display**.
2. Set the field's widget to **"Text area with YAML editor"** (widget id `yaml_editor`).
3. Save. The widget (subclass of core `StringTextareaWidget`) renders a normal textarea plus
   `data-yaml-editor="true"`, so Ace mounts on it. It keeps the core `rows`/`placeholder`
   widget settings.

Set it from config: in the form-display's `content.<field>.type` use `yaml_editor`, e.g.

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd->getComponent("field_my_yaml");
  $c["type"] = "yaml_editor";
  $fd->setComponent("field_my_yaml", $c)->save();
'
```

## 2. In your own form — add the attribute

Add `data-yaml-editor` to any `#type => textarea` element rendered on an admin route:

```php
$form['config'] = [
  '#type' => 'textarea',
  '#title' => $this->t('Configuration'),
  '#attributes' => ['data-yaml-editor' => 'true'],
];
```

That is all the module keys off. You do **not** attach the library yourself —
`yaml_editor_page_attachments()` attaches `yaml_editor/yaml_editor` on every admin route.

## Behavior details

- Runs only on **admin routes** (`router.admin_context`); attribute on a front-end form is a
  no-op.
- The JS (`Drupal.behaviors.yamlEditor`) uses `once('yaml-editor', ...)`, hides the original
  textarea (`visually-hidden`), mounts Ace with mode `ace/mode/yaml`, tab size 2,
  `minLines: 3` / `maxLines: 20`, and syncs Ace changes back into the textarea's `value` on
  every `change` so standard form submit still posts the edited YAML.
- No server-side YAML parsing/validation happens — invalid YAML still submits.
- Ships no `*.api.php`; other modules integrate simply by emitting the attribute (Linked
  Field, Menu Link Attributes, Block Attributes, Responsive SVG do this).
