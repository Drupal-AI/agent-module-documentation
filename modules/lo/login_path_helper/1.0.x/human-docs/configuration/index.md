# Configuration

There are two parts to setting up Login Path Helper: the small settings form (the
link text and URL prefix), and placing the block in your theme so visitors can see
it.

## Step 1 — The settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/config/login_path_helper`**.

Two fields:

- **Link name** — the visible text of the login link. Default: **"Site Login"**.
- **URL prefix** — the path the link points at, before the current page is appended
  as the destination. Default: **`user/login?destination=`**. For a SAML SSO setup,
  set this to **`saml_login?destination=`** (or whatever your external login route
  is) so the identity provider round‑trip returns the user to the page they were
  on. You can also point it at a reverse‑proxy login path if your setup routes login
  that way.

Save the form. The link rebuilds on every request (its cache max‑age is 0), so the
`destination` always reflects the visitor's current page.

## Step 2 — Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Login Path Helper** block in the region you want — a header,
   sidebar, or footer.
3. In the block's settings:
   - Set the **role visibility** so the block shows only to **Anonymous
     (not‑logged‑in) users** — a "log in" link is meaningless to someone already
     authenticated.
   - **Uncheck "Display title"** so only the link renders.

Optionally, create a second, plain "Log Out" block shown to the Authenticated role,
so authenticated users get the complementary action.

## Verify

As an anonymous visitor, browse to an interior page and confirm the login link's
target includes `?destination=<that page>`, and that clicking it (through your
normal or SSO login) returns you to where you started.
