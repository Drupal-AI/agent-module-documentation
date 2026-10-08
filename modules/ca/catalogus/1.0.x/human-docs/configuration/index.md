# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Catalogus**, or navigate directly
   to `/admin/config/content/catalogus`.

## Provincial community ID

The key setting on this form is your **Provincial community ID** — the identifier
of the top-level (provincial) community that the catalogue is organized around.
Record it here so the module knows which community sits at the head of your
records.

## Exporting catalogue pages to PDF

Dominican Catalogus wires up Entity Print, so catalogue content can be exported
as PDF:

- Individual catalogue nodes and configured views are exported at
  `catalogus/pdf`.
- This is what lets you print a province directory as a booklet.

PDF generation relies on the Entity Print module and its configured print engine
— confirm Entity Print is set up (it is installed as a dependency) if exports do
not render.

## Address display

The module ships an **AddressHideUSAFormatter** field formatter. On an address
field's **Manage display**, choose this formatter when you want "USA" hidden from
the rendered address (useful for a catalogue whose home country is the United
States, where repeating the country on every entry adds noise).

## A note on the community "back-on" link

The module registers a `/community/{cid}/back-on/{date}` route. It is gated only
by the **access content** permission — which anonymous users hold by default — so
it is effectively public. In this release it returns only placeholder markup, so
there is no sensitive data behind it; keep it in mind if you build real
functionality onto that route later.
