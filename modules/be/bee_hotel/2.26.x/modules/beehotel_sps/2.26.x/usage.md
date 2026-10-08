BEE Hotel SPS is a deprecated store-wide percentage price slider for a Bee Hotel Commerce store (use the GlobalSlider price alterator instead).

---

This submodule is deprecated (info.yml lifecycle: deprecated). It let an administrator set a store-wide percentage on a field_price_slider integer field on the Commerce store; ApplyPriceSlider::apply() then adjusts a base amount by that percentage server-side. A form_alter attaches the slider widget on the store edit page. Its functionality is replaced by the GlobalSlider plugin in beehotel_pricealterators; new sites should not enable it. Requires the range_slider module and a manually added field_price_slider field.

---

- (Deprecated) apply a store-wide percentage to Bee Hotel prices.
- Adjust a base price up or down from a single store setting.
- Render a range-slider widget on the Commerce store edit form.
- Read the percentage from the store's field_price_slider field.
- Migrate to the GlobalSlider price alterator for the same effect.
