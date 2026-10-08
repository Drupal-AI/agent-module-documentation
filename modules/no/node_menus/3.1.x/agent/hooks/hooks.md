# Hooks

## Hook this module invokes (implement in your module)

### `hook_node_menus_available_menus_alter(array &$available_menus, array &$form, array $context)`

Defined in `node_menus.api.php`; invoked from `form_node_form_alter` via
`$this->moduleHandler->alter('node_menus_available_menus', $available_menus, $form, $context)`. It lets you
change, per node form, which menus are available before the menu parent selectors are built — and the altered
settings are also used to locate an existing menu link for the node.

Invoked **only** for translatable content types that have language menus enabled (and only after core menu_ui
has added `$form['menu']`).

- `$available_menus` — per-language settings for the content type, keyed by language code. Each value has:
  - `available_menus`: (array) menu IDs available for that language.
  - `parent`: (string) default parent item in `menu_name:menu_item` form.
- `$form` — the node form array (menu_ui elements under `$form['menu']`; the language selectors are added
  after this hook runs).
- `$context` — `form_state` (`FormStateInterface`) and `node` (`NodeInterface`).

```php
use Drupal\Core\Hook\Attribute\Hook;

#[Hook('node_menus_available_menus_alter')]
public function nodeMenusAvailableMenusAlter(array &$available_menus, array &$form, array $context): void {
  // Always make the footer menu available for the "article" content type.
  if ($context['node']->bundle() === 'article') {
    $available_menus['en']['available_menus'][] = 'footer';
  }
}
```

(The `node_menus.api.php` example uses the classic function form; either style works.)

## Hooks this module implements

All implementations are OO hooks on `\Drupal\node_menus\Hook\NodeMenusHooks` using `#[Hook]` attributes.

| Hook | Attribute | Purpose |
|---|---|---|
| `hook_form_BASE_FORM_ID_alter` (node form) | `#[Hook('form_node_form_alter', order: new OrderAfter(modules: ['menu_ui']))]` | Replaces the menu "Parent item" selector(s) with language-scoped options; adds per-language selectors with `#states` and a static validate callback when the language selector is visible. |
| `hook_form_FORM_ID_alter` (node type form) | `#[Hook('form_node_type_form_alter')]` | Adds the "Language menu settings" fieldset; registers static validate + entity-builder callbacks to persist the per-language settings. |

There are no other invoked hooks. `node_menus.module` contains only the file docblock; all logic is in the
`Hook` class.
