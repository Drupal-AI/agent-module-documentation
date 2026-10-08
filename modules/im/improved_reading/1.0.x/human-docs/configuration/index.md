# Configuration

Getting Improved reading working is a short, four‑part sequence: grant the
permissions, turn the effect on and tune it in the settings form, and place the
toggle button block so visitors can switch it on and off.

## Step 1 — Grant permissions

The module defines two permissions:

- **`use improved_reading`** — lets a user turn the reading effect on for
  themselves. Because this is a reading aid, it is common to grant it to the
  **Anonymous user** role so every visitor can use it.
- **`administer improved_reading configuration`** — lets a user open and change the
  module's settings form. Keep this to administrators.

Set both at **People → Permissions** (`/admin/people/permissions`) and save.

## Step 2 — Turn on and tune the effect

1. Log in as a user with **Administer improved_reading configuration**.
2. Open the **Improved reading** settings form under **Configuration**.
3. Enable the feature and adjust its options to control how the emphasis is applied
   to text.
4. Save the form.

## Step 3 — Place the toggle button block

The effect is switched on and off by visitors through a toggle button, which you add
as a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the Improved reading toggle button block in a region visitors can see (a
   header or sidebar works well).
3. Configure the block's visibility as you would any block, and save.

## Step 4 — Confirm

Load a page as a visitor who has the `use improved_reading` permission, click the
toggle button, and confirm the leading characters of words become bolder — and that
clicking again turns the effect back off.
