# Configuration

Rater8 Testimonials Block has no central settings form. You configure it per
placement, right where you place the block.

## Place the block

1. Log in as a user who can administer blocks.
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Choose the region where the testimonials should appear and click **Place
   block**.
4. Find the **Rater8 Testimonials** block in the list and click **Place block**
   next to it.

## Set the Rater8 ID

In the block's configuration form:

- **Rater8 ID** — enter the ID from your Rater8 account that identifies the
  testimonials to display. This is required: without it the block has nothing to
  show. It is a Rater8 widget identifier used to render the testimonials, not a
  private API secret, so you can enter it directly here — there's no need to store
  it as an environment variable or a Key.

- Configure the usual core block options as needed — the **title**, and the
  **Visibility** conditions (which pages, content types, roles, or languages the
  block shows on).

Click **Save block**.

## Verify

Visit a page in the region where you placed the block. You should see the Rater8
testimonials for the ID you entered. If nothing appears, double-check the ID
against your Rater8 account.
