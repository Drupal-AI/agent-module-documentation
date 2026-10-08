ECK Site Settings turns Entity Construction Kit (ECK) entities into global, site-wide singleton "settings" pages that editors manage through fields and developers read through a service, Twig function, or tokens.

---

It is a content-entity alternative to config-based tools like Site Settings and Labels or Config Pages. On install it creates a `settings` ECK entity type flagged as a settings type (third-party setting `eck_site_settings.enabled = TRUE`) plus a `general` bundle. Any ECK entity type can be turned into a settings type by ticking "Use this entity type for site settings" on its edit form, which also forces standalone URLs off. Each settings bundle behaves as a lazily-created singleton entity: the first time it is requested it is created, and every later request loads the same one. Editors reach them from an overview at `/admin/content/site-settings` and from an admin-menu tree; both link to the ordinary ECK entity edit form, so field values are edited with normal Field UI widgets. Developers fetch a settings entity with the `eck_site_settings.settings_repository` service (`getSetting()` / `getSettingByClass()`), the `site_settings()` Twig function, or `[eck_site_settings:<type>-<bundle>:<field>]` tokens. Because settings are content entities, the fields you add can be anything Field UI offers — text, rich text, links, media, entity references — and they support translation. A submodule (ECK Site Settings per Domain) makes a bundle's values vary per domain, and a ModuleMigration service imports existing data from the site_settings or wmsettings modules.

---

- Store a site name, tagline, or contact email as editable fields instead of hard-coded config.
- Build a "General" settings page by adding fields to the auto-created `general` bundle.
- Give editors a footer-content settings page (address, phone, social links) rendered in a template.
- Keep global call-to-action text and a target link that marketers can change without a deploy.
- Manage a site-wide announcement/alert banner (body + on/off boolean + date range fields).
- Expose theme-adjacent values (logo image, brand color, favicon) as media/text settings fields.
- Group related settings into separate bundles (SEO, Social, Contact) each with its own edit page.
- Create additional settings ECK entity types to group many bundles, shown grouped in the admin menu.
- Render a rich-text "About" blurb from settings in Twig via `site_settings('general').field_about|view`.
- Read raw setting values in templates through the field/property combination, e.g. `.field_x.value`.
- Pull a settings image URL into a template with Twig Tweak's `file_uri` / `image_style` filters.
- Reference settings field values from other modules through tokens (`[eck_site_settings:settings-general:field_x]`).
- Load a settings entity in PHP: `\Drupal::service('eck_site_settings.settings_repository')->getSetting('general')`.
- Fetch a setting by its bundle entity class with `getSettingByClass()` when using custom ECK bundle classes.
- Provide multilingual settings by adding translatable fields; the repository returns the current content language's translation.
- Alter which settings variant is loaded (e.g. always English, or per-domain) via `hook_eck_site_setting_context_alter()`.
- Inject extra load/create values for settings entities with `hook_eck_site_setting_values_alter()`.
- Restrict who can open the overview with the "Access site settings overview" permission, delegating edit rights to ECK entity permissions.
- Delegate per-bundle edit control by adding the ECK Bundle Permissions module.
- Make selected settings bundles domain-specific with the eck_site_settings_domain submodule (Domain module integration).
- Migrate an existing Site Settings and Labels install into ECK settings from a deploy hook using `module_migration->fromSiteSettings()`.
- Migrate a legacy wmsettings install with `module_migration->fromWmSettings()`.
- Prevent accidental data loss: settings entities cannot be manually created, cloned, or deleted through the UI.
