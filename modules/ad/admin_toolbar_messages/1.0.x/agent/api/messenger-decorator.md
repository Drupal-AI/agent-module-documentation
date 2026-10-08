<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# admin_toolbar_messages — messenger decorator & toolbar integration

How the module relocates admin-route status messages. Cite: `src/AdminAwareMessenger.php`,
`src/AdminToolbarMessagesBuilder.php`, `src/Hook/ToolbarHooks.php`, `src/Hook/ThemeHooks.php`,
`src/Plugin/TopBarItem/AdminMessagesTopBarItem.php`, `admin_toolbar_messages.services.yml`.

## Install / enable

`drush en admin_toolbar_messages`. Nothing to configure. It only has a visible effect when the
core **Toolbar** and/or **Navigation** module is enabled. No permissions, routes, config or schema.

## Service decoration

`services.yml` declares (autowire on):

- `AdminAwareMessenger` with `decorates: 'messenger'` — replaces the core messenger for the whole
  container while wrapping the original as `$inner`.
- `Hook\ThemeHooks` and `Hook\ToolbarHooks` as plain services (invoked by the `#[LegacyHook]`
  shims in `admin_toolbar_messages.module`).

## AdminAwareMessenger API (implements `MessengerInterface`)

Constructor: `MessengerInterface $inner`, `AdminContext $adminContext`. Constant
`TYPE_PREFIX = 'admin:'`. `isAdminContext()` = `$adminContext->isAdminRoute()`.

- `addMessage($message, $type, $repeat)` — on an admin route, delegates to `addAdminMessage()`
  (stores under `admin:<type>`); otherwise passes through to `$inner` unchanged. `addStatus()`,
  `addError()`, `addWarning()` route through `addMessage()`.
- `addAdminMessage($message, $type, $repeat)` — always stores under the `admin:` prefix regardless
  of route. Public API for code that wants to force a message into the toolbar drawer.
- `all()` / `deleteAll()` — return the non-prefixed messages, and **only on an admin route** merge
  the `admin:` ones back in (so admin pages still print them inline). Off admin routes the prefixed
  messages stay queued in the session.
- `allAdmin()` / `allExceptAdmin()` / `deleteAllAdmin()` / `deleteAllExceptAdmin()` — partition
  the queue by the prefix; the delete variants call `$inner->deleteByType()` per type. `allPrefixed(bool)`
  is the private helper that strips/keeps the prefix.
- `messagesByType()` / `deleteByType()` — pass through to `$inner`, with `deleteByType()` also
  clearing the `admin:`-prefixed variant while on an admin route.

## Rendering path

- `AdminToolbarMessagesBuilder::build()` — `#[TrustedCallback]`. Returns `[]` on admin routes;
  otherwise calls `$messenger->deleteAllAdmin()` and, if non-empty, returns a render array with
  `#theme => 'status_messages__admin_toolbar_messages'`, `#message_list`, and `#status_headings`.
- `ToolbarHooks::onBuild()` (`#[Hook('toolbar')]`) — adds item `admin_toolbar_messages` with a
  `tab.messages` `#lazy_builder` pointing at `AdminToolbarMessagesBuilder::build`,
  `#create_placeholder => TRUE`, `#weight => 1100`, wrapper class `admin-toolbar-messages-tab`,
  attaching library `admin_toolbar_messages/toolbar`. Returns `[]` on admin routes.
- `AdminMessagesTopBarItem::build()` — same lazy-builder placeholder for the Drupal 11 Navigation
  top bar (`#[TopBarItem(region: Actions)]`), attaching `admin_toolbar_messages/navigation`.
  Returns `[]` on admin routes.
- `ThemeHooks::onInfo()` (`#[Hook('theme')]`) — registers `status_messages__admin_toolbar_messages`
  (base hook `status_messages`). `onLibraryInfoAlter()` (`#[Hook('library_info_alter')]`) swaps
  `css/navigation.css` → `css/navigation.gin.css` when both `navigation` and `gin_toolbar` exist.
- Template `status-messages--admin-toolbar-messages.html.twig` groups messages by type in a
  collapsible drawer using a hidden-checkbox toggle; each message is printed via standard Twig
  output (same rendering contract as core `status_messages`).

## Operating notes

- Because `build()` deletes the admin messages as it renders them, they show exactly once, on the
  first non-admin request after the admin action.
- To push a message straight into the drawer from your own code:
  `\Drupal::messenger()->addAdminMessage($text, 'status')` (the decorator is the active messenger).
- Disable the module to restore stock messenger behaviour; no config is left behind (none is created).
