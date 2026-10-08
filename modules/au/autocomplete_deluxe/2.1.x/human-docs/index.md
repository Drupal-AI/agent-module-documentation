# Autocomplete Deluxe — manual setup guide

**Autocomplete Deluxe** (`autocomplete_deluxe`) replaces Drupal's plain
entity-reference autocomplete with a friendlier, jQuery UI powered tag box. As an
editor types, matches drop down in a suggestion list, and each value they pick
becomes a removable "chip" inside one shared box — click the ✕ on a chip to drop
that value. It is most often used on taxonomy "Tags" fields, but it works on any
`entity_reference` field, whether it points at terms, nodes, users, media, or a
custom entity type.

The widget reuses core's entity-reference machinery under the hood — the same
selection handlers, target-bundle restrictions, and autocomplete route — so it
respects everything you have already configured on the field; it just presents a
nicer picker. Because the widget collects all of a field's values in a single box
(separated by pressing Enter or an optional delimiter character), it is a natural
fit for multi-value and unlimited-cardinality fields. Optionally it can let
editors add brand-new referenced entities on the fly ("free tagging"), when the
field's selection handler permits auto-creation.

There is **no global settings page**. Everything is configured per field on
*Manage form display*, where you choose "Autocomplete Deluxe" as the widget and
set its options. The bundled CSS adapts to the active admin theme (Claro, Gin,
Seven), and no external jQuery UI download is required — the library ships with
the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Autocomplete Deluxe has no menu item and no settings form of its own. You use it
from any content type's form display at **Structure → Content types → *(your
type)* → Manage form display** (`/admin/structure/types/manage/<type>/form-display`),
and the same *Manage form display* tab exists for other entity types too (users,
taxonomy, media, and so on).

## How to use it

1. Add or find an **entity-reference field** on your content type (for example a
   taxonomy term "Tags" field on Articles). The widget only appears for
   entity-reference fields — it will not attach to text, number, or other field
   types.
2. Go to **Manage form display** for that bundle.
3. In the **Widget** column for your reference field, choose **Autocomplete
   Deluxe** from the dropdown.
4. Click the gear/cog icon beside the widget to open its settings, then adjust any
   of the following:
   - **Match operator** — how typed text is matched against existing values:
     *Contains* (default) or *Starts with*. Prefix matching ("Starts with") is
     usually faster on very large vocabularies.
   - **Match limit** — the maximum number of suggestions shown in the drop-down
     (default 10; 0 means no limit).
   - **Minimum length** — how many characters an editor must type before the
     suggestion list opens (default 0). Raising it reduces the number of lookup
     queries.
   - **Size** — the width of the text input (default 60).
   - **Delimiter** — an extra character (besides Enter) that separates entered
     values, so editors can paste several tags at once.
   - **Allow new terms** — when enabled, editors can create brand-new referenced
     entities as they type (free tagging). This only actually creates entities
     when the field's selection handler is set to auto-create them (for example a
     taxonomy reference configured to "Create referenced entities if they don't
     already exist").
   - **"Term not found" message** — optionally show a message naming the value
     that is about to be created.
   - **Empty-box message** — a friendly placeholder shown inside the box when the
     field has no values yet.
5. Click **Update**, then **Save** the form display.

The field now renders as a chip-style tag box on the entity's add/edit form. You
can pick a different widget per form mode (for example the deluxe box on the full
edit form and the plain autocomplete elsewhere), and switching the widget never
changes how the field's data is stored.
