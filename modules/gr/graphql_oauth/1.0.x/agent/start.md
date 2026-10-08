<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL OAuth — agent index

Adds **OAuth directive support to GraphQL** (schema fields require an OAuth token with the necessary **scope**
→ scope-based authorization). Depends on `graphql`. Version **1.0.0-alpha4**. Core `^9||^10||^11`.

Web-services/authorization — the directive gates fields by OAuth scope. Apply directives to **all** fields
needing protection (unannotated = not scope-gated); ensure the underlying OAuth token validation is correct
(the check is only as good as that). Contributes to GraphQL access control.
