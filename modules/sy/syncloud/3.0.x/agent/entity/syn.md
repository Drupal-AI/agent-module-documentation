<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `syn` entity

`Drupal\syncloud\Entity\Syn` is a `@ContentEntityType` (id `syn`, base table `syn`,
`admin_permission = "administer syn"`). It is the per-event tracking record created by the
subscriber/hooks (see [api/event-queue-flow.md](../api/event-queue-flow.md)) and also manageable
by hand in the admin UI. It extends `Utility\ContentEntity` (which supplies the name/host/scheme/
status/owner/created getters+setters and, in `preCreate`, defaults `uid` to the current user).

## Base fields (`Syn::baseFieldDefinitions`, built via `Utility\FieldDefinition`)

| Field | Type | Notes |
| --- | --- | --- |
| `name` | string | Label field; hooks set it to `"<ip>--<form_id/type>"`. |
| `mode` | string | From the `synhelper` request cookie, else `default`. |
| `host` | string | Request host. |
| `scheme` | string | Request scheme. |
| `status` | boolean | Default TRUE (`isEnabled()`). |
| `uid` | entity_reference → user | Author (owner). |
| `created` / `changed` | created / changed | Timestamps. |
| `syn_id` | string | Default = `Syn::matomoCallback()` (Matomo `_pk_id*` cookie id). |
| `type` | string | Source type: `commerce_order`, `webform_submission`, or the entity type id. |
| `message` | entity_reference → `contact_message` | Holds the source entity id. |
| `ip` | string | Client IP. |
| `city` | string | Set empty (`[]`) by the hooks. |
| `url` | string | Absolute URL (alias) of the request path. |
| `extra` | map | Default = `Syn::extraCallback()` → `_ga`, `_ym_uid`, `_ct_session_id` cookies. |

`matomoCallback()` scans request cookies for a key starting `_pk_id` and returns the part before
the first `.`. `extraCallback()` collects the Google/Yandex/Calltouch tracking cookies.

## Handlers

- `view_builder`: `SynViewBuilder` — adds a trivial `hello => "world"` markup on the `full` view
  mode (placeholder). Template `syn.html.twig` + `template_preprocess_syn`.
- `list_builder`: `SynListBuilder` — table with ID, Title (link), Status, Author, Created, Updated,
  and a "Total syns: N" summary. Query uses `accessCheck(TRUE)`.
- `access`: `SynAccessControlHandler` (see below).
- `form`: `add`/`edit` = `SynForm` (redirects to the canonical route after save and logs a notice);
  `delete` = core `ContentEntityDeleteForm`.
- `route_provider.html`: core `AdminHtmlRouteProvider`.

## Routes & links

From the annotation `links` + route provider:
- `add-form` `/admin/synapse/syn/add`
- `canonical` `/admin/synapse/syn/{syn}`
- `edit-form` `/admin/synapse/syn/{syn}/edit`
- `delete-form` `/admin/synapse/syn/{syn}/delete`
- `collection` `/admin/content/syn` (also a Content tab; action link "Add syn").

## Access & permissions

`SynAccessControlHandler::checkAccess()`:
- `view` → requires `view syn`.
- `update` → `edit syn` OR `administer syn`.
- `delete` → `delete syn` OR `administer syn`.
- other operations → neutral.
`checkCreateAccess()` → `create syn` OR `administer syn`.

Permissions (`syncloud.permissions.yml`): `administer syn` (`restrict access: true`),
`access syn overview`, `create syn`, `view syn`, `edit syn`, `delete syn`. Note the entity's
`admin_permission` is `administer syn`, so that permission is a catch-all for entity operations.

The collection list lives at `/admin/content/syn` (Content › Syn tab).
