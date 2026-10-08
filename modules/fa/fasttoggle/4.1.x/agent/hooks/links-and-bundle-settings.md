<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fasttoggle hooks: link injection and per-bundle settings

All hooks live in `Drupal\fasttoggle\Hook\FasttoggleHooks` (`src/Hook/FasttoggleHooks.php`), an
autowired service (`fasttoggle.services.yml`) declared with `#[Hook]` attributes. `fasttoggle.module`
holds `#[LegacyHook]` wrapper functions that forward to the service. Constructor dependencies:
`ConfigFactoryInterface`, `AccountProxyInterface` (current user), `EntityTypeManagerInterface`.

## Adding toggle links

- `#[Hook('node_links_alter')]` `nodeLinksAlter(&$links, NodeInterface $entity, &$context)`:
  when the current user has `use fasttoggle`, loads the node's `node_type` and reads its `fasttoggle`
  third-party settings (`status`, `promote`, `sticky`, default `0`). For each enabled one it adds a
  link built by `createNodeLink()` under `$links['node']['#links']['fasttoggle-{bundle}-{action}']`.
- `#[Hook('comment_links_alter')]` `commentLinksAlter(&$links, CommentInterface $entity, &$context)`:
  same pattern for the comment's `comment_type` `status` third-party setting, via `createCommentLink()`.

`createNodeLink()` / `createCommentLink()` build a render-array link:

- `title` — computed from `label_style` (see [../config/settings.md](../config/settings.md)) and the
  entity's current `isPublished()` / `isPromoted()` / `isSticky()` state, via `$this->t()` (static,
  translatable strings only).
- `url` — `Url::fromUserInput('/fasttoggle/{node|comment}/{id}/{action}')`.
- `attributes.class` — `['use-ajax', 'fasttoggle-node-{action}']` (or
  `fasttoggle-comment-{id}-{action}`). The `use-ajax` class + matching selector class let the
  controller's `ReplaceCommand` swap the link after a click (see [../api/toggle-route.md](../api/toggle-route.md)).

## Adding the per-bundle checkboxes

- `#[Hook('form_node_type_edit_form_alter')]` `formNodeTypeEditFormAlter()`: adds a `Fasttoggle`
  details group (in `additional_settings`) with a "Toggles available" fieldset of three checkboxes —
  `status`, `promote`, `sticky` — defaulted from the node type's `fasttoggle` third-party settings.
  Registers `nodeTypeFormBuilder()` as an entity builder, which writes the submitted values back with
  `setThirdPartySetting('fasttoggle', …)`.
- `#[Hook('form_comment_type_edit_form_alter')]` `formCommentTypeEditFormAlter()`: same, with a single
  `status` checkbox; entity builder `commentTypeFormBuilder()`.

## Help

- `#[Hook('help')]` `help()`: on `help.page.fasttoggle`, reads the module `README.md` and returns it
  wrapped in `<pre>` with `Html::escape()`.
