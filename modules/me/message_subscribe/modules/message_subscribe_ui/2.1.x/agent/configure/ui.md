# Message Subscribe UI — tab, block, views, permission

No admin settings form. You configure it by enabling `subscribe_*` flags, placing the block, and
choosing each flag's listing View.

## The Subscriptions tab

- Route `message_subscribe_ui.tab` → `/user/{user}/message-subscribe`
  (`SubscriptionController::tab`), plus `message_subscribe_ui.tab.flag` →
  `/user/{user}/message-subscribe/{flag}`.
- `MessageSubscribeUiLocalTask` (a local-task deriver) creates one tab per **enabled** subscription
  flag returned by `Subscribers::getFlags()`; the first flag reuses the base tab route.
- `tabAccess()`: allowed if the current user has `administer message subscribe`, otherwise only for
  the account owner and only when the flag is enabled and the user has unflag action access.
- The tab body is a Views preview of the flag's listing view, argument = the account uid.

## Per-flag listing View (`message_subscribe_ui.view_name`)

- Which view+display renders a flag's list is a **flag third-party setting**:
  `message_subscribe_ui.view_name`, formatted `view_id:display_id` (default
  `<flag_prefix>_<flaggable_entity_type>:default`, e.g. `subscribe_node:default`).
- `message_subscribe_ui_form_flag_form_alter()` adds a **"View to use for the Message Subscription
  UI"** select (all views) to every subscription flag's edit form; an entity-builder saves it.
- Read/set in code:
  ```php
  $flag = \Drupal::entityTypeManager()->getStorage('flag')->load('subscribe_node');
  $flag->getThirdPartySetting('message_subscribe_ui', 'view_name');           // 'subscribe_node:default'
  $flag->setThirdPartySetting('message_subscribe_ui', 'view_name', 'subscribe_node:default')->save();
  ```
  (The schema for this setting lives in the base module: `flag.flag.*.third_party.message_subscribe_ui`.)
- Shipped views (config/optional): `subscribe_node`, `subscribe_taxonomy_term`, `subscribe_user`.
  `message_subscribe_email` repoints these to its `*_email` variants on install.

## The "Manage subscriptions" block

- Plugin id `message_subscribe_ui_block` (`Plugin\Block\Subscriptions`), category "Subscriptions".
- On an entity page it renders a checkbox to subscribe/unsubscribe to the current entity and its
  referenced entities (using the first matching `subscribe_*` flag per entity), plus a link to the
  full Subscriptions tab. Only shows when the current user has flag access to a subscribable entity.
- Place it via *Block layout* or a `block.block.*` config entity with `plugin: message_subscribe_ui_block`.

## Permission

`message_subscribe_ui.permissions.yml` defines **`administer message subscribe`** ("Administer user
subscriptions"). This is the permission the **base module's** settings route
(`/admin/config/message/message-subscribe`) requires, and the one that lets a user view/manage other
users' subscription tabs. Grant it to trusted roles.
