<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book condition plugin (`book`)

`src/Plugin/Condition/BookVisibility.php` — class `BookVisibility extends ConditionPluginBase
implements ContainerFactoryPluginInterface`. Annotation: `@Condition(id = "book", label = "Book")`.
This is a standard core **block/condition** plugin; core discovers and executes it wherever
Condition plugins apply (the block placement UI is the intended use).

## Install / enable

`drush en book_visibility`. Requires core **Book** and **Block** modules enabled (not declared in
`.info.yml`, but the plugin type-hints `Drupal\book\BookManagerInterface` and the JS library depends
on `block/drupal.block`, so both must be present). No settings page — configure per block.

## Dependencies injected (`create()` / `__construct()`)

- `book.manager` (`BookManagerInterface`) → `$this->bookManager`.
- `current_route_match` (`ResettableStackedRouteMatchInterface`) → `$this->currentRouteMatch`.
- `entity_type.manager` (`EntityTypeManagerInterface`) → `$this->entityTypeManagerProperty`.

## Configuration shape

Stored config key: **`book_visibility`** — an array of checkbox values keyed by book node id
(`getStorage('node')` book ids). `submitConfigurationForm()` runs `array_filter()` on the submitted
checkboxes and only saves the key when at least one book is checked (`count(... ) > 0`). There is
**no `config/schema/`** in this module, so the `book_visibility` sub-mapping is schema-less (expect
config-schema notices under strict schema checking / tests).

## Methods

- `getBookOptions()` — builds the checkbox `#options`: iterates `bookManager->getAllBooks()`, loads
  each top-level book node, uses `ucfirst($book->label())` as the label. (Values are book node ids.)
- `buildConfigurationForm()` — adds `book_visibility` as a `checkboxes` element titled *"Available
  books"*. Default value is the stored config **only if** `max(array_values(...)) > 0`, else `[]`
  (an all-zero/empty stored value is treated as "no restriction"). Calls
  `parent::buildConfigurationForm()`.
- `submitConfigurationForm()` — see config shape above; then `parent::submitConfigurationForm()`.
- `summary()` — returns *"Restricted to specified books"* when `book_visibility` is truthy, else
  *"Not restricted"*.
- `evaluate()` — the visibility decision:
  1. If configured (`max(array_values($config['book_visibility'])) > 0`): read the current node from
     `currentRouteMatch->getParameter('node')`. If it has `->book['bid']`, load that book node and
     take its `->id()`. Loop the configured book ids; **return TRUE** on the first `===` match.
     If there is no node, no `book['bid']`, or no match, the method falls off the end and returns
     **NULL** (falsy → condition FALSE → block hidden).
  2. If **not** configured (empty / all-zero): **return TRUE** — no restriction, block shows
     everywhere. This is the intended "unconfigured = no filter" default, not an access bypass.

Negation is handled by core: `ConditionPluginBase`/`execute()` applies the "Negate the condition"
checkbox, so a configured condition can also mean "show everywhere *except* these books".

## Hooks & JS (in `book_visibility.module` / `assets/js/booklet_condition.js`)

- `book_visibility_form_block_form_alter()` attaches library `book_visibility/block` to
  `$form['visibility']['visibility_tabs']` when `$form['visibility']['book']` exists.
- `Drupal.behaviors.blockSettingsSummaryBook` sets the vertical-tab summary text based on whether any
  `edit-visibility-book-book-visibility` checkbox is `[checked]`.

## Scope / caveats

- **Visibility only.** This plugin governs whether a block is placed on the page. It does NOT
  implement `hook_node_access` and does NOT restrict access to book node pages — those remain fully
  reachable by URL under core node access regardless of this condition. Use core node access /
  permissions to protect book *content*.
- `evaluate()` matches on the current route's `node` book id, so it is meaningful only on node
  (book-page) routes; on non-node routes an unconfigured condition returns TRUE and a configured one
  resolves to hidden.
