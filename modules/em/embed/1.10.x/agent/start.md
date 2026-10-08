# embed — agent start

Framework for CKEditor "embed buttons" (CKEditor 4 + 5). Defines the `embed_button`
config entity and the `EmbedType` plugin type; other modules (Entity Embed, Media) build on
it. Manage buttons at **Admin → Config → Content authoring → Embed buttons**
(`/admin/config/content/embed`, route `entity.embed_button.collection`).

- Manage embed buttons + icon-upload settings → [configure/buttons.md](configure/buttons.md)
- Define an `EmbedType` plugin (new embed kind) → [plugins/embed-type.md](plugins/embed-type.md)
- CKEditor integration + AJAX preview/insert API → [api/api.md](api/api.md)
- Alter registered embed types via hook → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
