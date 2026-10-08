# Configuration

Matterport Embed is configured in two places: on the **fields** of the entities
where you want a tour, and — optionally — through reusable **styles** and **option
sets** that control how embeds are sized and parameterised.

## Add the field

1. Log in as a user who can administer the entity's fields (an administrator by
   default).
2. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   equivalent for another fieldable entity) and **Add field**.
3. Choose the **Matterport Embed** field type and save the field.

## Choose the widget (data entry)

On the entity's **Manage form display** tab, the Matterport Embed field uses the
module's **widget**. This is what content editors see when they add or edit
content — where they paste the Matterport showcase reference. Confirm the widget is
selected and positioned where you want it on the edit form.

## Configure the formatter (display)

On the entity's **Manage display** tab, set the field's format to the **Matterport
Embed Formatter**. The formatter's settings let you control how the tour renders,
including which **style** and **option set** to apply (see below).

## Custom styles — sizing the embed

Styles define the embed's dimensions so you can keep sizing consistent across the
site. The module supports three shapes:

- **Rectangle** — a fixed width × height (for example 400px × 200px).
- **Square** — equal width and height (for example 500px × 500px).
- **Responsive** — an aspect ratio (for example 16/9) that scales with the
  container.

Create the styles you need and then pick one in a field's formatter settings.

## Custom option sets — Matterport URL parameters

Option sets let you predefine the settings passed to Matterport's embed. Each option
set holds:

- **Custom URL parameters** as key/value pairs — the Matterport showcase parameters
  that control the viewer's behaviour and appearance.
- A few **extra settings** the module exposes for the embed.

Defining an option set once and reusing it across fields keeps your tours
consistent and avoids re‑entering the same parameters.

## A note on third‑party content

The rendered tour is loaded from **Matterport** in the visitor's browser via an
iframe. That means the usual third‑party‑embed considerations apply: the visitor's
browser contacts Matterport directly, so account for privacy and consent
requirements where relevant. The module provides its own permission but has **no
access‑control role beyond that** — it does not restrict which visitors can view an
embedded tour placed on a page.
