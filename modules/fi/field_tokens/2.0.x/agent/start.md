# Field Tokens — agent index

Adds **formatted-field** and **field-property** tokens (plus an entity `delta` token) to the Token
system. No config UI (`configure` null), no permissions, no Drush, no schema. Depends on `token`
(PHP 8.2+). Works the moment it is enabled; use the Token browser to see the new tokens.

- **Full token grammar: formatted vs property tokens, delta specs, formatter settings & dot notation,
  the delta token, chaining, and the Custom Formatters integration** →
  [api/tokens.md](api/tokens.md)

Quick reference:
- Formatted: `[<entity>:<field>-formatted:DELTA(S):FORMATTER:KEY-VALUE:…]`
- Property:  `[<entity>:<field>-property:DELTA(S):PROPERTY:KEY:…]`
- Delta:     `[<entity>:delta]` (only when the caller supplies the position).
- `DELTA(S)` = `0` | `0,2,4` | `0-3` | `0-2,4,6-8` | `*` | omitted (all).
