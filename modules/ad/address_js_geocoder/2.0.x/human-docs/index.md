# Address js geocoder — manual setup guide

**Address js geocoder** (`address_js_geocoder`) lets a content editor turn a typed
postal address into map coordinates without leaving the edit form. It adds a
special **Address geocoder** widget for [Address](https://www.drupal.org/project/address)
fields: while editing content, the editor clicks a **Get resolved addresses**
button, the site looks the address up, and the resulting latitude/longitude are
written into a companion [Geofield](https://www.drupal.org/project/geofield) on
the same entity.

The lookup ("geocoding") happens on the server through the
[Geocoder](https://www.drupal.org/project/geocoder) module, using whichever
geocoder providers you have already configured on the target geofield. That means
any provider API key stays safely in the Geocoder provider configuration and is
never exposed to the visitor's browser. If the address resolves to several
possible locations, the editor can pick from a list of candidates, or let the
module auto-position the first match.

This is a developer/editor-facing field widget, not a module with its own settings
page. You set it up on a content type's form display, and it only appears on
entity edit forms.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module has no central settings page. Everything is configured on the content
type (or other entity) that carries the address, and it needs two fields in place:

1. An **Address** field (from the Address module).
2. A **Geofield** field on the same entity, with geocoder providers assigned. On
   the geofield's settings (Manage fields → geocoder settings) choose the geocoder
   providers you want and enable geocoding from the address field.

Then set up the widget:

1. Go to the entity's **Manage form display** (for example **Structure → Content
   types → [your type] → Manage form display**).
2. For the address field, choose the **Address geocoder** widget.
3. Open that widget's settings (the gear icon) and set **Geofield target** to the
   machine name of the geofield you want to fill.
4. Save.

Now, when someone edits that content, the address field shows a **Get resolved
addresses** button. Clicking it geocodes the typed address and offers the resolved
candidates; selecting one writes its coordinates into the geofield. An
**Automatically position on map** checkbox (on by default) applies the first
candidate for you. If the target field is misconfigured — for example the geofield
target is missing — the module shows the error in a pop-up dialog rather than
failing silently.
