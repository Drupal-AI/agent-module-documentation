# Node Keep Service & Tokens — agent index

Adds a `keeper_machine_name` base field to nodes and exposes each protected, machine-named node as
`node-keep` tokens plus a service. Depends on `node_keep` and `token`. No config, no configure route.

- **The machine-name field and the `[node-keep:<name>:…]` token patterns** →
  [configure/tokens.md](configure/tokens.md)
- **The `node_keep_token.helper` service (`NodeKeepTokenService`) methods** →
  [api/service.md](api/service.md)

Key facts:
- Base field `keeper_machine_name` (string) on all nodes; only visible when `node_keeper` is checked;
  must be unique and match `[a-z0-9_]+`.
- Token type `node-keep`, tokens per machine name: `:alias`, `:id`, `:url`, `:uri`.
- Service id `node_keep_token.helper`; permission `administer node_keep_token per node` to change the name.
