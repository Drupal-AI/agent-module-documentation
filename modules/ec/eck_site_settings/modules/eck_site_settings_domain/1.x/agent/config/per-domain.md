<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-domain settings scoping

How eck_site_settings_domain makes one settings bundle carry different values per domain. Cites
`eck_site_settings_domain.module`, `eck_site_settings_domain.services.yml`,
`src/EckBundleFormAlter.php`, `src/FieldInstaller.php`, and
`config/schema/eck_site_settings_domain.schema.yml`.

## Install / enable

`ddev drush en eck_site_settings_domain -y`. Requires the contrib **Domain** module (`domain:domain`)
and the parent **eck_site_settings**. Ships no install hook — the field is provisioned lazily when a
bundle opts in (below).

## Opt a bundle in

`EckBundleFormAlter::alterForm()` (service `eck_site_settings_domain.bundle_form_alter`, invoked from
`hook_form_alter` when the form object is an `EckEntityBundleInterface`) adds a **"Allow different
settings per domain"** checkbox to the ECK bundle form, defaulting to the bundle's third-party
setting `eck_site_settings_domain.enabled`. The entity builder `formBuilder()` stores the checkbox
into that third-party setting. Schema: `eck.eck_entity_type.*.third_party.eck_site_settings_domain`
→ `enabled: boolean`.

`_eck_site_settings_domain_is_enabled($entityTypeId, $bundle)` reads that setting off the bundle
entity (`getThirdPartySetting('eck_site_settings_domain', 'enabled', FALSE)`).

## Auto-installed field

On `hook_entity_insert` / `hook_entity_update` of an ECK **bundle** whose option is enabled, the
module resolves the bundle's target entity type (`getBundleOf()`) and calls `FieldInstaller`
(service `eck_site_settings_domain.field_installer`):
- `installFieldStorage($entityTypeId)` — creates `field_storage_config`
  `<entityType>.field_domain_access`, type `entity_reference`, `target_type: domain`, cardinality 1
  (skips if it exists).
- `installField($entityTypeId, $bundle)` — creates `field_config`
  `<entityType>.<bundle>.field_domain_access`, **required**, label "Domain Access", handler
  `default:domain` (skips if it exists).

So enabling the option and saving the bundle materialises a required domain-reference field on that
bundle.

## Per-domain load & create (alter hooks)

The parent repository (`SettingsRepository::getSetting()`) runs two alter hooks; this submodule
implements both:
- `hook_eck_site_setting_context_alter(&$context)` — if `domain_id` is absent, sets it from
  `domain.negotiator`'s active domain id (`getActiveDomain()->id()`).
- `hook_eck_site_setting_values_alter(&$values, $context)` — if `context['domain_id']` is set **and**
  the bundle is domain-enabled, sets `values['field_domain_access'] = context['domain_id']`.

Because `getSetting()` builds its storage query from those `values`, each domain resolves to (and, on
first access, creates) its own settings entity carrying that domain in `field_domain_access`. To
force a specific domain, set/alter `context['domain_id']` before the default is applied (e.g. from
another module's `hook_eck_site_setting_context_alter`).

## Operate it

1. Enable this submodule (and Domain) and tick "Allow different settings per domain" on the target
   bundle; save the bundle so `field_domain_access` installs.
2. Edit the settings singleton from `/admin/content/site-settings` while browsing each domain — each
   domain's active-domain context yields its own variant.
3. Reads via `site_settings('<bundle>')` (Twig), the repository service, or tokens automatically pick
   the active domain's variant.

Scope note: this provides per-domain **data separation**; edit access is still the parent's ECK
`edit any <type> entities` permission, which is site-wide (see the parent's config/settings.md).
