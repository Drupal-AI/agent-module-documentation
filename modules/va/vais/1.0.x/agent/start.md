<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VAIS (Views AI Search) — agent index

A **block that provides AI-powered (natural-language) search over a Views page**. Depends on core `views`, `ai`.
Provides permissions. Version **1.0.0-alpha2**. Core `^10||^11`.

AI/search — queries/content **sent to the AI provider** (egress; key via AI/Key); results from the
access-respecting view (ensure the AI layer doesn't surface restricted content). No access role beyond
permission.
