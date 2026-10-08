# Configuration

There is no global settings page. You configure reactions in three places: the
**field** (per bundle), the **formatter** (per display), and the **reactions
themselves** (Voting API vote types). Then you grant the per-field permissions.

## 1. Add the Reaction field

Go to the bundle you want reactions on — for example **Structure → Content types →
Article → Manage fields** — and add a field of type **Reaction**. A few notes:

- The field's **cardinality is forced to 1** (the module hides the cardinality
  control), because a user has one current reaction per entity.
- The default **widget** and **formatter** are both *"Voting API Reaction"*.

### Field settings

On the field settings you control:

- **Anonymous detection** *(default: both cookie and IP)* — how the module
  recognises anonymous voters, so the same visitor isn't counted twice. You can
  detect by cookie, by IP address, or both.
- **Anonymous rollover** *(default: use Voting API's setting)* — how long before an
  anonymous visitor may react again. The default defers to Voting API's own
  *anonymous window*; you can also set it to never roll over, or a specific number
  of seconds.
- **Reactions** — which of the available reactions this field offers, plus each
  one's visibility and weight (order).

### Per-entity status

Each entity's Reaction field also stores a **status** you set on the entity's edit
form, much like core comment status:

- **Open** — users can react.
- **Closed** — existing reactions are shown read-only; no new ones.
- **Hidden** — the reaction widget doesn't appear on that entity at all.

## 2. Formatter settings (Manage display)

On the bundle's **Manage display** tab, configure the *Voting API Reaction*
formatter:

- **Show summary** *(default on)* — the "N reactions" summary line above the
  buttons.
- **Show icon / Show label / Show count** *(each default on)* — toggle each part of
  a reaction button independently.
- **Sort reactions** *(default: by configured weight)* — keep your manual order, or
  auto-sort ascending/descending by vote count (popularity).
- **Reactions** — per-display visibility overrides for individual reactions.

## 3. Define your reactions (Voting API vote types)

Reactions *are* Voting API **vote types**. Go to Voting API's vote-types admin and
add or edit a type. This module adds these controls to that form:

- **Use as a Reaction** — only vote types with this ticked appear as reactions.
- **Icon type** — one of:
  - **Uploaded image** — upload an SVG, PNG, or WebP; it's stored as a permanent
    file.
  - **Remote image** — point at an image URL.
  - **HTML element** — render an `i`, `span`, or `div` (pair this with an icon-font
    class such as Font Awesome).
- **Icon class** — a CSS class added to the icon/element (used with icon fonts).

The six shipped defaults come as SVGs; their images can be replaced but not
removed. Deleting a reaction vote type also removes its uploaded icon file.

## 4. Grant permissions

Permissions are **dynamic** — a fresh set is generated for **every** field, named
after the entity type, bundle, and field. For a field `field_reaction` on
`node:article` you'll see, under **People → Permissions**:

- **View reactions on node:article:field_reaction** — see the widget and results
  at all.
- **Create reaction on node:article:field_reaction** — cast a first reaction.
- **Modify reaction on node:article:field_reaction** — change or remove an existing
  reaction.
- **Control reaction status on node:article:field_reaction** — set the per-entity
  Open/Closed/Hidden status.

None of these are restricted permissions, so they're safe to grant to anonymous,
authenticated, or editor roles. To let people react, grant **view** and **create**
(and usually **modify**). Note that defining reactions (the vote types and their
icons) is governed by Voting API's own vote-type administration permission, not by
these.

## How a reaction is cast

The formatter renders an AJAX radio form. Choosing a reaction creates a vote for
the current user (or switches/removes it if they pick the same one again),
remembers it — in the session for anonymous users — and recalculates the counts.
Everything is subject to the per-field permissions and the entity's Open/Closed/
Hidden status above.

## Theming (optional)

Reaction buttons render through the `votingapi_reaction_item` theme hook. To change
the markup or classes, copy `templates/votingapi-reaction-item.html.twig` into your
theme and adjust it; base styles live in the module's `css/votingapi_reaction.css`.
