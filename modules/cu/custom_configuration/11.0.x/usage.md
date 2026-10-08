<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Configuration lets an administrator store an unlimited number of named configuration values in a dedicated database table, each keyed by a machine name plus one or more domains and languages, and read them back anywhere through the `custom.configuration` service.

---

Unlike core configuration, Custom Configuration keeps its values in a custom SQL table (`custom_configuration`, created by `hook_schema()` in `custom_configuration.install`) rather than in config objects, and it makes each value context-aware: a single machine name can hold a different value per domain and per language. An admin adds entries through a small UI at **Configuration → System → Custom Configuration** — an "Add Custom Configuration" form (`ConfigurationForm`) captures a human key name (auto-converted to a machine name by `ConfigurationHelper::createMachineName()`), a main value, up to four optional values, an Active/Inactive status, and, when more than one language exists or the contrib **Domain** module is installed, language and domain multi-selects. A list form (`CustomConfigurationList`) shows every stored entry with Edit/Delete links, and dedicated edit and delete forms handle updates and removal. All four routes live under `/admin/config/system/custom_config…` and require the `administer site configuration` permission. Values are read at runtime with `\Drupal::service('custom.configuration')->getValue($machine_name, $langcode, $domain_key)`, which returns the stored string for the current (or requested) language and domain when the entry is **Active**, or `NULL` when the machine name does not exist, is inactive, or does not match the context; `getValues()` returns the same plus the four optional values (unserialized with `allowed_classes => FALSE`), the resolved name, and the language/domain arrays. When language or domain are omitted the service resolves them from the current language (`language_manager`) and, if the Domain module is enabled, the active domain (`domain.negotiator`); otherwise the domain defaults to the literal key `default`. Uniqueness is enforced per machine-name + domain + language combination (a unique DB key plus an application-level duplicate check), so the same key can coexist across contexts but not collide within one. It is an administration/configuration utility with no access-control behaviour of its own; because entries are ordinary stored config, avoid keeping real secrets (API keys, passwords) in it.

---

- Store an unlimited number of named configuration values without writing custom config schema.
- Read a value anywhere in code with `\Drupal::service('custom.configuration')->getValue('machine_name')`.
- Hold a different value for the same key on each domain of a Domain-module multi-site.
- Hold a different value for the same key in each site language.
- Keep small site-wide settings (support phone, banner text, feature toggles) editable by admins without a deployment.
- Store third-party keys/handles such as social-media or analytics identifiers per domain (non-secret values only).
- Toggle a value on or off with the Active/Inactive status instead of deleting it.
- Return `NULL` automatically for inactive or non-existent keys so calling code can fall back cleanly.
- Attach up to four optional companion values (label, hours, notes) to a primary value.
- Retrieve a value plus all its optional values and metadata in one call with `getValues()`.
- Let the service auto-resolve the current language and active domain when you don't pass them.
- Explicitly request another language's or another domain's value by passing the langcode/domain key.
- Auto-generate a safe machine name from a free-text key name via the built-in slugifier.
- Prevent duplicate keys within the same domain + language combination.
- Provide the same key across many domains/languages while keeping each value independent.
- Manage all entries from a single admin list with inline Edit and Delete actions.
- Add per-context configuration that core's simple/config API doesn't neatly cover.
- Store JSON- or string-formatted values (the form accepts either; parsing is up to your code).
- Give editors a lightweight place to maintain contextual content strings.
- Migrate ad-hoc "settings variables" into a queryable, context-aware store.
