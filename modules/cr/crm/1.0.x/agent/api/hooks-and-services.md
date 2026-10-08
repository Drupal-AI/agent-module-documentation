<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM hooks, services & Drush

## Hooks CRM provides (`crm.api.php`)
- `hook_crm_contact_access_records(ContactInterface $contact): array` and
  `hook_crm_contact_access_records_alter(array &$records, ContactInterface $contact)` — return /
  alter per-contact grant rows written to `crm_contact_access` on save.
- `hook_crm_contact_grants(AccountInterface $account, string $operation): array` — return the
  `realm => gid[]` an account holds. (See the access doc for the full grant contract and
  `ContactAccessGrantStorageInterface::rebuild()`.)
- `hook_crm_user_field_access_info_alter()` — alter `crm_user_field_access` plugin definitions.

## Hook implementations (OO hooks, `src/Hook/*`)
CRM uses attribute-based hook classes registered as autowired services in `crm.services.yml`:
`ContactHooks`, `ContactMethodHooks`, `RelationshipHooks`, `NavigationHooks`, `UserHooks`,
`UserMappedFieldFormHooks`, `UserMappedFieldAccessHooks`, `UserMappedFieldEntityHooks`,
`NameHooks`, `AppearanceHooks`, `HelpHooks`, `CrmHooks`, `ContactAccessHooks`,
`ContactQueryAccessHooks`, plus (not service-tagged but present) `CommentHooks`, `SearchHooks`,
`ThemeHooks`, `InstallOptionalConfigHooks`. These wire entity save→grant writes, contact query
access, user field mirroring, navigation/appearance, help and comment/search integration.

## Services (`crm.services.yml`)
- `crm.relationship` (`RelationshipService`) — eligible relationship types for a contact, etc.
- `crm.relationship_statistics` (`RelationshipStatisticsService`,
  `RelationshipStatisticsInterface`) — computes per-type relationship counts; used by the
  `crm_relationship_statistics` field and the recalculate Drush command.
- `crm.contact_access_grant_storage` (`ContactAccessGrantStorage`) — the grant table API.
- `crm.user_contact_mapping`, `crm.user_field_mapping`, `crm.user_mapped_field`,
  `crm.user_contact_display_sync`, `crm.user_contact_field_values_storage` — the user-mapping
  subsystem (see config doc).
- `plugin.manager.crm_user_field_access` — the `crm_user_field_access` plugin manager.
- `crm.contact_route_context` (`ContextProvider/ContactRouteContext`) — a `crm_contact` context
  provider (e.g. for Layout Builder / blocks).
- `crm.comment_lazy_builders` (`CommentLazyBuilders`) — renders the contact comment form lazily.
- `theme.negotiator.admin_theme.crm` (`ThemeNegotiator`), `logger.channel.crm`.
- Event subscribers: `crm.user_create` (`UserContactMappingSubscriber`),
  `crm.user_contact_mapping_settings_config` (`UserContactMappingSettingsConfigSubscriber`).

## Event
- `UserContactMappingEvent` (`src/Event/`) — dispatched around user→contact mapping so other
  modules can influence lookup/creation.

## Plugins to extend or reuse
- Field type `crm_relationship_statistics`; formatters `crm_age`,
  `crm_relationship_statistics_default`.
- Entity-reference selection `valid_contacts` (`ValidContactsSelection`, honors a relationship
  type's valid-contact / contact-type rules) and `default:crm_method_detail`
  (`MethodDetailSelection`).
- Validation constraints `RelationshipContacts`, `RelationshipLimit`.
- Search plugin `crm_contact_search` (`Plugin/Search/ContactSearch.php`).
- Group relation `group_crm_contact` (`Plugin/Group/Relation/GroupContact.php`, deriver) for
  Group module integration.
- Views: field `UserContactMappingField`, filter `RelationshipStatisticsType`.
- Menu plugins: `NavigationDeriver` (navigation toolbar items), `RelationshipTask`/`CommentTask`
  local tasks, `AddRelationshipLocalAction`.

## Drush (`drush.services.yml`, `src/Commands/CrmCommands.php`)
- `crm:recalculate-statistics` (alias `crm-rs`, `--batch-size`) — recompute relationship
  statistics for all contacts via `RelationshipStatisticsService::recalculateAll()`.
- `crm:generate-simpsons-recipe` (alias `crm-gsr`) — regenerate the `recipes/crm_simpsons`
  content YAML from the bundled `tests/simpsons/*.csv` (stable UUID v5, contacts/methods/
  relationships).

## Utilities
- `Utility/FieldValueSanitizer` — replaces `_none` select placeholders with `''` and normalizes
  date-only fields (`start_date`/`end_date`) to `Y-m-d`.
- `Utility/InlineEntityFormValueExtractor` — pulls in-progress IEF entities out of widget state
  (used so contact methods added on a user form persist even when the inline "Create" button was
  not clicked).
