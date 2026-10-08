<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL OAuth enables OAuth directive support on GraphQL.

---

GraphQL OAuth adds OAuth **directive** support to the GraphQL module — so GraphQL schema fields/types can
be annotated with an OAuth directive that requires the request to present an OAuth token with the necessary
scope, enforcing scope-based authorization on the GraphQL API. It depends on the GraphQL module.

Use it to protect GraphQL fields with OAuth scopes. It is a web-services/authorization feature: the directive
gates access to schema fields by OAuth scope. When adopting, ensure the directives are applied to **all**
fields that need protection (an unannotated field isn't scope-gated) and that the underlying OAuth
provider/token validation is correctly configured — the scope check is only as good as the token validation
behind it. It contributes to access control on the GraphQL API. Configure the directives and OAuth scopes.

---

- Add OAuth directives to GraphQL.
- Require OAuth scopes on schema fields.
- Enforce scope-based authorization.
- Depend on the GraphQL module.
- Annotate fields with the directive.
- Gate GraphQL fields by scope.
- Apply directives to ALL fields needing protection.
- Ensure the OAuth token validation is correct.
- Know an unannotated field isn't scope-gated.
- Contribute to GraphQL access control.
- Configure the directives and scopes.
- Handle GraphQL OAuth.
- Protect GraphQL fields.
- Configure scopes.
- Enforce OAuth on GraphQL.
- Handle authorization.
- Configure the directive.
- Gate by scope.
- Secure the GraphQL API.
- Require scopes.
