<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Settings and Labels lets a site builder define arbitrary "settings" as fieldable content entities, so clients can edit things like a phone number, a footer strapline or a list of social links without touching configuration.

---

The module defines a fieldable, revisionable, translatable content entity `site_setting_entity` whose bundles are the config entity `site_setting_entity_type` — so the *shape* of each setting (its fields, form display and view display) is version-controlled config while the *values* are content. A second config entity, `site_setting_group_entity_type`, groups settings ("Footer settings", "Social") for both the admin menu and bulk loading, and each bundle carries a `multiple` flag that decides whether editors may create more than one entity of that type. Settings reach templates through a **SiteSettingsLoader plugin** (plugin manager `plugin.manager.site_settings_loader`, annotation `@SiteSettingsLoader`, discovered in `Plugin/SiteSettingsLoader`): the `full` loader returns real entity objects and is the recommended one, while the legacy `flattened` loader flattens everything into nested arrays and auto-loads them into every template variable named by `site_settings.config:template_key` (default `site_settings`) via `hook_preprocess()`. On top of the full loader sit six Twig functions — `site_setting()`, `site_settings_by_name()`, `site_setting_field()`, `site_setting_entity_by_name()`, `site_settings_by_group()` and `all_site_settings()` — plus two blocks (`simple_site_settings_block`, `single_rendered_site_settings_block`) and a full token integration that exposes both flattened values (`site_settings` token type) and whole entities (`site_settings_entity`). Ten permissions govern create/edit/delete/view and revision operations, with the `site_settings_type_permissions` submodule adding the same per-bundle. Admin UI lives at `/admin/content/site-settings` (the values), `/admin/structure/site-settings` (types and groups) and `/admin/config/site-settings/config` (the module's configure route), and a "Replicate" operation on a settings type mass-creates similar types via the `site_settings.replicator` service. Note that `site_settings_install()` turns **off** the legacy auto-loading (`disable_auto_loading: TRUE`) and grants `view published site setting entities` to the anonymous and authenticated roles.

---

- Let a client edit the site's contact phone number without giving them config access.
- Manage a list of social network links and render them in the header and footer.
- Store a footer copyright line the client can update themselves.
- Define reusable labels ("Read more", "Book now") that a client can reword site-wide.
- Group related settings ("Footer settings") and render the whole group in one Twig call.
- Expose a setting as a token for use in automated emails.
- Provide an editable opening-hours block backed by a multi-field setting.
- Allow multiple entries of the same setting type (e.g. several office addresses).
- Keep the *definition* of settings in version-controlled config while values stay out of it.
- Render one setting in a specific view mode with `{{ site_setting(6, 'teaser') }}`.
- Fetch a single field of a setting with `{{ site_setting_field('phone', 'field_number') }}`.
- Place a settings value in a region with the "Simple site settings block".
- Place a fully rendered setting in a region with the "Rendered site settings block".
- Translate settings per language on a multilingual site.
- Keep an audit trail of who changed a label using the entity's revisions.
- Restrict which roles can edit which setting type with the type-permissions submodule.
- Give editors a "Site settings" entry in the admin content menu grouped by settings group.
- Replicate an existing settings type into ten similar types in one batch.
- Store an image (e.g. a fallback share image) as a site setting.
- Store a boolean feature flag a client can flip without a deployment.
- Load all settings of a group in PHP with the loader plugin's `loadByGroup()`.
- Write a custom SiteSettingsLoader plugin that caches settings differently.
- Change the Twig variable name settings auto-load into (`template_key`) to avoid a clash.
- Turn auto-loading off entirely and use only the Twig functions for performance.
- Render a simplified teaser of each setting in the admin listing.
- Use settings as content in Views, since they are a normal content entity type.
