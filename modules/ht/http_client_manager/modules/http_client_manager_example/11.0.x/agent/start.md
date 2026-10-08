# HTTP Client Manager - Example — agent index

Reference/demo submodule for HTTP Client Manager. Declares a JSONPlaceholder-backed API and
shows every calling style. Depends on `http_client_manager`. No config UI (`configure: null`).

- **The example API, its commands, the wrapper/client services and the shipped config requests** →
  [api/example.md](api/example.md)

Key facts:
- Service APIs: `example_services` (JSON desc) and `example_services_yaml` (YAML desc), both
  `base_uri: http://jsonplaceholder.typicode.com`. Declared in
  `http_client_manager_example.http_services_api.yml`.
- Commands (posts resource): `FindPosts`, `FindPost` (postId), `CreatePost` (title/body/userId), `FindComments`.
- Injectable client service: `example_api.http_client`. Typed wrapper: `HttpServiceApiWrapperPosts` (`api: posts`).
- Shipped `http_config_request` entities: `all_posts`, `find_post` (postId 1), `create_post` (token params).
- Demo routes: `/find-posts/{postId}`, `/find-posts-advanced/{postId}`, `/create-post`, `/create-post-advanced`.
