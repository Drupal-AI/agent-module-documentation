<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The blueprint request/response format

A **blueprint** is a JSON array of subrequest objects sent to `POST /subrequests` (or, for
read-only batches, percent-encoded in a `GET /subrequests?query=...` query parameter). A
`Content-Type` header is required and selects the payload format (this doc covers
`application/json`, the common case).

## Subrequest object keys

```json
{
  "requestId": "req-1",
  "uri": "/node/1?_format=json",
  "action": "view",
  "headers": { "Accept": "application/json" },
  "body": "{\"title\":\"Example\"}",
  "waitFor": ["req-0"]
}
```

| Key | Required? | Meaning |
|---|---|---|
| `uri` | yes | path (+query string) to internally dispatch to |
| `action` | yes | maps to an HTTP method (see below); default is `GET` for any unrecognized value |
| `requestId` | recommended | correlates this subrequest to its slice of the combined response; auto-generated (UUID) if omitted |
| `headers` | no | object of header name → value, merged onto the internal request |
| `body` | no | serialized request body (JSON-encode it yourself, as a string) |
| `waitFor` | no | array of `requestId`s this subrequest depends on; defaults to `["<ROOT>"]` (no dependency) |

`action` → HTTP method mapping (`JsonSubrequestDenormalizer::getMethodFromAction`):
`view`→GET, `create`→POST, `update`→PATCH, `replace`→PUT, `delete`→DELETE, `exists`→HEAD,
`discover`→OPTIONS; anything else falls back to GET.

## Sequential vs. parallel execution

`BlueprintManager`/`JsonBlueprintDenormalizer` group the blueprint into **levels** (a
`SubrequestsTree`): every subrequest with no `waitFor` (or `waitFor` omitted) lands in level
0 and runs in parallel; each subsequent level holds subrequests whose `waitFor` IDs are all
now resolved, and levels execute strictly in order. A `waitFor` referencing an ID that can
never resolve throws a 400 ("Waiting for unresolvable request. Abort.").

## Response embedding (chaining) — the token syntax

A later subrequest can embed part of an earlier subrequest's JSON response body into its own
`uri` or `body` with a token of the form:

```
{{<requestId>.body@<jsonpath-expression>}}
```

Example: `{{req-1.body@$.rels.menu.id}}` pulls `rels.menu.id` out of `req-1`'s JSON response
body. `JsonPathReplacer` finds these with the pattern
`/\{\{([^\{\}]+\.[^\{\}]+)@([^\{\}]+)\}\}/`, matches the `<requestId>` prefix against
subjects' `Content-ID` headers (so `req-1#body{0}`-style clones from a prior fan-out still
match `req-1`), and replaces the token with the JSONPath result. If the JSONPath expression
resolves to **more than one value**, the subrequest is cloned once per value — one input
subrequest can produce N output subrequests/responses. Values used in a replacement must be
strings, ints, floats, or bools (an object/array match throws a 400). A dependant subrequest
using a token **must** also declare the referenced `requestId` in its `waitFor`, otherwise
the response it needs won't exist yet when the token is resolved.

## Response format

The endpoint always answers with **HTTP 207** (Multi-Status).

- **Default (`multipart/related`)**: one MIME part per subrequest response, each carrying its
  own `Content-Id: <requestId>`, `Status`, and body — `Content-Type:
  multipart/related; boundary="..."; type=application/json`.
- **JSON aggregate** — request it with `?_format=json` on the master request (or set the
  master request's `Accept`/format so `getRequestFormat()` returns `json`): a single JSON
  object keyed by each subrequest's `requestId`, each value `{ "headers": {...}, "body":
  "<serialized body string>" }`.

If subrequests in the batch return differing `Content-Type` headers, the combined response's
`X-Sub-Content-Type` falls back to `application/json`.
