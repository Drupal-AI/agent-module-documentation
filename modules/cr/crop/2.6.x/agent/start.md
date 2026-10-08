# crop (Crop API) — agent start

Storage + API for image crops. **API-only** — no editing UI; pair with a UI module
(Image Widget Crop, Focal Point). Defines `crop_type` (config entity, presets) and `crop`
(content entity, per-image coordinates) plus a `crop_crop` image effect. Config UI:
**Admin → Config → Media → Crop** (`/admin/config/media/crop`, route `crop.overview_types`).

- Create/manage crop types + settings → [configure/crop-types.md](configure/crop-types.md)
- Find/create crops in code (Crop entity API) → [api/crop-entity.md](api/crop-entity.md)
- Add crop support for a new entity type (plugin) → [plugins/entity-provider.md](plugins/entity-provider.md)
- Alter provider info via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
