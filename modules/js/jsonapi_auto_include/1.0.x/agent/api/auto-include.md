<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the auto-include flag

Append `jsonapi_auto_include=1` to any JSON:API request:

```
GET /jsonapi/node/article?jsonapi_auto_include=1
GET /jsonapi/node/article/<uuid>?jsonapi_auto_include=1
```

Behaviour:
- The subscriber matches the resource type for the path, collects every `ResourceTypeRelationship` public field name, and sets `include` to the comma-joined list, recursing into related types up to **depth 3** (a visited-set prevents cycles).
- Fields marked disabled in a `jsonapi_extras.jsonapi_resource_config.<entity>--<bundle>` config, and the reserved `type`/`self`, are excluded.
- The JSON:API base path is derived from `jsonapi_extras.settings:path_prefix` (default `jsonapi`). Requests outside that prefix are ignored.

Access & performance:
- **Access is unchanged.** The module only mutates the query `include`; core JSON:API resolves and access-checks each included resource, so clients never receive related entities they aren't permitted to view.
- Full-graph includes to depth 3 can be large and query-heavy. Prefer explicit `include=a,b.c` lists in production and use the flag mainly for exploration/prototyping.
