# content_lock — agent start

Pessimistic locking for content entities: locks an entity's edit form while one user edits it
(`hook_form_alter` + the `content_lock` service, storing locks in the `content_lock` table) so
others get a disabled form and can't cause edit conflicts. Requires only Drupal core. Config UI:
**Admin → Config → Content authoring → Content lock** (`/admin/config/content/content_lock`);
settings route `content_lock.settings`.

- Enable locking per entity type/bundle, translation-level lock, form-operation lock, timeout, verbose → [configure/content_lock.md](configure/content_lock.md)
- Permissions (administer settings, break lock) → [permissions/content_lock.md](permissions/content_lock.md)
- Lock/release in code (the `content_lock` service), events, and the lockability hook → [api/content_lock.md](api/content_lock.md)
