# Bring postal code — manual setup guide

**Bring postal code** (`bring_postal_code`) speeds up address entry by filling in a
locality/place‑name field automatically as a visitor types a postcode. It uses
[Bring](https://www.bring.no/)'s free postcode lookup service to turn a postal
code into the matching place name — so on a checkout, registration, or any address
form, the "city/place" field can populate itself instead of the visitor typing it.

The lookup runs entirely in the visitor's browser. You tell the module which forms
to attach to (by form ID) and which fields are the postcode input and the
place‑name output (using jQuery selectors). When the visitor types enough
characters, the module's JavaScript sends a JSONP request straight to the Bring
service and writes the returned place name into the output field, or shows an
"Invalid postcode" message if there is no match.

One important limitation to understand: because the lookup is purely client‑side,
the module performs **no server‑side validation** — the project's own README says
this explicitly. Treat the filled‑in value as a convenience for the person typing,
not as a verified address. If a correct address genuinely matters (for example for
shipping), enforce authoritative address validation elsewhere on the server.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   the Bring client URL, which forms to attach to, the input/output selectors, the
   default country, and the trigger length.

## Where it lives in the admin menu

Its settings form is at **Configuration → Bring postal code**
(`/admin/config/bring-postal-code`), protected by the module's custom
**Access Bring postal code settings** permission. That form is the module's only
route — there is no server endpoint of its own.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings form and enter the Bring client URL, the form ID(s) to attach
   to, and the input/output selectors for the postcode and place‑name fields (see
   [Configuration](configuration/index.md)).
3. Load one of the configured forms and start typing a postcode — once you reach
   the trigger length, the place‑name field fills in automatically.
