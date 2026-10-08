BAT Group is a placeholder/skeleton submodule intended to add "group" features to BAT — grouping units so an action can apply to many units at once. As shipped in 11.0.x it registers a single `bat_group.service` (`Group`) whose methods are unimplemented stubs (`@todo`), so it provides the wiring but not yet the behaviour.

---

The module declares one service, `bat_group.service` (class `Drupal\bat_group\Service\Group`,
constructed with `entity_type.manager`), exposing three methods: `unitBelongs($unit_id, $group_id)`
(does a unit belong to a group — currently returns `FALSE`), `getUnits($group_id)` (active units in a
group — currently returns `[]`), and `unitGroups($unit_id)` (groups a unit belongs to). All three are
marked `@todo` and return empty defaults, and the `.module` file contains only a `@todo` comment
about moving group-related code out of the main BAT module. There are no entities, routes,
permissions, config, or UI. It depends on `bat_unit`. Treat it as a forward-looking extension point:
the service id and method signatures exist to build on, but calling them today yields no data. Do not
rely on it for real grouping logic until the methods are implemented upstream; the base `bat` module's
`bat_type_group` entity is the currently-functional grouping mechanism.

---

- Reserve the `bat_group.service` service id for future BAT unit-grouping features.
- Provide the intended `unitBelongs($unit_id, $group_id)` API surface (stub: returns FALSE).
- Provide the intended `getUnits($group_id)` API surface (stub: returns []).
- Provide the intended `unitGroups($unit_id)` API surface (stub).
- Act as an extension point to move group logic out of the main `bat` module.
- Signal the planned "apply an action across many units" grouping model.
- Depend on `bat_unit` so unit entities are available to a future implementation.
- Serve as a place to add group entities/config later without a new module.
- Let integrators inject `bat_group.service` and override the class with a working implementation.
- Document that real grouping today uses the base module's `bat_type_group` entity, not this service.
- Avoid runtime errors by returning safe empty defaults from every method.
- Give a stable method signature set (`unitBelongs`, `getUnits`, `unitGroups`) to code against.
- Mark the module's group features as not-yet-implemented (`@todo`) for maintainers.
- Provide a target for contribution if group features are needed.
- Keep the BAT suite's module layout ready for grouping without restructuring.
- Enable/disable independently of other BAT submodules.
