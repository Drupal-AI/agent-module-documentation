# responsive_preview — agent start

Adds a toolbar tab that reloads the current page in a resizable iframe at device dimensions.
Devices are `responsive_preview_device` config entities (Phone, Tablet Portrait, Tablet
Landscape, Desktop ship by default). Also ships a "Responsive preview controls" block and an
optional Navigation submodule (`responsive_preview_navigation`). Configure route:
`entity.responsive_preview_device.collection` → `/admin/config/user-interface/responsive-preview`.

- Device config entity: fields, defaults, add/edit/delete routes, drush config →
  [configure/responsive_preview.md](configure/responsive_preview.md)
- The `responsive_preview` service, preview URL / query flag, render-array list, block, AJAX node preview →
  [api/responsive_preview.md](api/responsive_preview.md)
- The two permissions and what they gate →
  [permissions/responsive_preview.md](permissions/responsive_preview.md)

Submodule (nested): **responsive_preview_navigation** →
`modules/responsive_preview_navigation/2.3.x/agent/start.md`
