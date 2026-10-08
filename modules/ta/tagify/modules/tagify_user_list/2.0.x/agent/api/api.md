# Services & hooks

## Services (`tagify_user_list.services.yml`)
- `tagify_user_list.user_image` — `UserImageResolver` (interface
  `UserImageResolverInterface`): resolves the avatar image field/style and default image
  for a user.
- `tagify_user_list.autocomplete_matcher` — `TagifyUserListEntityAutocompleteMatcher`,
  declared with `parent: tagify.autocomplete_matcher`; the parent matcher is extended and
  injected with the user-image resolver via `setUserImageResolver()`.

## Autocomplete route
`tagify_user_list.entity_autocomplete` at
`/tagify_user_list_autocomplete/{target_type}/{selection_handler}/{selection_settings_key}`.
Access is open but the `selection_settings_key` is a signed hash validated in the
controller, mirroring core's entity-reference autocomplete route.

## Hook (`tagify_user_list.api.php`)
```php
function hook_tagify_user_list_autocomplete_matches_alter(array &$matches, array $options): void {
  // Add/remove/reorder matched users before they are returned.
}
```
