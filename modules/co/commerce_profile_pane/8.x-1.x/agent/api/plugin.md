# Pane plugin, deriver & hooks (API)

## Checkout pane plugin — `ProfileForm`

`Drupal\commerce_profile_pane\Plugin\Commerce\CheckoutPane\ProfileForm` extends
`Drupal\commerce_checkout\Plugin\Commerce\CheckoutPane\CheckoutPaneBase`. Annotation:

```php
@CommerceCheckoutPane(
  id = "profile_form",
  label = @Translation("User profile form"),
  default_step = "_disabled",
  wrapper_element = "fieldset",
  deriver = "Drupal\commerce_profile_pane\Plugin\Derivative\ProfileFormCheckoutPaneDeriver",
)
```

Constructor deps (via `create()`): `entity_type.manager` (from the base), `entity_display.repository`,
`current_user`, `language_manager`. It defines **no** service of its own.

### Methods

| Method | Behaviour |
|---|---|
| `defaultConfiguration()` | `['form_mode' => 'default', 'display_label' => 'Edit profile'] + parent`. |
| `buildConfigurationForm()` | Adds a `form_mode` select from `getFormModeOptions('profile')`; rewrites the `display_label` description. |
| `submitConfigurationForm()` | Saves `form_mode` from the submitted values (only if no form errors). |
| `buildConfigurationSummary()` | `"Form mode: <mode><br>" . parent`. |
| `getDisplayLabel()` | Returns `configuration['display_label']`. |
| `isVisible()` | Access gate — see below. |
| `buildPaneForm()` | Builds the inline profile form — see below. |
| `getProfileTypeId()` (protected) | `return $this->getDerivativeId();` — the profile **type** machine name. |
| `calculateDependencies()` | Config dep `core.entity_form_mode.profile.<form_mode>`. |

### `isVisible()` — access gate (`ProfileForm.php:161`)

```php
$profile = $this->entityTypeManager->getStorage('profile')
  ->loadByUser($this->currentUser, $profile_type_id);   // scoped to current_user
if (empty($profile)) {
  return $this->entityTypeManager->getAccessControlHandler('profile')
    ->createAccess($profile_type_id);                    // may they create one?
}
return $profile->access('update');                       // may they edit theirs?
```

The pane is hidden unless the current user can create (no profile yet) or update (has one) their own
profile of this type. Access uses the Profile entity access control handler — this module adds no
permissions.

### `buildPaneForm()` — the profile form (`ProfileForm.php:190`)

```php
$profile = $profile_storage->loadByUser($this->currentUser, $profile_type_id);
if (empty($profile)) {
  $profile = $profile_storage->create([
    'type'     => $profile_type_id,
    'uid'      => $this->currentUser->id(),   // new profile owned by current_user
    'langcode' => $profile_type->language() ?: $this->languageManager->getDefaultLanguage()->getId(),
  ]);
}
$pane_form['profile'] = [
  '#type'          => 'inline_entity_form',
  '#entity_type'   => 'profile',
  '#bundle'        => $profile_type_id,
  '#form_mode'     => $this->configuration['form_mode'],
  '#default_value' => $profile,
];
// Wire the IEF submit onto the checkout "next" action button:
ElementSubmit::addCallback($complete_form['actions']['next'], $complete_form);
```

Notes for anyone subclassing/debugging:
- The profile is **always** the current session user's own profile (loaded by `loadByUser`, or newly
  created with `uid = current_user`). The derivative id is the profile *type*, not a profile id, so
  there is no way to target another user's profile through this pane.
- Saving relies on `inline_entity_form\ElementSubmit::addCallback(...)` on the flow's `next` action —
  a deliberate workaround because IEF's own `processEntityForm` submit callbacks were being lost by
  the time validation ran (see the in-code comment at `ProfileForm.php:230`).
- For profile types set to allow **multiple** profiles per user, `loadByUser` returns only the first;
  the pane offers no way to pick which one (see the `@todo` in the deriver).

### Dead code

`ProfileForm::processEntityForm()` and the class
`Drupal\commerce_profile_pane\CheckoutPaneElementSubmit` (extends
`inline_entity_form\ElementSubmit`) are both marked **NOT CURRENTLY IN USE** — the process-callback
approach is commented out in `buildPaneForm()`. Don't rely on them.

## Deriver — `ProfileFormCheckoutPaneDeriver`

`Drupal\commerce_profile_pane\Plugin\Derivative\ProfileFormCheckoutPaneDeriver` (extends
`DeriverBase`, implements `ContainerDeriverInterface`; dep `entity_type.bundle.info`). For each
`profile` bundle it emits one derivative keyed by the bundle id, **skipping `customer`**:

```php
foreach ($this->entityTypeBundleInfo->getBundleInfo('profile') as $bundle => $info) {
  if ($bundle == 'customer') { continue; }        // handled by Commerce core panes
  $this->derivatives[$bundle] = [
    'label' => $this->t('@profile-type profile form', ['@profile-type' => $info['label']]),
  ] + $base_plugin_definition;
}
```

Resulting pane ids are `profile_form:<bundle>`.

## Hooks — `commerce_profile_pane.module`

Legacy procedural hooks that keep the derived panes fresh:

```php
function commerce_profile_pane_profile_type_insert(EntityInterface $entity) {
  \Drupal::service('plugin.manager.commerce_checkout_pane')->clearCachedDefinitions();
}
function commerce_profile_pane_profile_type_delete(EntityInterface $entity) {
  \Drupal::service('plugin.manager.commerce_checkout_pane')->clearCachedDefinitions();
}
```

`hook_ENTITY_TYPE_insert` / `hook_ENTITY_TYPE_delete` for the `profile_type` config entity — both
just flush the checkout-pane plugin definition cache so a new/removed profile type immediately
gains/loses its derived pane.
