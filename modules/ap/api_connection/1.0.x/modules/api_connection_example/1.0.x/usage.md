A hidden example submodule showing how to build a RestApiConnection plugin against the public ReqRes.in test API.

---

`api_connection_example` is reference code for the API Connection module. It declares one connection plugin, `ReqRes` (id `req_res`, in `src/Plugin/RestApiConnection/ReqRes.php`), extending `RestApiConnectionBase` with the same `dev`/`test`/`live` base URL (`https://reqres.in`), and adds two domain methods — `getUser($id)` (GET `api/users/{id}`) and `login($username, $password)` (POST `api/login`) — that both delegate to `sendRequest()`. A controller, `ReqResController`, instantiates the plugin via `plugin.manager.rest_api_connection` and exposes two routes that render the results. The submodule is marked `hidden: TRUE`, depends on `api_connection`, and exists to be read and copied, not run in production.

---

- Learn the minimal shape of a `RestApiConnection` plugin (attribute, id, label, per-environment `urls`).
- See how to add domain-specific methods (`getUser()`, `login()`) that wrap `sendRequest()`.
- See how a GET request maps to `sendRequest("api/users/{$id}", "GET")` and returns a decoded array.
- See how a POST with a body maps to `sendRequest('api/login', 'POST', [RequestOptions::BODY => [...]])`.
- See how to read a specific field out of the decoded response (`$response['token']`).
- Copy `ReqResController::create()` to learn how to obtain a plugin instance via `plugin.manager.rest_api_connection->createInstance('req_res')`.
- Visit `/api_connection_example/login` to run the example login flow against ReqRes.in and render a token.
- Visit `/api_connection_example/reqres/{id}` (default id 1) to fetch and render an example user's name.
- Use it as a smoke test that the framework, environment selection and logging are wired correctly.
- Study how remote response fields are rendered safely through `t()` placeholders in a render array.
- Enable it temporarily (`drush en api_connection_example`) while developing, then disable it before release.
- Use it as a scaffold: copy the plugin + controller into your own module and swap the URLs/methods.
- Understand how the `activated` flag and environment URL resolution behave with a real endpoint.
- Demonstrate the module to a team without wiring a real third-party API and credentials.
- Confirm request/response logging output in the Drupal logger when developing an integration.
