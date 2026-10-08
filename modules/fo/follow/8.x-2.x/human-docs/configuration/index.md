# Configuration

Setting up Follow has three parts: defining the sitewide links, placing the
blocks, and granting permissions so the right people can manage links.

## Define the sitewide links

1. Log in as a user with the **Manage follow settings** permission (an
   administrator by default).
2. Go to **Configuration → People → Follow** (`/admin/config/people/follow`).
3. Enable the social networks you want and enter your organisation's profile URLs
   for each. These links populate the **Follow Site** block.

Save the form when you are done.

## Place the blocks

Follow provides two blocks, placed at **Structure → Block layout**
(`/admin/structure/block`):

- **Follow Site** — lists the sitewide links you defined above. It is visible on
  all pages by default; a common placement is the footer.
- **Follow User** — lists a user's own follow links. It is intended for user
  profile pages, where it shows the profile owner's links.

## Let users add their own links

Each user can manage their own social links at **`/user/{UID}/follow`** (for
example `/user/42/follow`). What they can do there depends on permissions:

- A user with **Edit own follow links** can manage their own links.
- A user with **Edit any user follow links** can manage links for any user —
  useful for editors curating member profiles.

## Permissions

Manage these at **People → Permissions**
(`/admin/people/permissions/module/follow`):

- **Manage follow settings** — change the sitewide links on the settings form.
  Restrict this to administrators.
- **Edit own follow links** — a user can add/edit their own follow links.
- **Edit any user follow links** — edit any user's follow links (for editors or
  community managers).
- **View follow links** — see follow links.

## Optional: show links in Views

Follow provides a Views field plugin, so you can add follow links as a field in a
listing — for example a member directory or an article byline. Add the field in
the Views UI when building the listing.
