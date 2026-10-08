# Configure the profile checkout pane

There is **no module settings page**. The pane is configured like any other Commerce checkout pane,
inside a checkout flow. One pane is derived per profile type (except `customer`), so before you can
place a pane you need at least one non-`customer` profile type
(`admin/config/people/profiles/types`).

## Placing the pane (UI)

1. Optionally create a Profile type at **Configuration → People → Profile types**
   (`admin/config/people/profiles/types/add`). The `customer` type is intentionally excluded — it is
   handled by Commerce core's billing/shipping panes.
2. Go to **Commerce → Configuration → Orders → Checkout flows** and edit a flow
   (`admin/commerce/config/checkout-flows/manage/<flow>` — e.g. `.../manage/default`).
3. The pane is titled "*&lt;Profile type label&gt; profile form*" and starts in the **Disabled**
   region (the plugin's `default_step` is `_disabled`). Drag it into a real step —
   e.g. *Order information* / *Review*. **Do not put it in the `login` step**: that step has no submit
   button for the whole form, so the inline profile form can't be submitted.
4. Set the pane settings (below) and save the flow.

## Pane settings

| Setting | Config key | Default | Meaning |
|---|---|---|---|
| Form mode | `form_mode` | `default` | Which **profile** entity form mode to render. Options come from `entity_display.repository->getFormModeOptions('profile')`. |
| Display label | `display_label` | `Edit profile` | The label shown on the `fieldset` wrapping the profile form in checkout (inherited pane setting; only its description text is customised). |

The admin summary for the pane reads `Form mode: <mode>`.

## Config storage / schema

Panes are stored on the checkout flow entity under `configuration.panes.<pane_id>`, where
`<pane_id>` is `profile_form:<profile_type_id>`. Example (checkout flow config export):

```yaml
configuration:
  panes:
    'profile_form:membership':   # profile type id = "membership"
      step: order_information
      weight: 3
      form_mode: default
      # display_label is inherited; stored when changed from the default.
```

Config schema (`config/schema/commerce_profile_pane.schema.yml`):

```yaml
commerce_checkout.commerce_checkout_pane.profile_form:*:
  type: commerce_checkout_pane_configuration   # inherits display_label, step, weight, etc.
  mapping:
    form_mode:
      type: string
      label: Form mode
```

A pane declares a config dependency on `core.entity_form_mode.profile.<form_mode>`
(`ProfileForm::calculateDependencies()`), so exporting the flow pulls the chosen form mode with it.

## Access / who sees the pane

The pane is only rendered when the current user may edit or create the profile — this is enforced by
`ProfileForm::isVisible()`, not by any permission this module defines. Grant the relevant Profile
module permissions (`create <type> profile`, `update own <type> profile`, or `update any <type>
profile`) to the roles that should fill it in. Revoking those permissions hides the pane (covered by
the module's functional tests). See [../api/plugin.md](../api/plugin.md) for the exact logic.

## Keeping derived panes in sync

Adding or deleting a profile type flushes the checkout-pane plugin cache automatically
(`hook_ENTITY_TYPE_insert`/`_delete` in `commerce_profile_pane.module`), so a new profile type appears
as a placeable pane and a removed one disappears without a manual cache rebuild.
