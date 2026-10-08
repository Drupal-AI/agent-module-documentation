# webform_composite — agent start

Defines reusable custom **composite** webform elements through config (no PHP needed). A
`webform_composite` config entity stores sub-elements as YAML; each saved composite is exposed
as a derivative of one `webform_composite` WebformElement plugin, so it shows up in the element
browser and works on any form. Managed under `/admin/structure/webform/config/composite`
behind the core `administer webform` permission. No permissions.yml, no Drush; config schema present.

- Create/manage reusable composites (routes, entity, edit vs Source YAML form) → [configure/composites.md](configure/composites.md)
- The `webform_composite` element plugin + deriver that turns each entity into a placeable element → [plugins/webform-composite-element.md](plugins/webform-composite-element.md)
