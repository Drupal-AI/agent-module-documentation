# Configure profile types

Profile types are the `profile_type` config entity (bundles of the `profile` content entity).
Manage at `/admin/config/people/profiles/types` (route `entity.profile_type.collection`,
permission `administer profile types`). Each type is stored as `profile.type.<id>` config and
is exportable.

## Per-type options (`ProfileTypeInterface`)
- **`display_label`** (`getDisplayLabel`) — label shown to end users on tabs/pages.
- **`multiple`** (`allowsMultiple`) — allow more than one profile of this type per user
  (enables the `/user/{user}/{type}/list` and `/add` routes and a default selection).
- **`registration`** (`getRegistration`) — attach this type's fields to the user registration form.
- **`roles`** (`getRoles`) — restrict the type to specific roles; the access handler blocks it
  for users (even admins) without a listed role, regardless of permissions.
- **`revision` / show revision UI** (`allowsRevisions`, `showRevisionUi`) — keep revisions.

## Fields
Attach fields via the normal Field UI on the profile type (Manage fields / form display /
display), exactly like a content type. Field displays are theme-able (see theming doc).

## User-facing routes
- `/user/{user}/{profile_type}` — single profile view/edit.
- `/user/{user}/{profile_type}/list` and `/add` — multiple-profile listing and add form.
- `/profile/{profile}/set-default` — mark a profile as the user's default.

## Deploy as config
Export `profile.type.<id>.yml` (and the attached `field.*`) with `drush config:export`.
