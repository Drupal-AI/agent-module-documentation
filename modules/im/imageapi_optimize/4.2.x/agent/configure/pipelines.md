# Pipelines & settings

## Pipeline config entity
`imageapi_optimize.pipeline.*` (schema `config/schema/imageapi_optimize.schema.yml`).
Managed at `/admin/config/media/imageapi-optimize-pipelines` (routes:
collection `entity.imageapi_optimize_pipeline.collection`, add
`imageapi_optimize.pipeline_add`, edit `entity.imageapi_optimize_pipeline.edit_form`,
flush `entity.imageapi_optimize_pipeline.flush_form`). Requires permission
`administer imageapi optimize pipelines`.

Structure:
| Key | Meaning |
|---|---|
| `name` / `label` | Machine name / label. |
| `processors` | Ordered sequence; each item = `{ id, data (processor settings), weight, uuid }`. |

Add/order/configure processors via the processor sub-routes
(`imageapi_optimize.processor_add_form`, `_edit_form`, `_delete`) on the pipeline edit page.

## Default pipeline
Config `imageapi_optimize.settings` → `default_pipeline` (machine name of the pipeline used
site-wide). Set on the pipelines collection page or:
```
drush config:set imageapi_optimize.settings default_pipeline my_pipeline -y
```

## Per image style
The module provides an `ImageStyleWithPipeline` list builder / integration so an individual
core image style can be assigned its own pipeline (overriding the default). **Flush** a
pipeline after changing processors to regenerate affected derivatives.
