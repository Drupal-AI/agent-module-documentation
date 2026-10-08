# The example API

## Service APIs (`http_client_manager_example.http_services_api.yml`)

```yaml
example_services:
  title: "[JSON] - Example Services fake API"
  api_path: "src/api/example_services.json"
  config:
    base_uri: "http://jsonplaceholder.typicode.com"
example_services_yaml:
  title: "[YAML] - Example Services fake API"
  api_path: "src/api/example_services.yml"
  config:
    base_uri: "http://jsonplaceholder.typicode.com"
```

Both descriptions import the same `posts` resource (`src/api/resources/posts.{json,yml}`).

## Commands (operations)

| Command | Method | URI | Params |
|---|---|---|---|
| `FindPosts` | GET | `posts` | — (responseClass PostList) |
| `FindPost` | GET | `posts/{postId}` | `postId` (uri, int, required) |
| `CreatePost` | POST | `posts` | `title`, `body`, `userId` (all json, required) |
| `FindComments` | GET | `comments` | `postId` (query, int, optional) |

## Ways to call it

```php
// 1) raw factory
\Drupal::service('http_client_manager.factory')->get('example_services')->call('FindPost', ['postId' => 1]);
// 2) injectable client service
$container->get('example_api.http_client')->call('FindPosts');
// 3) typed API wrapper (methods findPosts/findPost/createPost/findComments)
$container->get('http_client_manager.api_wrapper.factory')->get('posts')->findPost(1);
// 4) a saved config request
\Drupal\http_client_manager\Entity\HttpConfigRequest::load('find_post')->execute();
```

## Shipped HTTP Config Requests (`config/install`)

- `all_posts` → example_services / `FindPosts`.
- `find_post` → example_services / `FindPost`, `parameters.postId: '1'`.
- `create_post` → example_services / `CreatePost`, parameters filled with Drupal tokens
  (`title: "[current-user:display-name]'s lucky numbers!"`, tokenised body, `userId: '[current-user:uid]'`).

Read one: `drush cget http_client_manager.http_config_request.find_post`.

## Wrapper & extras

- `HttpServiceApiWrapperPosts` (service `http_client_manager_example.api_wrapper.posts`, parent
  `http_client_manager.api_wrapper.base`, tag `http_service_api_wrapper` `api: posts`) — its
  `getHttpClient()` uses `example_services_yaml`; methods call the posts commands and `->toArray()`.
- Demo controller `ExampleController` behind `/find-posts`, `/create-post`, and their `-advanced`
  variants; plus an event subscriber. Requires `access content`.
