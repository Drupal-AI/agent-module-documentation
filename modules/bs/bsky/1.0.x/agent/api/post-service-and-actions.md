<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `bsky.post_service` and the ECA action plugins

## The service

`Drupal\bsky\PostService` (service id **`bsky.post_service`**, `bsky.services.yml`,
args `@config.factory`, `@key.repository`) implements `Drupal\bsky\PostServiceInterface`. It wraps
two library objects built in the constructor: `potibm\Bluesky\BlueskyApi` and
`potibm\Bluesky\BlueskyPostService`. See [../config/settings.md](../config/settings.md) for how
credentials are loaded and the `isConfigured` guard.

Methods (all operate on `potibm\Bluesky\Feed\Post`):

| method | delegates to | purpose |
|--------|--------------|---------|
| `createPost(string $message): Post` | `Post::create()` | new post from text; throws `InvalidPluginDefinitionException` if not configured. |
| `addImage(Post, string $path, string $alt_text): Post` | `BlueskyPostService::addImage()` | attach an image (path usually `public://…`) with alt text. |
| `addCard(Post, url, title, description, imagePath = NULL): Post` | `addWebsiteCard()` | attach a website card. *(no ECA action exposes this yet.)* |
| `addFacets(Post): Post` | `addFacetsFromMentionsAndLinksAndTags()` | turn @-handles, hashtags, URLs into rich links. |
| `sendPost(Post): RecordResponse` | `BlueskyApi::createRecord()` | publish the post; returns the AT Protocol record response. |

The library sends its HTTP over a PSR-18 client discovered via `php-http/discovery` (the
`php-http/guzzle7-adapter` dependency provides Guzzle 7), so standard TLS verification applies.

## The four ECA actions (`src/Plugin/Action/`)

All extend `Drupal\eca\Plugin\Action\ConfigurableActionBase`, inject `bsky.post_service` in
`create()`, and pass data between steps through **ECA tokens** (`$this->tokenService`). A `Post`
object is moved between actions by `serialize()`/`unserialize()` into a named token.

1. **`bsky_create_post` — `CreatePost`**
   Config: `message` (required), `token_name` (required, `#eca_token_reference`).
   `execute()`: `message = token->getOrReplace($message)` (token substitution), then
   `postService->createPost($message)`, then `token->addTokenData($token_name, serialize($post))`.
   The response-token description documents sub-tokens `:body`, `:json`, `:headers`, `:status`,
   `:client_error`.

2. **`bsky_add_facets` — `AddFacets`**
   Config: `post` (required, the token name holding a serialized `Post`).
   `execute()`: unserialize the `Post` from that token, `postService->addFacets($post)`, re-serialize
   back into the **same** token.

3. **`bsky_add_image` — `AddImage`**
   Config: `post`, `image`, `alt_text` (all required).
   `execute()`: unserialize `Post`; `image` and `alt_text` run through `token->getOrReplace()`;
   `postService->addImage($post, $image, $alt_text)`; re-serialize into the `post` token.
   Note (from project docs): 1MB image cap; prefer a `:path`/`:uri` token, fall back to `:url` when
   an image-style derivative may not be generated yet.

4. **`bsky_send_post` — `SendPost`**
   Config: `post` (required), `token_name` (required).
   `execute()`: unserialize `Post` from the `post` token, `postService->sendPost($post)`, then
   `token->addTokenData($token_name, (array) $response)` so the `RecordResponse` fields are readable
   downstream.

## Typical ECA model order

`Create Post` → (optional) `Add Facets` → (optional) `Add Image` → `Send Post`. Each step reads and
writes the shared `post` token; `Send Post` is the only step that performs an authenticated call to
BlueSky. Without a configured handle + Key, `Create Post` throws and the model fails early.
