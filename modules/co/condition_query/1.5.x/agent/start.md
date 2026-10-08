# Condition Query — agent index

Adds one Condition API plugin, `request_param`, that evaluates URL query-string parameters — use
it wherever Drupal conditions apply (block visibility, Rules, Page Manager). No settings page, no
permissions, no dependencies beyond core.

- **Configure the "Request Param" condition (syntax, negate, evaluation, caching)** →
  [configure/usage.md](configure/usage.md)

Key facts:
- Plugin: `@Condition(id = "request_param", label = "Request Param")`,
  `src/Plugin/Condition/RequestParam.php`. Injects `request_stack`.
- Config: `request_param` (textarea, one `key=value` per line; arrays via `key[]=value`).
- Evaluate: lowercases config, `parse_str(preg_replace('/\n|\r\n?/','&', $params))`, matches
  each against the current request's query values; TRUE on any match. Empty config → TRUE.
- Standard **Negate** inverts the result. Declares cache context `url.query_args`.
- Provides no config schema of its own (config stored inside the host, e.g. the block).
