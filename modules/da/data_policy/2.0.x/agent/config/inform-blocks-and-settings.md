<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: inform blocks, settings, and setup order

## Settings — `data_policy.data_policy` config

Edited at `/admin/config/people/data-policy/settings` (`DataPolicySettingsForm`, permission
`administer data policy settings`). Stored keys:

- `consent_text` — the token-driven checkbox text (`[id:N]` / `[id:N*]`; see the consent-flow doc).
- `enforce_consent` — boolean; when true, refusing a required policy routes the user to account
  cancellation. Default `false`.
- `entity_id` — legacy single-entity pointer, reset to `0` when a `data_policy` entity is deleted
  (`data_policy_data_policy_delete()`).
- `revision_ids` — tracks which revisions have been active (used to forbid editing an
  already-active revision).

Config schema is in `config/schema/data_policy.schema.yml` (covers the `informblock` config
entity). Default install config lives in `config/install/`, including the
`data_policy_agreements` view and the initial `data_policy.data_policy` values
(`consent_text: 'I read and consent to the [id:1]'`, `enforce_consent: false`).

## Inform blocks — explanatory pop-ups per page

`informblock` config entities are managed at `/admin/config/system/inform-consent`
(`entity.informblock.collection`; this is also the module's `configure` route). Each block has a
`page` path it applies to, a `summary` shown inline, and a `body` shown in a modal. The
`DataPolicyInformBlock` block plugin renders the summary in whatever region you place it; the modal
body is served from `/inform-consent/{informblock}`. These texts are admin-authored help content
and are publicly viewable by design.

Relevant permissions: `administer inform and consent settings`,
`overview inform and consent settings` (collection access), `edit inform and consent setting`,
`change inform and consent setting status`.

## Recommended setup order (from README.txt)

1. Place the **Data Policy Inform block** in a region at `/admin/structure/block`.
2. Add inform pages at `/admin/config/system/inform-consent`.
3. Create a **data policy entity** (and revisions) at `/admin/config/people/data-policy`. A policy
   cannot be made inactive — publish a new revision to change an active one.
4. At `/admin/config/people/data-policy/settings`, set the consent text (using `[id:N]` tokens; the
   entity id is shown in the *Data policy ID* column of the collection page) and choose whether to
   enforce consent.
5. Review agreements at `/admin/reports/data-policy-agreements`.

## Uninstall note

`DataPolicyModuleInstaller::uninstall()` deletes the referenced `data_policy` entity on uninstall.
**But** see the WARNING in `start.md`: because `DataPolicyServiceProvider` makes `module_installer`
a circular service, uninstall via `drush`/UI is not actually reachable while the module is enabled;
`core.extension` must be edited by hand to disable it.
