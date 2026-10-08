<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DruxtJS — agent index

A **bridge between Drupal (back) and Nuxt.js (front)** for decoupled sites (Nuxt consumes Drupal content/
routing via JSON:API). Depends on `decoupled_router`; provides permissions. Version **1.2.1**. Core
`^8.8||^9||^10||^11`.

Web-services/decoupled — exposed content governed by **JSON:API access control + your resource config**
(ensure no leak of unpublished/restricted content/fields). No access role of its own.
