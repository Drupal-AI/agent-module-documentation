# linkit — agent start

Autocomplete internal/external linking for WYSIWYG editors. Profiles (config entities)
hold ordered **matcher** plugins; a **Linkit filter** rewrites `entity:node/1` refs to real
URLs. Config UI: **Admin → Config → Content → Linkit** (`/admin/config/content/linkit`,
route `entity.linkit_profile.collection`). No dependencies; no Drush.

- Create profiles, add matchers, enable on a text format → [configure/profiles.md](configure/profiles.md)
- Implement a Matcher plugin (new searchable source) → [plugins/matcher.md](plugins/matcher.md)
- Implement a Substitution plugin (how an entity resolves to a URL) → [plugins/substitution.md](plugins/substitution.md)
- Alter matcher/substitution definitions → [hooks/alter.md](hooks/alter.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
