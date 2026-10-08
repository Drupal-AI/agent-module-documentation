<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group JSON:API Create Access makes it possible to create `group_relationship` entities over JSON:API by supplying the group context that Group's create-access logic requires.
---
The Group module's `create` access check needs `$context['group']`, which is not present on JSON:API POST requests, so creating group content via JSON:API/REST/GraphQL normally fails (drupal.org issue #2872645). This module's `RouteSubscriber` runs on `RoutingEvents::ALTER`, finds JSON:API POST routes whose resource type starts with `group_relationship--` and that carry an `_entity_create_access` requirement of the form `group_relationship:<bundle>`, and swaps that requirement for its own `_group_jsonapi_create_access` check.

The custom access checker (`GroupJsonapiCreateAccessCheck`) only acts on `api_json` requests: it decodes the request body, reads the group UUID from `data.relationships.gid.data.id`, loads the matching group, and — crucially — then defers to the real `getAccessControlHandler('group_relationship')->createAccess($bundle, $account, ['group' => $group], TRUE)`. If no valid group can be resolved from the body it returns `AccessResult::forbidden()`. It does **not** grant access on its own; it merely reconstructs the context so Group's own permission check can run correctly, so it does not over-grant. JSON decode failures are caught and treated as "no group" (denied). Requires `group` and `jsonapi`.

Typical setup: install the module; no configuration is needed. JSON:API clients then POST group_relationship entities with a `gid` relationship referencing the target group.
---
- Create group memberships via JSON:API POST requests.
- Add nodes/content to a group over JSON:API.
- Fix "create impossible via JSON:API" errors from the Group module.
- Enable decoupled/headless clients to add group relationships.
- Pass group context from the request body's `gid` relationship.
- Preserve Group's own create-access permission checks (no bypass).
- Deny requests whose body lacks a resolvable group.
- Support GraphQL/REST create flows blocked by missing context.
- Integrate a JS front-end that manages group content.
- Avoid custom access-check code for group_relationship POSTs.
- Load the target group by UUID before checking access.
- Only alter JSON:API `group_relationship--*` POST routes.
- Keep non-JSON:API group flows unchanged.
- Return a clear forbidden message when the group is missing/malformed.
- Let mobile apps create group relationships through the API.
- Handle malformed JSON bodies safely (treated as denied).
- Work with any group_relationship bundle (plugin id derived from requirement).
- Complement standard Group permissions without weakening them.
- Resolve issue #2872645 on a decoupled Group site.
- Test create-access behavior with the bundled functional test.
