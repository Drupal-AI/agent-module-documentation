# profile — programmatic API

## Load profiles (profile storage)
The `profile` entity storage (`ProfileStorageInterface`) adds helpers:
```php
$storage = \Drupal::entityTypeManager()->getStorage('profile');
$storage->loadByUser($account, 'address');                 // one (the active/default)
$storage->loadDefaultByUser($account, 'address');          // the default profile
$storage->loadMultipleByUser($account, 'address', TRUE);   // all published (or FALSE for all)
```

## Create / save
```php
$profile = $storage->create([
  'type' => 'address',
  'uid' => $account->id(),
  'field_city' => 'Berlin',
]);
$profile->setDefault(TRUE)->setActive(TRUE)->save();
```

## `ProfileInterface` conveniences
- `isActive()/setActive()`, `isDefault()/setDefault()`.
- `getData($key, $default)/setData($key,$value)/unsetData($key)` — arbitrary stored data.
- `equalToProfile($other, $field_names)` — compare selected field values.
- `populateFromProfile($other, $field_names)` — copy field values from another profile.
- `getRevisionAuthor()/setRevisionAuthorId()`, `getCreatedTime()/setCreatedTime()`.

## `profile.user_syncer` service (`ProfileUserSyncer`)
Keeps single-profile field data in sync with the user account during registration/edit:
- `addPreparedProfile(UserInterface $user, ProfileInterface $profile)` — stage a profile on a user.
- `flushPreparedProfiles(UserInterface $user): array` — return and clear staged profiles.
- `saveProfile(UserInterface $user, ProfileInterface $profile)` — persist a profile for a user.

## Other integrations
- EntityReferenceSelection handler `ProfileSelection` — reference profiles from a field.
- Field widget `profile_form` — embed a profile edit form in another entity form.
- Views: `profile` relationship, `CurrentUserProfile` / `ProfileOwner` argument defaults.
- Search API processor for indexing profile data; migrate source plugins for D6/D7 import.
