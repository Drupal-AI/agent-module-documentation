<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add-rules API endpoint

## Route
`tailwindcss_utility.add_rules_api` → `POST`/request to `/tailwindcss-utility/add-rules-api`, controller `AddRulesApi::addRules`.

## Access
Requires permission **`access tailwindcss_utility endpoint`** (distinct from the admin permission). The permission's description explicitly warns: *"Allows adding css rules to database using an API endpoint. Give to trusted site editors only as this can be exploited."*

## Behaviour
Accepts rule data and writes CSS class rules into the active `RuleStorage` backend, which are then compiled and served by the Tailwind middleware.

## Security guidance
Treat this as a privileged write surface: it mutates what CSS the site generates and serves. Grant the endpoint permission only to trusted roles, and never to anonymous/authenticated-by-default users. It is not `_access: 'TRUE'` — access is permission-gated — but the permission is the whole protection, so assign it deliberately.
