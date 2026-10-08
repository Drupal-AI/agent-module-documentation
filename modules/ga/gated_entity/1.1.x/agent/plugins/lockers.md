<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gated Entity — locker plugins

## Plugin type
`@GatedEntityLocker` annotation (`src/Annotation/GatedEntityLocker.php`), managed by `GatedEntityLockerManager` (service `plugin.manager.gated_entity_locker`). Base class `GatedEntityLockerBase` implements `GatedEntityLockerInterface`.

## Interface contract
- `checkAccess(): bool` — TRUE = content shown, FALSE = locked.
- `buildLocker(): array` — render array shown in place of the content.
- `getForm()` — builds the plugin's `form_class` (a FormBase) if declared.
- `getLabel()` / `getDescription()`.

## Shipped plugin — LoginLocker
```
@GatedEntityLocker(
  id = "login_locker",
  label = @Translation("Login to unlock"),
  form_class = "\Drupal\gated_entity\Form\PasswordLockerForm"
)
```
`checkAccess()` returns TRUE for any authenticated user; `buildLocker()` renders a `user.login` link with a `destination` back to the current path.

## Writing your own
Create a plugin in `src/Plugin/GatedEntityLocker/`, extend `GatedEntityLockerBase`, implement `checkAccess()` (your unlock condition) and `buildLocker()` (the locked-state UI). Select it as the default locker on the config form.
