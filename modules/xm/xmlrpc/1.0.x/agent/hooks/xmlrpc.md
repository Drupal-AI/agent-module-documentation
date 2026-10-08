# XML-RPC server: endpoint + hooks

## The endpoint

- Route `xmlrpc` → path `/xmlrpc`, controller `XmlrpcController::php()`.
- `requirements: _access: 'TRUE'` — **unauthenticated and open to the world by design**. POST only
  (a GET/empty body throws `BadRequestHttpException`). XML-RPC is expected to do any auth *inside*
  the individual methods.
- The controller calls `moduleHandler()->invokeAll('xmlrpc')` to collect method definitions, then
  `xmlrpc_server()` dispatches the incoming `methodCall`.

Built-in methods always available (from `xmlrpc.server.inc`), even with no contrib methods:
`system.multicall`, `system.methodSignature`, `system.getCapabilities`, `system.listMethods`,
`system.methodHelp`. Recursive `system.multicall` inside a multicall is rejected.

## `hook_xmlrpc()` — register server methods

Return an array mapping XML-RPC method names to Drupal callbacks. Two accepted shapes (mixable):

```php
function mymodule_xmlrpc() {
  return [
    // Short form: 'method.name' => callback.
    'drupal.login' => 'mymodule_login',

    // Long form: [name, callback, signature, help].
    [
      'drupal.site.ping',
      'mymodule_directory_ping',
      // signature: first element = return type, rest = required param types.
      ['boolean', 'string', 'string'],
      t('Handle a ping request.'),
    ],
  ];
}
```

- **Signature** (optional) is `[return_type, param_type, ...]`. If present, the server validates the
  argument count and each argument's type (`int`/`i4`, `string`/`base64`, `boolean`, `double`/`float`,
  `date`/`dateTime.iso8601`) before calling, returning `-32602` on mismatch. Omit it (`'undef'`) to
  skip type checking.
- The callback receives the decoded parameters and returns any PHP value (encoded back automatically),
  or an `xmlrpc_error($code, $message)` object to signal a fault.
- Built-in `system.*` methods are overridable by registering the same name.

## `hook_xmlrpc_alter(array &$methods)`

Runs right before dispatch; add, remove, or rewrite method definitions. Because both the short and
long definition forms coexist in `$methods`, branch on `is_int($key)`:

```php
function mymodule_xmlrpc_alter(array &$methods) {
  $methods['drupal.login'] = 'mymodule_alt_login';          // short form
  foreach ($methods as $key => &$method) {
    if (is_int($key) && $method[0] === 'drupal.site.ping') { // long form
      $method[1] = 'mymodule_other_ping';
    }
  }
}
```

## Security posture (checked while documenting — no separate finding)

- **No XXE.** Parsing uses expat (`xml_parser_create()` + `xml_parse()` in `xmlrpc_message_parse()`),
  a SAX parser that does not load external DTDs/entities and registers no external-entity handler.
  There is no `DOMDocument`/`simplexml`/`LIBXML_NOENT` path.
- **No arbitrary-callback execution.** `xmlrpc_server_call()` looks the requested `methodName` up in
  the registered `$callbacks` map and only `call_user_func_array()`s a callback that was explicitly
  registered — a client cannot name an arbitrary PHP function.
- **No shipped SSRF.** The outbound HTTP client (`_xmlrpc()`) is not reachable from the endpoint; the
  base module registers no pingback/fetch method. SSRF/state-change risk only exists if a *contrib*
  `hook_xmlrpc()` method makes outbound requests or mutates state — such methods must do their own
  access control, since the endpoint itself is anonymous.
