<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Search API Query — agent index

Exposes **Search API queries via GraphQL data producers** (decoupled clients run full-text/filter/facet
searches). Depends on `graphql`, `search_api`. Version **1.2.2**. Core `^10||^11`.

Decoupled/search — results come from the **Search API index**: ensure the index/query **respect content
access** (don't surface unpublished/restricted content) and secure/scope the GraphQL endpoint. No access role
of its own.
