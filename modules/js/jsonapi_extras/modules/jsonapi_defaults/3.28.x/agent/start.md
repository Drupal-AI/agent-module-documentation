# jsonapi_defaults — agent start

Submodule of `jsonapi_extras`. Sets per-resource default `include`, `filter`, `sort`, and
`page_limit`, applied to collection requests that omit those query params (client-supplied values
still win). Depends on `jsonapi_extras`. No settings form of its own — configured on each
resource override.

- Configure default includes/filters/sorting/page limit → [configure/defaults.md](configure/defaults.md)
