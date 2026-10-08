# Configuration

This module has no settings form. Configuring it means two things: turning on
core's standalone media URL (if you need the Linkit workflow) and deciding which
roles may open the now-gated `/media/{id}` page.

## What the gate does

When enabled, the module adds an **access standalone media url** permission
requirement to core's media canonical route (`/media/{id}`). That requirement sits
*on top of* Drupal's normal media entity access — it can only make the standalone
page harder to reach, never easier. Any role that lacks the permission receives an
Access denied when it tries to open a media entity's standalone page, while media
that is *embedded* in content and Linkit's media references continue to work as
before.

## Step 1: enable the standalone media URL (if you need it)

The whole point of the standalone URL is a smoother Linkit experience, so most
sites installing this module have that core setting on. If you have not enabled it
yet, turn on the standalone media URL in your **Media settings**
(**Configuration → Media → Media settings**, `/admin/config/media/media-settings`).
With this module active, doing so no longer exposes `/media/{id}` to the public.

## Step 2: grant the permission to the right roles

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **access standalone media url** (provided by this module).
3. Tick it **only** for the roles that genuinely need to open standalone media pages
   — typically editors and other trusted, authenticated roles. Leave it unchecked
   for the **Anonymous user** role so `/media/{id}` stays hidden from the public.
4. Click **Save permissions**.

## Recommended posture

The safe default is: standalone media URL **on** (for Linkit), the permission
granted to a small set of trusted roles, and **anonymous users left without it**.
That keeps media links resolving correctly for editors while preventing anyone from
browsing your media metadata through the canonical `/media/{id}` pages. It is worth
auditing the permission grid periodically to confirm no unintended role has picked
up the permission.
