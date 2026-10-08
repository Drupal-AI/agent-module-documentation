<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body Inject (body_inject) — agent index

Injects a chosen **block** into a node's **body field** at a configurable position, on the full view
of matching nodes. Fork of the D7 `block_inject`. Package `Custom`. Version **1.1.1-beta3**. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Composer requires **`drupal/token_block`**
(`^1|^2`); no `dependencies:` in the info.yml.

- **Profiles config entity, its routes/permission, the condition + placement fields, and the
  injection mechanism (`hook_entity_view_alter`)** → [config/profiles.md](config/profiles.md)

## What it actually is

- One **config entity type**: `body_inject_profile` (`src/Entity/Profile.php`,
  `admin_permission = "administer body_inject profiles"`, config prefix `body_inject_profile`).
  Each profile stores: `block_reference`, `node_type`, `paragraph_operator`/`paragraph_number`,
  `and_or`, `char_operator`/`char_number`, and three placement fields `paragraph_offset`,
  `paragraph_position`, `char_position`.
- One **permission**: `administer body_inject profiles` (`body_inject.permissions.yml`) — gates all
  four entity routes.
- **Routes** (`body_inject.routing.yml`): collection / add / edit / delete under
  `/admin/config/content/body_inject`, all requiring that permission. Menu link under
  *Configuration → Content*; `configure = entity.body_inject_profile.collection`.
- **The engine is procedural**, in `body_inject.module`:
  `body_inject_entity_view_alter()` → `body_inject_profiles()` (loads all profiles) →
  `body_inject_adv_process_condition()` (length test) → `body_inject_adv_node()` (renders the block
  and splices it into the body string) → `body_inject_operator_check()` (`<`/`=`/`>` compare).
- **No** services (`*.services.yml` absent), **no** Drush, **no** install/update hooks
  (`body_inject.install` is an empty stub), **no** JS/CSS libraries.

## Provided but effectively dead code

- `src/Controller/AutocompleteController.php` and `src/Element/BodyInject.php` (a `@FormElement`)
  reference a `body_inject.result_manager` service, a `ResultManager` class, an
  `body_inject/body_inject.autocomplete` library and `entity.manager` — **none of which exist** in
  the module, and no route points at the controller. They are leftovers from the Linkit-derived
  scaffold and are never reached.
- `src/Controller/BodyInjectController::profileTitle()` is the only live controller method (the edit
  route's `_title_callback`).
