<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — the four block plugins (and the form-mode hook)

The module **defines no plugin type**; it only *implements* core's `@Block` plugin type.
All four classes live in `Drupal\formblock\Plugin\Block\` and use the classic
`@Block` annotation (not PHP attributes), category `Forms`.

## `formblock_node` — `NodeFormBlock`

```php
$node = $this->entityTypeManager->getStorage('node')->create(['type' => $this->configuration['type']]);
$build['form'] = $this->entityFormBuilder->getForm($node, $this->configuration['form_mode']);
```

- Injects `entity_type.manager`, `entity.form_builder`, `entity_display.repository`.
- `defaultConfiguration()`: `['type' => NULL, 'form_mode' => 'default', 'show_help' => FALSE]`.
- With `show_help` on it prepends `NodeType::getHelp()` through `Xss::filterAdmin()`.
- The node is created **unsaved**; submitting the block's form saves a real node and
  redirects the way the normal node form would.
- Access = `getAccessControlHandler('node')->createAccess($type, $account, [], TRUE)`
  plus the node type's cache tags.

## `formblock_user_register` — `UserRegisterBlock`

```php
$account = $this->entityTypeManager->getStorage('user')->create([]);
$build['form'] = $this->entityFormBuilder->getForm($account, $this->configuration['form_mode']);
```

- `defaultConfiguration()`: `['form_mode' => 'register']`.
- The configure form shows a hard-coded note that
  *Account settings → Who can register accounts* overrides the block.
- `blockAccess()` returns forbidden for users without the `administrator` role when
  `user.settings:register === UserInterface::REGISTER_ADMINISTRATORS_ONLY`
  (cache context `user.roles`, cache tags of `user.settings`).

## `formblock_contact` — `ContactFormBlock`

- Annotation carries `provider = "contact"`, so the block disappears if the core
  **Contact** module is uninstalled.
- `defaultConfiguration()` reads `contact.settings:default_form`.
- `build()` creates an unsaved `contact_message` for the selected `contact_form` entity and
  renders it with `entity.form_builder`; first it calls `floodControl()` which checks
  `flood.isAllowed('contact', contact.settings:flood.limit, flood.interval)` and returns the
  "You cannot send more than %limit messages in @interval" markup instead of the form.
  Users with `administer contact forms` bypass the flood check.
- `blockAccess()`: contact form entity `view` access **and** the
  `access site-wide contact form` permission, cached per permissions.

## `formblock_user_password` — `UserPasswordBlock`

The whole build method:

```php
$build['form'] = $this->formBuilder->getForm('Drupal\user\Form\UserPasswordForm');
```

No settings, no `blockForm()`, no `blockAccess()` override.

## `formblock_entity_type_alter()` — why the form-mode selector works

`formblock.module` implements `hook_entity_type_alter()` for the `node` and `user` entity
types. For every form mode returned by `entity_display.repository`'s `getFormModes()` that
has **no** form handler class registered, it copies the entity type's `default` form class
onto that form-mode key:

```php
$type->setFormClass($form_mode_id, $entity_form_handlers['default']);
```

Without this, `EntityFormBuilder::getForm($entity, 'my_mode')` would fail because the
operation has no form class. Consequence: **any** node or user form mode you create is
immediately usable as a block form mode. It also means you cannot register a *different*
form class for a node/user form mode and expect formblock to leave it alone — it only fills
in modes that are still missing a class.

## Extending

There is no plugin type to implement and no hook to alter formblock's own behaviour. To
render some other entity's form as a block, subclass `BlockBase` yourself and copy the
`NodeFormBlock` pattern (`create()` an unsaved entity, then
`entity.form_builder->getForm($entity, $form_mode)`); to change formblock's own blocks, use
core's `hook_block_alter()` to swap the `class` in the plugin definition.
