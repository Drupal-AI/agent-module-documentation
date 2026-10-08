# Configuration

Webform Entity View has no global settings form. All of its configuration happens on the
**element** you add to a webform, so this page walks through adding and setting up that
element.

## Add the Entity View element

1. Go to **Structure → Webforms** and edit (or create) the webform you want.
2. Click **Add element**.
3. Choose **Entity View** — it is listed under the *Entity reference elements* category.
4. Give the element a key/title and open its **Entity settings**.

## The Entity settings

The element's settings ask you to pin down exactly what to display. There are four choices,
and the later ones update based on the earlier ones:

- **Type of item to view** — the entity type to display (for example *Content* for nodes,
  *Taxonomy term*, *Media*, *User*, or a custom entity type). Changing this refreshes the
  fields below.
- **Bundle** — narrows the selection to a single bundle of that entity type (for example the
  *Article* content type, or the *Image* media type). This determines what the autocomplete
  below will search.
- **Entity** — an autocomplete where you pick the *specific* entity to render. Start typing
  its title and select it from the suggestions.
- **View mode** — the view mode used to render the entity (for example *Teaser*, *Full
  content*, or a custom view mode you have defined). This is your lever for controlling how
  much of the entity appears — a teaser for a compact summary, full for everything.

Because this is a display element, the usual "default value" and form-display options are
removed — there is nothing for a visitor to fill in.

## How it renders

When the form is shown, the element loads the entity you chose and renders it through that
entity type's normal view builder, using the view mode you selected. On a multilingual site
it renders the translation matching the submission's language when one exists, otherwise the
entity's own language. If the entity cannot be loaded or rendering fails for any reason, the
element simply hides itself (nothing broken appears on the form) and the error is written to
the log under the `webform_entity_view` channel.

## A note on access

The entity is chosen by you, the form author, and rendered to everyone who can reach the
form — the element does not re-check whether each individual visitor is allowed to view that
specific entity. Treat it like an admin-placed block: only reference entities you are happy
for all form visitors to see. Do not use it to embed unpublished or access-restricted
content into a publicly reachable webform. Configuring the element itself requires the
webform-administration privileges needed to build or edit the webform.

## Where the settings are stored

There is no separate config schema. The element's settings are saved inside the webform's
own configuration (`webform.webform.*`), alongside all its other elements — so exporting the
webform carries the Entity View element with it.
