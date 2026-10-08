# Configuration

AddToAny is configured from a single settings form. Here you choose how big the
button icons are, which specific services (Facebook, Mastodon, email, …) appear,
how the universal "share" button looks and where it sits, any extra code you want
to inject, and which entity types display buttons at all.

## Open the settings form

1. Go to **Configuration → Web Services → AddToAny**
   (`/admin/config/services/addtoany`).
2. The **Settings** tab opens by default.

![The AddToAny settings page](../images/settings.png)

## Buttons — icon size

At the top, the **Buttons** section holds the **Icon size** field, measured in
**pixels**. This is the size of every share button icon site-wide — the default is
**32**. Set it to a smaller value such as `16` for compact buttons, or a larger
value for bigger ones.

## Service Buttons — which services show

Inside **Buttons**, the **Service Buttons** section has a **Service Buttons HTML
code** text area. This is where you list the specific service buttons you want to
appear next to the universal share button. Each service is one AddToAny anchor tag,
for example:

```html
<a class="a2a_button_facebook"></a>
<a class="a2a_button_mastodon"></a>
<a class="a2a_button_email"></a>
```

To add a service, add another `<a class="a2a_button_…"></a>` line (for instance
`a2a_button_pinterest` or `a2a_button_whatsapp`); to remove one, delete its line; to
reorder them, change the order of the lines. The help text under the field links to
AddToAny's list of available **standalone service buttons** so you can look up the
class name for any network.

## Universal Button

Expand the **Universal Button** section to control the "share" button that expands
to hundreds of services. You can choose the button **style**:

- **Default** — AddToAny's standard universal share button (the default).
- **None** — hide the universal button and show only the specific service buttons
  you listed above.
- **Custom** — supply the URL of your own button image, entered in the accompanying
  custom-image field.

You can also set the universal button's **placement** — **before** (the default) or
**after** the specific service buttons.

## Additional options

Expand **Additional options** to inject extra code for the widget: a field for
custom **CSS** and a field for custom **JavaScript**, which let you fine-tune how
the sharing buttons look or behave beyond the standard settings. Leave these empty
if you do not need them. (The **Browse available tokens** link below the sections
lets you look up token placeholders you can use in these values.)

## Entities — where the buttons appear

Expand the **Entities** section to choose which entity types display share buttons.
By default buttons are switched on for **content (nodes)**, **media**, and
**comments** — tick or untick a type to turn its buttons on or off.

## Save

Click **Save configuration** at the bottom to apply your changes.

## Where the buttons show, and how to move them

Once enabled, AddToAny attaches the share buttons to your content automatically as a
pseudo-field, so they appear on nodes (and media and comments) without any extra
setup. You can change **where** they sit:

- **Reposition on a content type** — go to the entity's **Manage display** screen
  (for example **Structure → Content types → Article → Manage display**). AddToAny
  appears there as a field named for its share buttons, so you can drag it above or
  below your real fields, or into a different display region, just like any other
  field.
- **Place it as a block** — go to **Structure → Block layout**, click **Place
  block** in the region you want, and choose the **AddToAny** share block. This lets
  you show share buttons in a sidebar or other region independently of the content.
  A separate **follow** block is also available for linking to your own social
  profiles. Each block lets you override the button size and the buttons HTML for
  that placement.
