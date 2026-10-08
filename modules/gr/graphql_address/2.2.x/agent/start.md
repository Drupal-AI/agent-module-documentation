<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Address — agent index

Exposes the **Address module's data as a GraphQL schema** (country/admin-area/locality/postal-code) for
decoupled front-ends. Depends on `graphql`, `address`. Version **2.2.1**. Core `^10||^11`.

Decoupled/integration — **exposes data over the API** (GraphQL schema/endpoint governs access): expose only
where intended, configure endpoint access. No access role of its own.
