<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities: `data_policy`, `user_consent`, `informblock`

## `data_policy` — the policy statement (revisionable content entity)

`src/Entity/DataPolicy.php`. Extends `RevisionableContentEntityBase`, translatable.

- `admin_permission = "administer data policy entities"`.
- Access handler `DataPolicyAccessControlHandler`: `update` requires `edit data policy`; all other
  operations fall back to the admin permission.
- Tables: `data_policy` / `data_policy_field_data` / `data_policy_revision` /
  `data_policy_field_revision`.
- Label field is `name`. The actual policy text is **not** a base field — it is the configurable
  `field_description` field (`config/install/field.storage.data_policy.field_description.yml`,
  type `text_long`, translatable), rendered through its text format on `/data-policy` and revision
  pages. Because it is a `text_long` field it is filtered by the assigned text format on output.
- `preCreate` stamps `user_id` = current user; `preSave` defaults the owner to anonymous and the
  revision author to the entity owner if unset.
- Rich revision surface (route provider `DataPolicyHtmlRouteProvider`): canonical, collection,
  edit, delete, version-history, revision view/edit/revert/delete, translation-revert. Revision
  operations are gated by `revert all data policy revisions` / `delete all data policy revisions`
  (or the admin permission). A revision that has ever been *active* cannot be edited
  (`DataPolicy::revisionEditAccess()` checks `revision_ids` config).
- A policy **cannot be made inactive** — to change an active statement you publish a **new
  revision**, which re-triggers consent for everyone (see the consent flow doc).

## `user_consent` — the agreement record (content entity)

`src/Entity/UserConsent.php`. Extends `ContentEntityBase`.

- `admin_permission = "overview user consents"`.
- Table `user_consent`. Only a **collection** route exists
  (`/admin/reports/user-consents`, via `UserConsentHtmlRouteProvider extends AdminHtmlRouteProvider`),
  gated by `overview user consents`. There is **no per-entity canonical/edit route**, so there is
  no uid- or id-parameterised route through which one user could read another's consent record.
- Base fields: `user_id` (owner ref), `data_policy_revision_id` (integer, unlimited cardinality,
  read-only — points at the `vid` of the agreed revision), `state` (integer, read-only),
  `status` (boolean, the "active" flag), `created`, `changed`.
- `state` constants (`UserConsentInterface`): `STATE_UNDECIDED = 0`, `STATE_NOT_AGREE = 1`,
  `STATE_AGREE = 2`.
- Consent is **append-only in spirit**: on a new decision the manager sets `status = FALSE` on the
  prior records and creates fresh ones, so history is retained (`DataPolicyConsentManager::saveConsent`).
- `label()` returns the owner's display name.

## `informblock` — inform pop-up text (config entity)

`src/Entity/InformBlock.php`. `@ConfigEntityType`, `config_prefix = "informblock"`,
`admin_permission = "administer inform and consent settings"`.

- Exported keys: `id`, `label`, `page`, `status`, `summary` (value+format), `body` (value+format).
- Access handler `DataPolicyInformAccessControlHandler`: `update` allowed with
  `administer inform and consent settings` **or** `edit inform and consent setting`.
- Rendered by the `DataPolicyInformBlock` block plugin (a summary shown in a region) plus a modal
  whose body comes from `/inform-consent/{informblock}`
  (`DataPolicyInformController::descriptionPage`, output as `#markup` → filtered by
  `Xss::filterAdmin`). These are admin-authored, publicly viewable help texts by design.

## Views integration

`data_policy_views_data_alter()` swaps in custom field/filter handlers for `user_consent`:
`UserConsentState` (state → readable label) and `UserConsentDataPolicyRevision`. The shipped
`data_policy_agreements` view (`/admin/reports/data-policy-agreements`) lists consent rows and is
where the export submodule attaches its bulk action.
