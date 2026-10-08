<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ConfQ CFP — agent index

info.yml name: **ConfQ CFP** (`confq_cfp`), version **3.0.1**, `core_version_requirement: ^10.2 || ^11.0`.
Description: "Call for papers (CFP) for conference." Maintainer: Vladimir Roudakov (vladimiraus).
Part of the ConfQ conference toolset.

## What it is

A **configuration-only** module. It ships **no PHP** — no `.module`, no `.install`, no `src/`,
no routing/services/permissions YAML, no schema, no templates, no JS. It contributes exactly two
default config entities on install (under `config/install/`), both consumed by other modules:

1. **A Webform template** — `webform.webform.confq_cfp.yml` (id `confq_cfp`, title "Call for
   papers"). A ready-made call-for-papers form modeled on DrupalCon / DrupalSouth, provided by
   and rendered entirely by the **Webform** contrib module.
2. **A user role** — `user.role.confq_trackchair.yml` (id `confq_trackchair`, label "Track chair
   (confQ)"). Intended for proposal reviewers. It grants **no permissions** (`dependencies: {}`,
   no permission list) — it is an empty, named role only.

Dependencies (info.yml): core `user`, `webform:webform`. No configure route (`configure` is null);
there is no settings form of its own — you configure the CFP by editing the Webform in Webform's UI
and by assigning the role at People → Roles.

## The Webform template (`webform.webform.confq_cfp.yml`)

- `status: open`, `uid: 1`, `template: false`, `category: ''`.
- Page-served form (`settings.page: true`) at the webform's own path; `form_remote_addr: true`
  (stores the submitter IP with each submission).
- Elements (Webform render arrays, no custom code):
  - `cfp_description` — `webform_markup` intro text (static HTML).
  - `cfp_speaker_info` — `webform_custom_composite`, min 1 item: first/last name (required),
    email (required), Drupal.org profile, Twitter, organisation, "under-represented group"
    (yes/no radios), gender radios, short bio textarea.
  - `cfp_session_info` — `webform_custom_composite`: presentation title (required), summary
    textarea (required), track radios, length radios (Full 40 / Half 20 min), attendance-day radios.
- **Submission access** (`access.create.roles`): `anonymous` + `authenticated` — the form is
  **open to anonymous submission by design** (a public CFP). All other webform access grants
  (`view_any`, `update_any`, `delete_any`, `view_own`, `administer`, etc.) are **empty**, so
  reviewing/managing submissions falls back to core Webform permissions (e.g. "administer webform",
  "view any webform submission") — no access is widened by this module.
- No handlers (`handlers: {}`) — no email/remote-post handler ships enabled.

## Rendering & data notes (all delegated to Webform)

- The module contains no rendering code; submitted values are stored and displayed by the Webform
  module, which escapes submitted text on output. This module adds no custom `#markup`/Twig/query.
- The form collects sensitive personal fields (gender, under-represented-group) from anonymous users
  and stores IP (`form_remote_addr: true`) — a **privacy/consent** consideration for site operators,
  not a code behaviour of this module.

## Known cosmetic issues in shipped config (not bugs to rely on)

- Webform `description` has a typo: "evemts".
- `cfp_session_track` options list "Project Management" twice.
- The element track list differs from the README's "Track 1/2/3" example text — the markup is
  placeholder copy meant to be edited per event.

## Roadmap (README, NOT implemented in 3.0.1)

- Convert submissions to session nodes.
- Track-chair voting on proposals (public or locked). The `confq_trackchair` role exists to
  support this future feature but does nothing on its own yet.

## Working with it

- After enable, the form is at **Structure → Webforms** (`/admin/structure/webform`); edit fields,
  emails, open/close dates, and access there.
- Assign **Track chair (confQ)** at **People → Roles** to reviewers, then grant them the core
  Webform submission permissions you want.

See also: [../usage.md](../usage.md), [../human-docs/index.md](../human-docs/index.md).
