<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA workflow models

The recipe ships two ECA (Event-Condition-Action) models, each as a pair of config entities: an
`eca.model.<id>` (BPMN diagram data for the BPMN.iO modeller) and the executable `eca.eca.<id>`
(events/conditions/actions). View/edit them at `/admin/config/workflow/eca`. Requires `eca_base`,
`eca_form`, `eca_user` (all installed by the recipe).

## `auth_redirects` — Authentication redirects
File: `recipes/default/config/eca.eca.auth_redirects.yml` (dep: `eca_user`).
- **Event** `user:logout` (User logout) → **Action** `action_goto_action` with `url: /user/login`,
  `replace_tokens: false`. Sends a user back to the login form immediately after they log out.

## `user_register` — User registration
File: `recipes/default/config/eca.eca.user_register.yml` (deps: `eca_base`, `eca_form`).
Restyles and hardens the `user_register_form`. Two entry events:

**On `form:form_build` (build user register form)** — reorders fields and adds conditional states:
- `eca_form_field_set_weight` on `mail (-10)`, `name (-9)`, `notify (-8)`, `pass (-7)` — field order.
- `eca_form_field_require` — makes `pass` not required.
- `eca_form_field_default_value` — sets `notify` (email new user their account details) checked by default.
- `eca_form_field_add_state` (×2) — hides `status` and `pass` (invisible state) when `notify` is checked
  (selector `:input[name="notify"]`).

**On `form:form_validate` (validate user register form)** — condition `eca_form_field_value`
`notify == 1` (numeric). When an admin creates the account with "notify" on:
- `eca_token_set_random_value` (mode `password`) → token `[password]` (note: the executable YAML sets
  `length: true`; the BPMN diagram data records length `32`).
- `eca_form_field_set_value` → `pass = [password]` (a generated random password).
- `eca_form_field_set_value` → `status = 1` (account created active).

Net effect: when a site admin registers a user and chooses to email them, the module assigns a random
password and an active status without exposing the password field on screen.
