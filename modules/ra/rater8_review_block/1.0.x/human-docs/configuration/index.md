# Configuration

Rater8 Reviews Block has no central settings form. You configure it per placement,
right where you place the block.

## Place the block

1. Log in as a user who can administer blocks.
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Choose the region where the reviews should appear and click **Place block**.
4. Find **Rater8 Reviews** in the list and click **Place block** next to it.

## Set the Rater8 ID

In the block's configuration form:

- **Rater8 ID** — enter the ID from your Rater8 account that identifies the
  physician (or entity) whose reviews you want to display. The block uses this ID
  to fetch and render the rating summary and reviews from Rater8's public API in
  the visitor's browser.

  This ID is a **public identifier**, not a secret. It's meant to appear in
  client-side code, so there's no need to store it as an environment variable or
  a Key — just type it into the block.

- Configure the usual core block options as needed — the **title**, and the
  **Visibility** conditions (which pages, content types, roles, or languages the
  block shows on).

Click **Save block**.

## Verify

Visit a page in the region where you placed the block. You should see the Rater8
reviews and rating summary for the ID you entered. If nothing appears, double-check
the ID against your Rater8 account and confirm the visitor's browser can reach
Rater8's API.
