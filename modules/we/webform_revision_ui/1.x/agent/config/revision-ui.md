<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Revision UI — routes, access and the revision screen

## Install & enable

```bash
composer require drupal/webform_revision_ui
drush en webform_revision_ui -y
```

Hard dependencies (`webform_revision_ui.info.yml`): `drupal:config_revision` and
`drupal:webform`. Config Revision provides the `config_revision` / `config_revision_type`
entities and the generic version-history/revert/delete screens; Webform provides the `webform`
config entity. This module ships **no config, no schema, no settings form, no Drush, no
submodules** — it is purely wiring.

A webform only gets revision history once Config Revision has recorded at least one revision, i.e.
after the webform is **re-saved** while `config_revision` is enabled. Until then the Revisions tab
is access-forbidden (see the access check below).

## The Revisions tab / route

Defined in `webform_revision_ui.routing.yml`:

```yaml
entity.webform.version-history:
  path: '/admin/structure/webform/manage/{webform}/revisions'
  defaults:
    _controller: '\Drupal\webform_revision_ui\Controller\RevisionController::revisionOverview'
  options:
    parameters:
      webform: { type: 'entity:webform' }
    _admin_route: TRUE
  requirements:
    _access_webform_revisions: 'TRUE'
    _permission: 'view all webform revisions'
```

Route access requires **both** the custom `_access_webform_revisions` check **and** the
`view all webform revisions` permission (route requirements are ANDed). The matching local task
(`.links.task.yml`) puts a *Revisions* tab (weight 55) on the webform canonical page.

## The access check

`src/Access/WebformRevisionsAccessCheck::access(WebformInterface $webform)` (service
`access_check.webform_revisions`, tag `_access_webform_revisions`):

- `ConfigRevisionType::load($webform->getEntityTypeId())` is null → `AccessResult::forbidden('Webform are not revisionable.')`.
- `ConfigRevision::loadConfigRevisionByConfigId($webform->id())` is null → `forbidden('Re-save the webform to access the revision tab.')`.
- Otherwise `AccessResult::allowed()`, with the webform / revision-type / revision added as
  cacheable dependencies.

This check only proves the webform *has* revisions; the actual "may this user see revisions"
gate is the route's `_permission: 'view all webform revisions'`.

## The overview controller (sub-request pattern)

`src/Controller/RevisionController::revisionOverview(Request $request, WebformInterface $webform)`:

1. Loads the webform's config revision: `ConfigRevision::loadConfigRevisionByConfigId($webform->id())`.
2. Resolves core's `\Drupal\Core\Entity\Controller\VersionHistoryController` via
   `controller_resolver`.
3. Builds the config revision's own `version-history` URL (`$config_revision->toUrl('version-history')`),
   creates a GET **sub-request** (carrying the original query, cookies, server and session), and
   matches it with `router.no_access_checks` (`$this->accessUnawareRouter->matchRequest()`) to
   populate route attributes.
4. Pushes the sub-request, runs the core controller inside a `RenderContext`
   (`renderer->executeInRenderContext`), pops the sub-request, applies cacheability metadata and
   returns the build.

The sub-request uses the **access-unaware** router only to resolve route *attributes* for
rendering core's list; entry to `revisionOverview()` itself is already gated by the outer route's
permission + access check, and the per-row revert/delete operation links the core list builds are
still access-checked through the entity access hook below.

## Permissions

`webform_revision_ui.permissions.yml` declares three dedicated permissions:

| Permission | Governs |
|---|---|
| `view all webform revisions` | Viewing the revisions list and individual revisions. Route gate for the Revisions tab. |
| `revert all webform revisions` | Reverting a webform config revision. |
| `delete all webform revisions` | Deleting a webform config revision. |

Their descriptions note that you also need the corresponding Webform permission (view / edit /
delete the webform) in practice. These are global ("all") permissions — not per-webform.

## Entity access hook (view / revert / delete of a revision)

The individual revision screens are Config Revision's own routes; their access flows through
`webform_revision_ui_config_revision_access(EntityInterface $config_rev_entity, string $op, AccountInterface $account)`
(`hook_config_revision_access`) in `.module`:

- Returns `AccessResult::neutral()` when the config-revision **bundle is not `webform`** (leaves
  non-webform config revisions to other modules).
- For the `webform` bundle it maps ops to permissions:
  `view` / `view revision` / `view all revisions` → `view all webform revisions`;
  `revert` → `revert all webform revisions`; `delete revision` → `delete all webform revisions`.
- If the op is mapped **and** the account holds the mapped permission → `allowed()`; otherwise
  (including any unmapped op such as an update) → **`forbidden()`**.

So on the webform bundle this hook is strict: revert and delete each require their own dedicated
permission, and anything not explicitly allowed is denied.

## Revert / delete form rerouting

Config Revision's confirm forms (`config_revision_revision_revert` /
`config_revision_revision_delete`, i.e. `RevisionRevertForm` / core `RevisionDeleteForm`) are
altered in `.module` so the user stays in the Webform UI:

- `hook_form_config_revision_revision_revert_alter` /
  `..._delete_alter` → `_webform_revision_ui_alter_config_revision_revert_or_delete_form()`.
  Guarded to only act when the config revision's type id is `webform`. A `drupal_static` flag
  makes the alter run once.
- It sets `$form['actions']['cancel']['#url']` to `entity.webform.version-history` for the
  webform, and appends `_webform_revision_ui_form_config_revision_revert_or_delete_confirm_submit`
  as a submit handler (to `#submit` on revert, to the form-level `#submit` on delete).
- That submit handler calls `$form_state->setRedirect('entity.webform.version-history', ['webform' => $config_revision->label()])`
  so, after reverting/deleting, the user lands back on the webform's Revisions tab.

These are confirm forms (POST + confirm step), so revert and delete are not one-click GET actions.

## Operating it

1. Enable `config_revision`, `webform` and `webform_revision_ui`.
2. Grant `view all webform revisions` (and `revert` / `delete` as appropriate) to trusted admin
   roles. `webform_revision_ui_update_9001()` auto-grants all three to roles that already have
   `administer config_revision` on update.
3. Edit and **save** a webform at least once so Config Revision records a revision.
4. Open the webform's **Revisions** tab at
   `/admin/structure/webform/manage/{webform}/revisions` to view history, then use the per-row
   Revert / Delete links (permission-gated) to roll back or prune revisions.
