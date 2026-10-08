# tour — agent start

Guided, step-by-step tooltip tours of the site UI. Each tour is a `tour` **config entity**
listing the **routes** it shows on and an ordered list of **tips** (plugins of the `tour_tip`
type) that attach to DOM **selectors**. Rendered with Shepherd.js to users holding
`access tour`. This is the maintained **contrib successor to core Tour** (core Tour is
deprecated/removed for D11+). Core requirement `^11.3 || ^12`; no module dependencies.
Config UI: **Admin → Config → User interface → Tours** (`/admin/config/user-interface/tour`,
route `entity.tour.collection`).

- Define/manage tours + tips (config entity, routes/selectors, admin UI, settings) → [configure/tour.md](configure/tour.md)
- The `tour_tip` plugin type + tip-altering hooks → [plugins/tour.md](plugins/tour.md)
- Permissions (`access tour`, `administer tour`) → [permissions/tour.md](permissions/tour.md)
- Submodule **tourauto** (auto-open unseen tours) → ../../../tour/modules/tourauto/3.0.x/agent/start.md
