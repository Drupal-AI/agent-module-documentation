<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core demo (crm_core_demo) — agent index

Configuration-only helper for the CRM Core suite. **No PHP** (only `crm_core_demo.info.yml` and
`config/install/*`), no routes, services, permissions or schema. Core `^9 || ^10 || ^11`,
GPL-2.0-or-later. Depends on `crm_core_contact` and `crm_core_activity`.

## What it installs

On enable it imports these default config entities from `config/install/`:

- `crm_core_contact.type.customer` — a **Customer** individual type.
- `crm_core_contact.organization_type.supplier` — a **Supplier** organization type.
- `crm_core_contact.organization_type.household` — a **Household** organization type.
- `crm_core_activity.type.meeting` — a **Meeting** activity type.
- `crm_core_activity.type.phone_call` — a **Phone call** activity type.

These are plain bundle-type config entities validated by the `crm_core_contact` /
`crm_core_activity` schemas (see those submodules' docs). Because it is config-only, disabling the
module leaves already-created content and any edited types in place; it only seeds initial
configuration at install time.

## Use

Enable for demo/evaluation/test sites to get sample CRM structure instantly. On production, define
your own contact/activity types and leave this module off.
