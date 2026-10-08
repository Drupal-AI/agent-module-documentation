# Configuration

Basic Layouts works as soon as it is enabled — there is nothing you *must*
configure to start using the layouts.

## Using the layouts

The layouts this module adds appear wherever Drupal lets you choose a section
layout — most commonly in **Layout Builder**:

1. Enable Layout Builder for a content type's display (**Structure → Content
   types → *(type)* → Manage display**, then *Manage layout*), or open the layout
   of an individual entity.
2. Choose **Add section**.
3. In the layout picker you will now see the Basic Layouts options (the extra
   column/section arrangements) alongside core's own layouts.
4. Pick one, then place your blocks or fields into its regions as usual.

The content inside each region is rendered under its own access rules; the layout
only defines the arrangement.

## The settings form

The module also registers its own configuration form (route
`basic_layouts.basic_layouts_config`) for the module's layout options. You reach
it with the **Administer site configuration** permission. For everyday use you
will not need to touch it — the layouts are available in the picker without any
setup — so only open it if you want to adjust the module's own options.
