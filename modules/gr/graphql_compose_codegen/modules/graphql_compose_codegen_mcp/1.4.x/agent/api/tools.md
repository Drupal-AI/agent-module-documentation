<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tool API tools

Three read-only tools in `src/Plugin/tool/Tool/`, all extending `SchemaToolBase`
(`\Drupal\graphql_compose_codegen_mcp\Plugin\tool\Tool\SchemaToolBase`, a `McpGovernedToolBase`
implementing `ConfigScopeToolInterface`). Each is declared `#[Tool(operation: ToolOperation::Read)]` and
delegates to the parent `SchemaPreview::run(OPERATION, bundles, skip_fields)` — a bounded, read-only facade
that writes nothing.

| Tool ID | Class | `OPERATION` | Returns |
|---|---|---|---|
| `graphql_compose_codegen_inspect` | `SchemaInspectTool` | `inspect` | `nodes` (per-bundle graphql_type / typescript_type / fields) + `paragraphs` alias map |
| `graphql_compose_codegen_diff` | `SchemaDiffTool` | `diff` | `has_snapshot` + `changes` (added/changed/removed) |
| `graphql_compose_codegen_preview` | `SchemaPreviewTool` | `preview` | `artefacts` (relative path → scaffold content) |

## Inputs
Both are `InputDefinition` `string`, `multiple: TRUE`, optional, default `[]`:
- `bundles` — up to 64 bundle IDs; empty selects all enabled bundles.
- `skip_fields` — up to 256 field IDs to omit.

`doExecute()` rejects any key other than `bundles` / `skip_fields`. `SchemaPreview` further validates each
selector against `^[a-z][a-z0-9_]{0,63}$`, rejects duplicates/oversized/unknown-or-disabled bundles, and
throws (never truncates) when the schema or JSON result exceeds `MAX_BUNDLES=64`,
`MAX_FIELDS_PER_BUNDLE=256`, or `MAX_RESPONSE_BYTES=262144`.

## Access model (`SchemaToolBase::checkGovernedAccess`)
Requires **all** of:
- permission `administer graphql_compose_codegen`;
- an MCP Sentinel governance profile that resolves and `allowsConfigRead()`;
- the OAuth scope `mcp_config_read` (registered in the site's MCP Tool API bridge);
- no policy denial of the schema config dependency families `graphql_compose*`, `field.field.*`,
  `field.storage.*`, `node.type.*`, `paragraphs.paragraphs_type.*` — a partial view is refused, not redacted.

`checkGovernedDiscoveryAccess()` evaluates the same policy without fabricated inputs. `doExecute()` re-checks
access for direct PHP callers, resolves the profile, enforces the Sentinel rate limit, and refuses responses
over the profile's size cap via `McpExfiltrationGuard`. Anonymous execution is refused. Failures log only the
exception class/file/line — never schema values, mapper messages, or filesystem paths.

Enabling the module grants no permissions and publishes no unauthenticated tools; registration with
authentication + `mcp_config_read` is site configuration.
