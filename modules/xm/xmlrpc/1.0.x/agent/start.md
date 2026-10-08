# XML-RPC — agent index

Restores Drupal core's removed XML-RPC client and server. Procedural library in `xmlrpc.inc`;
server controller at route `xmlrpc` → path `/xmlrpc` (POST only, unauthenticated by design). No admin
UI (`configure` null), no permissions, no config schema, no Drush. Depends on nothing beyond core.
Bundled `xmlrpc_example` submodule shows client + server usage (not documented separately here).

- **Make outbound calls: `xmlrpc()`, multicall, value/date/base64 helpers, error handling** →
  [api/client.md](api/client.md)
- **Serve methods to clients: the `/xmlrpc` endpoint, `hook_xmlrpc()`, `hook_xmlrpc_alter()`, built-in
  `system.*` methods, and the security posture of the endpoint** → [hooks/xmlrpc.md](hooks/xmlrpc.md)

Key facts:
- Client entry point: `xmlrpc($url, ['method.name' => [$arg, ...]], $headers = [])`. More than one
  method in `$args` → automatic `system.multicall`. Returns the decoded value or `FALSE` on error.
- Server route `xmlrpc` uses `_access: 'TRUE'` — open to the world (by design; XML-RPC does its own
  auth inside methods). Out of the box only `system.*` introspection methods answer; application
  methods come only from modules implementing `hook_xmlrpc()`.
- Parsing uses the expat SAX parser (`xml_parser_create`/`xml_parse`) — no external-entity resolution
  (no XXE), and dispatch only reaches explicitly registered callbacks.
