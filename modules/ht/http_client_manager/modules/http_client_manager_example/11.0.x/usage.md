A worked example for HTTP Client Manager: it declares a JSONPlaceholder-backed API and demonstrates every way to call it (raw client, injected client service, typed API wrapper, and stored HTTP Config Requests).

---

The example submodule registers two service APIs against `http://jsonplaceholder.typicode.com` — `example_services` (JSON description `src/api/example_services.json`) and `example_services_yaml` (YAML description) — via its `http_client_manager_example.http_services_api.yml`. The Guzzle description defines a `posts` resource with the operations `FindPosts`, `FindPost` (by `postId`), `CreatePost` (title/body/userId) and `FindComments`. It wires an injectable client service `example_api.http_client` (extending `http_client_manager.client_base`), a typed API wrapper `HttpServiceApiWrapperPosts` (tagged `http_service_api_wrapper` with `api: posts`, methods `findPosts()`/`findPost()`/`createPost()`/`findComments()`), demo routes/controller (`/find-posts/{postId}`, `/find-posts-advanced/{postId}`, `/create-post`, `/create-post-advanced`), an event subscriber, and three ready-made `http_config_request` config entities: `all_posts` (FindPosts), `find_post` (FindPost, postId 1) and `create_post` (CreatePost, parameters filled with Drupal tokens). It is a learning/reference module, not something to run in production.

---

- See a complete, working `*.http_services_api.yml` + Guzzle description pair to copy for your own API.
- Learn the shape of a Guzzle operation (httpMethod, uri, parameter `location`, responseModel).
- Call `example_services` directly: `\Drupal::service('http_client_manager.factory')->get('example_services')->call('FindPost', ['postId' => 1])`.
- Use the injectable `example_api.http_client` service in your own controller/service.
- Study the typed API-wrapper pattern (`HttpServiceApiWrapperPosts`) for `findPosts()`/`findPost()`/`createPost()`.
- Inspect the shipped `find_post`, `all_posts`, `create_post` HTTP Config Requests as config templates.
- See tokens used in request parameters (e.g. `[current-user:uid]`) in the `create_post` request.
- Hit the demo pages `/find-posts`, `/find-posts/1`, `/create-post` to watch calls execute.
- Compare "basic" vs "advanced" controller usage (raw client vs API wrapper) side by side.
- Verify HTTP Client Manager is installed and working against a public test API.
- Use FindComments to see a query-location parameter (`postId` in the query string).
- Prototype your own integration by cloning this submodule and swapping the base URI + description.
- Demonstrate executing a saved request from code with `HttpConfigRequest::load('find_post')->execute()`.
- Reference the event subscriber to learn where to hook into the request lifecycle.
- Teach site builders what "service API", "command" and "config request" mean concretely.
- Confirm token replacement in API definitions works on your site.
