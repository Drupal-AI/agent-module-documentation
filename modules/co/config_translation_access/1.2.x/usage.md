Configuration Translation Access adds one permission, `translate editable configuration`, that grants access to a config item's translation routes (add/edit/delete/overview) whenever the user already has access to edit the original (base) config route — so you can let a role translate config without granting the sweeping `translate configuration` permission.

---

Core's `config_translation` gates every translation route behind the single, very broad `translate configuration` permission, which lets a user translate *all* configuration regardless of whether they can edit the underlying item. This module narrows that: it decorates the two core config-translation access services (`config_translation.access.overview` and `config_translation.access.form`) with `Drupal\config_translation_access\ConfigTranslationAccess`, which extends core's `ConfigTranslationOverviewAccess`. The decorator first calls the inner (core) access check; if that returns Allowed or Forbidden it defers to it unchanged. Only when the inner result is **Neutral** and the account holds `translate editable configuration` does it resolve the config mapper for the route and call `access_manager->checkNamedRoute()` on the mapper's **base route** (the original config edit form) for that account — granting translation access only if the user can access that base route. The result is cached per permissions (`cachePerPermissions()`). The net effect is a least-privilege model: a role that can edit, say, a content type or a view can also translate it, but cannot translate config it has no edit rights to. The permission is flagged `restrict access: true` (it can broaden reach to whatever base routes the user can hit, so treat it as a trusted grant). No config UI, no schema, no Drush — install, enable, and assign the permission.

---

- Let a translator/editor role translate only the configuration it can already edit, not all config.
- Avoid handing out core's all-or-nothing `translate configuration` permission.
- Grant a content-type manager the ability to translate the content types they administer.
- Grant a Views admin the ability to translate the views they can edit.
- Grant a menu/menu-link editor translation rights to those menus without global config-translation access.
- Build a least-privilege multilingual editorial workflow tied to existing edit permissions.
- Keep translation access automatically in sync with edit access as you change roles (no separate grant per item).
- Delegate field/label/description translation to site builders scoped to their own config.
- Provide config translation on a multisite/multi-team setup where teams edit disjoint config.
- Let a role translate block, taxonomy vocabulary, or image style config only where it holds the base edit permission.
- Replace bespoke access hooks that tried to restrict `config_translation` route access.
- Layer on top of core `config_translation` without patching or overriding its routes.
- Reason about who can reach a translation form by pointing at the base route's own access rules.
- Audit translation access via a single permission plus existing per-item edit permissions.
- Combine with Content Translation for a full "edit what you own, translate what you own" model.
