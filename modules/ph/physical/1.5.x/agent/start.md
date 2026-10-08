# physical — agent start

Physical Fields provides two field types — `physical_measurement` (number + unit) and
`physical_dimensions` (length/width/height + unit) — plus a PHP value-object API for
measurements (`Weight`, `Length`, `Area`, `Volume`, `Temperature`, `Pressure`) with unit
conversion and bcmath-safe arithmetic. Depends only on core `field`. No admin UI, routes,
or permissions of its own; Drupal Commerce uses it for product weight/dimensions in shipping.

- Value objects, units, conversion & arithmetic in code → [api/physical.md](api/physical.md)
- Add a physical measurement/dimensions field + widget → [configure/physical.md](configure/physical.md)
