<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Vertex AI — agent index

Provides a **GraphQL endpoint for Google Vertex AI Search** (search/autocomplete). Depends on `graphql`, `key`.
Provides permissions. Version **1.2.0**. Core `^10.2||~11.0`.

AI/decoupled — service-account credential via the **Key** module (correct; used server-side, not client-exposed);
queries **sent to Vertex AI** (egress + cost): **gate the GraphQL query/endpoint**; settings admin-gated. No
access role beyond that.
