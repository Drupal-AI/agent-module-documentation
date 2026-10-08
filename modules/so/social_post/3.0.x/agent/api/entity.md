# The `social_post` content entity

`src/Entity/SocialPost.php` — a `@ContentEntityType` extending `social_api\Entity\SocialApi`.
One record represents one Drupal user's connection to one provider account, including the OAuth
token used to post.

| Annotation key | Value |
| --- | --- |
| `id` | `social_post` |
| `base_table` | `social_post` |
| `admin_permission` | `administer site configuration` |
| `list_cache_contexts` | `{ user }` |
| `access` handler | `Drupal\social_post\UserAccessControlHandler` |
| `list_builder` | `Drupal\social_post\Entity\Controller\SocialPostListBuilder` |
| `form.delete` | `Drupal\social_post\Form\SocialPostEntityDeleteForm` |
| `view_builder` | `Drupal\Core\Entity\EntityViewBuilder` |
| entity keys | `id`, `uuid`, `user_id`, `plugin_id`, `provider_user_id` |
| `delete-form` link | `/admin/config/social-api/social-post/users/social_post/{provider}/{social_post}/delete/{user}` |
| `collection` link | `/admin/config/social-api/social-post/{provider}/users/` |

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Meaning |
| --- | --- | --- |
| `id` | integer (read-only, unsigned) | Record id. |
| `uuid` | uuid (read-only) | Entity UUID. |
| `user_id` | entity_reference → `user` | The Drupal user the connection belongs to. |
| `plugin_id` | string | The implementer plugin id, e.g. `social_post_twitter`. |
| `provider_user_id` | string | Unique account id at the provider. |
| `name` | string | The user's name/screen name at the provider. |
| `token` | string_long | OAuth access token returned by the provider, used for autoposting. |
| `additional_data` | string_long | Optional serialized extra data. |
| `link` | link | URL to the user's profile at the provider. |

## Getters on `SocialPost`

`getId(): int`, `getProviderUserId(): string`, `getPluginId(): string`, `getName(): string`,
`getLink(): ?LinkItemInterface`. Token get/set (`setToken()`) is inherited from
`social_api\Entity\SocialApi`. Records are created and mutated programmatically through
`social_post.user_manager` (see [services.md](services.md)) during the OAuth callback, via
`SocialPost::create([...])->save()`.

## List builder — `SocialPostListBuilder`

`src/Entity/Controller/SocialPostListBuilder.php`. Built per provider via `setProvider($provider)`
(the base `ControllerBase::buildList($provider)` does this). Columns: **Social Network ID**
(`provider_user_id`), **Screen name** (`name`, linked when a `link` is set), **User ID** (link to
the Drupal user). It only emits rows whose `plugin_id == 'social_post_' . $provider`; other rows
render empty. The default **Delete** operation links to route
`entity.social_post.delete_form` with `provider`, `social_post` (record id) and `user => FALSE`.

## Delete form & route

- Route `entity.social_post.delete_form` — `_entity_form: 'social_post.delete'`, permission
  `delete own social post user accounts`; path carries `{provider}`, `{social_post}` and `{user}`
  (`{user}` defaults to `FALSE` and only affects the post-delete redirect target).
- Form `SocialPostEntityDeleteForm` extends core `ContentEntityDeleteForm`; `submitForm()` calls
  `$entity->delete()`. `getRedirectUrl()` / `getCancelUrl()` return the user edit form when a
  `{user}` id is present, otherwise `social_post_<provider>.user.collection`.
