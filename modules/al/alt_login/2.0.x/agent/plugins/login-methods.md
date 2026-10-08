<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# alt_login — AltLoginMethod plugin type & login resolution

## Plugin type
- Manager: service `alt_login.method_manager` = `Drupal\alt_login\AltLoginMethodManager`
  (extends `DefaultPluginManager`; subdir `Plugin/AltLoginMethod`, interface
  `AltLoginMethodInterface`, attribute `Drupal\alt_login\Attribute\AltLoginMethod`, alter hook
  `alt_login_info`). Constructed with `@container.namespaces`, `@module_handler`, `@config.factory`.
- Attribute `#[AltLoginMethod(id, label, description)]` (`src/Attribute/AltLoginMethod.php`).
- Manager helpers: `getOptions()` (id→label for the form), `getActiveLabels()` (lowercased labels of active
  plugins), `activePlugins()` (instantiates each plugin ID listed in `aliases`), `getDefinitions()`
  (forces `username` last; drops `address_name` when the `address` module is absent).

## `AltLoginMethodInterface`
- `applies($alias): bool` — cheap pre-filter: is this typed string worth testing for this method?
- `getUserFromAlias($alias): ?UserInterface` — resolve a typed identifier to the account.
- `getAlias(UserInterface $user): string` — the user's alias for this method (for hints/display).
- `dedupeAlias(UserInterface $user): string|false` — return a field name if another account already owns
  this alias (used by the account-form validator `alt_login_validate_dedupe_aliases`).
- `entityQuery(Condition $or_group, $match)` — add match conditions for the selection handler.

## Core plugins (`src/Plugin/AltLoginMethod/`)
- **`username`** (`Username.php`): base class for the others. `applies()` always TRUE;
  `getUserFromAlias()` = `entityTypeManager->getStorage('user')->loadByProperties(['name' => $alias])`;
  `getAlias()` = lowercased account name; `dedupeAlias()` returns FALSE (core already enforces unique
  names); `entityQuery()` adds `name STARTS_WITH $match`.
- **`email`** (`Email.php`, extends Username): `applies()` = `email.validator` isValid; `getUserFromAlias()`
  = `loadByProperties(['mail' => $alias])`; `getAlias()` = lowercased email; `entityQuery()` = `mail
  STARTS_WITH`.
- **`uid`** (`Uid.php`, extends Username): `applies()` true when `(int)$alias == $alias`; `getUserFromAlias()`
  = `User::load($alias)`; `getAlias()` = the uid; `entityQuery()` = `uid == $match` when numeric.
- **`address_name`** (`AddressName.php`): only registered when `address` is installed. `applies()` always
  TRUE; alias = `given_name family_name` from the user's first Address-type field (`fieldName()` scans
  `entity_field.manager` field defs); `getUserFromAlias()`/`dedupeAlias()` look accounts up by that
  concatenated name; `entityQuery()` matches given/family name parts.

## How a login resolves (username → account)
Login/registration forms and the basic-auth provider both call the utility
`alt_login_convert_alias($alias)` (`alt_login.module`):
1. iterate `activePlugins()` (the enabled `aliases`, username forced last);
2. the first plugin whose `applies($alias)` is TRUE and whose `getUserFromAlias()` returns a user wins;
3. return that user's real `getAccountName()`. If nothing matches, return `' '` (a single space — an
   invalid username that safely fails core validation).

On the login form, `alt_login_form_alter()` adds `alt_login_login_name_element_validate()` to the name
element, which converts the typed alias to the real username and writes it back into the `name` form value
**before** core's own login validator runs. **Core still performs the password check and flood control
against the resolved account** — this module only rewrites the identifier, it does not authenticate.

## Entity-reference selection
`Plugin/EntityReferenceSelection/AltLoginUserSelection` (id `default:altlogin`, group `alt_login`, extends
core `UserSelection`) overrides `buildEntityQuery()` to OR together each active plugin's `entityQuery()`
conditions (with `accessCheck(1)` + `user_access`/`entity_reference` tags), so autocomplete searches users
by their configured aliases instead of only the username.
