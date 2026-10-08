# facets_range_widget — agent start

Facets submodule. Adds **slider / range-slider widgets** for numeric facets. Requires
`facets`, `jquery_ui_slider`, `jquery_ui_touch_punch`. No config UI of its own — select the
widget on a facet's settings form at `/admin/config/search/facets`.

Source (widget + processor plugins for the main facets plugin types):
- `src/Plugin/facets/widget/SliderWidget.php` (single handle), `RangeSliderWidget.php` (min/max).
- `src/Plugin/facets/processor/SliderProcessor.php`, `RangeSliderProcessor.php` — compute bounds.
- Config schema `config/schema/facets_range_widget.schema.yml`; CSS/JS in `css/`, `js/`.

No permissions, hooks, services, or new plugin types. To implement custom widgets/processors
see the main facets [plugins docs](../../../facets/3.0.x/agent/plugins/widget-processor.md).
