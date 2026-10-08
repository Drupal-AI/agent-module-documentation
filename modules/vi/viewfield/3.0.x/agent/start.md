# viewfield — agent start

Provides a `viewfield` field type: an entity-reference-to-a-View field that renders a chosen
view display inline on the host entity. Stores `target_id` (view) + `display_id` + `arguments`
(token-aware contextual filters) + `items_to_display`. Depends on core `views` and `field`.
Package "Field types". No admin UI/settings route — configured per field on Manage fields /
Manage display. **Beta** release (`8.x-3.0-beta11`).

- Add & configure a viewfield on a bundle (field settings, widget, formatters) → [configure/viewfield.md](configure/viewfield.md)
- Field type / widget / formatter internals & extension points → [api/viewfield.md](api/viewfield.md)
