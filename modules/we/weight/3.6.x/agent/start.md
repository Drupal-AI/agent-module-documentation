# weight — agent start

Provides a single `weight` field type for manually ordering any fieldable entity. The field
stores a signed integer; the **Weight Selector** widget (`weight_selector`) offers a select
list from `-range` to `+range` (range default `20`). Display order comes from sorting a query
or View ascending by the field value. Depends only on core `field`. No config UI, permissions,
services, or plugin types of its own.

- Add a weight field to a bundle, set Range / Unsigned, sort a View by it → [configure/weight.md](configure/weight.md)
- Drag-and-drop reorder via a Views table (Weight Selector Views field) → [theming/weight.md](theming/weight.md)
