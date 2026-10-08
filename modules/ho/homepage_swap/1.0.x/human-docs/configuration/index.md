# Configuration

Setting up Homepage Swap is a two‑step routine: first tell it which content types
are allowed to become the homepage, then use the swap page to promote one of them.

## Step 1 — Choose which content types can become the homepage

1. Log in as a user with permission to administer the module (an administrator by
   default).
2. Go to **Configuration → Homepage Swap → Settings**, or navigate directly to
   `/admin/config/homepage_swap/settings`.
3. Tick the **content types** that should be eligible to serve as the front page —
   for example a "Landing page" or "Campaign" type. Only pages of the types you
   select here will appear as choices when you swap.
4. Save the form.

Restricting eligibility keeps the swap list short and prevents someone from
accidentally promoting the wrong kind of content to the front page.

## Step 2 — Grant the permission

Homepage Swap provides its own permission that controls who may switch the
homepage. Because the front page is high‑visibility, keep this with trusted staff:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the Homepage Swap permission and grant it to the roles that should be
   allowed to switch the homepage (typically Administrator, and optionally a
   trusted content‑editor role).
3. Save permissions.

## Step 3 — Swap the active homepage

1. Go to **Content → Swap Homepage** (`/admin/content/swap_homepage`).
2. Pick the page you want to be the active front page from the eligible pages.
3. Confirm the switch. The module points the site's front page at the chosen page.

When you switch, Homepage Swap can **publish** the page you're promoting and
**unpublish** the one you're stepping down, so the live homepage is always the one
you intend. Reload the site's front page to confirm the new homepage is showing.
