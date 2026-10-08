# JSON:API Response Alter — agent index

A pure extension point: lets other modules modify the decoded JSON body of any JSON:API response
just before it is sent, via a hook or an event. No config, permissions, Drush, or default
behaviour. Depends on `jsonapi`.

- **`hook_jsonapi_response_alter()`, the `JsonApiResponseAlterEvent`, when they fire, ordering vs access filtering** →
  [hooks/alter.md](hooks/alter.md)

Key facts:
- `ResponseSubscriber` (`src/EventSubscriber/ResponseSubscriber.php`) listens to
  `KernelEvents::RESPONSE`; acts only when the route is a JSON:API route
  (`Routes::JSON_API_ROUTE_FLAG_KEY` / `Routes::isJsonApiRequest`).
- It `json_decode`s the response content to an array, calls `moduleHandler->alter('jsonapi_response',
  $data, $response)`, then dispatches `JsonApiResponseAlterEvent($data, $response)`, then
  `json_encode`s the result back. Non-array bodies are left untouched.
- Runs on the **already-serialized, already-access-filtered** JSON:API output — see the ordering
  caveat in the hook doc (you can re-add access-controlled data, so don't).
- Hook signature: `hook_jsonapi_response_alter(array &$jsonapi_response, \Symfony\...\Response $response)`
  (`jsonapi_response_alter.api.php`).
