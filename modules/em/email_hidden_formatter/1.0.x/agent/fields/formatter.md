<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Email Hidden" formatter

## Install & enable

```bash
composer require drupal/email_hidden_formatter
drush en email_hidden_formatter -y
```

Only dependency is core **`field`** (info.yml: `dependencies: [drupal:field]`). No sub-modules, no
permissions of its own, no Drush commands, no config to install (only a schema file). The
`.module` file is an empty stub — no hooks.

## Enable it on a field

The formatter (plugin id **`email_hidden`**, label *"Email Hidden"*) applies to **core email
fields** only (`field_types = { "email" }` in `EmailHiddenFormatter`). It does not apply to
string, link or any other field type.

UI path: *Structure → (bundle) → Manage display* → set the email field's format to
**Email Hidden** → gear icon to set the link text.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_email.type email_hidden -y
drush cr
```

## The one setting

From `defaultSettings()` / `settingsForm()` in
`src/Plugin/Field/FieldFormatter/EmailHiddenFormatter.php`:

| Setting key | Default | Meaning |
|---|---|---|
| `title` | `Show email` | Text of the link shown in place of the address. `settingsForm()` exposes it as a textfield ("Link title"); `settingsSummary()` prints "Link title: @title" on the Manage-display summary. |

Config schema: `config/schema/email_hidden_formatter.schema.yml` defines
`field.formatter.settings.email_hidden` → mapping with a single `title` (string).

## How the address is hidden and revealed

The obfuscation is **omission**, not encoding or masking. On initial render `viewElements()` emits,
for each field delta, a link render element and **never outputs the email string**:

```php
$elements[$delta] = [
  '#type' => 'link',
  '#title' => $this->getSetting('title'),
  '#url' => Url::fromRoute('email_hidden_formatter.email_hidden', [
    'entity_type' => $entity->getEntityTypeId(),
    'entity_id'   => $entity->id(),
    'field_name'  => $field_name,
    'label'       => $label_visibility,
  ]),
  '#attributes' => ['class' => ['use-ajax'], 'data-custom' => 'email-hidden-formatter'],
];
```

`$label_visibility` is read from the field's component in the entity view display
(`entityDisplayRepository->getViewDisplay(...)->getComponent($field_name)['label']`, default
`above`) so the revealed field keeps the same label placement (`hidden`/`inline`/`above`).

Because the raw address is absent from the served HTML, HTML-source scrapers do not see it. The
address is fetched only on the reveal step.

### The reveal route + controller

Route `email_hidden_formatter.email_hidden` (`email_hidden_formatter.routing.yml`):

```yaml
path: '/email-hidden-formatter/process/{entity_type}/{entity_id}/{field_name}/{label}'
defaults:
  _controller: '\Drupal\email_hidden_formatter\Controller\EmailHiddenController::process'
requirements:
  _permission: 'access content'
  entity_id: \d+
```

`EmailHiddenController::process(string $entity_type, int $entity_id, string $field_name, string $label)`
(`src/Controller/EmailHiddenController.php`):

1. `entityTypeManager()->getStorage($entity_type)->load($entity_id)` — loads the entity.
2. Guards: returns a JSON error if the entity is missing (404), the field is absent (400), or the
   field is empty (400).
3. `$render_array = $field->view(['label' => $label]); $rendered = $this->renderer->render($render_array);`
   — renders the field with its **default** email formatter (so the actual `mailto:`/address markup
   is produced here, escaped by the core email formatter, not by this module).
4. Returns an `AjaxResponse` with `new ReplaceCommand('.field--name-' . str_replace('_','-',$field_name), $rendered)`
   — replacing the placeholder link in the DOM with the revealed field.

The controller injects only the core `renderer` service (`create()`); the formatter injects
`entity_display.repository`.

## Operating notes / caveats

- **Core AJAX must be present.** The link relies on the `use-ajax` class handled by
  `core/drupal.ajax`, but `viewElements()` does not `#attach` that library. If no other element on
  the page loads `core/drupal.ajax`, clicking the link simply navigates to the route (which returns
  an AJAX/JSON response) instead of swapping in place. In practice most admin/theme pages already
  load it; on a bare front-end you may need the library attached.
- The reveal re-renders with the field's **default** formatter — configure that field type's normal
  display expectations accordingly.
- No site-wide configuration form exists; everything is per view-display.
- Works with multi-value email fields (one link per delta), though all deltas share the same
  `.field--name-<field>` target on replace.
