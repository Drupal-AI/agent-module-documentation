# imageapi_optimize — agent start

Optimization *pipelines* (ordered processor plugins) attached to core image styles.
Pipelines are config entities managed at **Admin → Config → Media → Image Optimize
pipelines** (`/admin/config/media/imageapi-optimize-pipelines`, route
`entity.imageapi_optimize_pipeline.collection`). Actual optimizers ship as separate
processor plugins.

- Create pipelines, set default, use per image style → [configure/pipelines.md](configure/pipelines.md)
- Write a processor plugin → [plugins/processor.md](plugins/processor.md)
- Alter available processors (hook) → [hooks/hooks.md](hooks/hooks.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
