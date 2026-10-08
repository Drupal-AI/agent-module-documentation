# Configuration

Getting RSVP List working is three short steps: choose which content types can have
RSVPs, place the RSVP block so the form appears, and set who's allowed to do what.

## Step 1 — Choose the content types that allow RSVPs

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → RSVP List**
   (`/admin/config/content/rsvplist`).
3. Select the **content types** on which an RSVP option should be available (for
   example *Event*), and save.

Once a content type is enabled here, the RSVP option can be turned on while editing a
node of that type.

## Step 2 — Place the RSVP block

The sign‑up form is delivered as a **block**, so it shows up wherever you place it:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **RSVP** block and click **Place block** in the region you want (for
   example the content or sidebar region).
3. Configure the block's visibility — typically restrict it to the relevant content
   type(s) or specific pages so the form only appears on your event nodes.
4. Save the block.

Visitors on an RSVP‑enabled node will now see the form and can submit their email to
confirm attendance.

## Step 3 — Set permissions

The module respects Drupal's permission system, so decide who can RSVP and who can
manage the lists:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant the RSVP‑related permissions to the appropriate roles — for example allowing
   **anonymous** and **authenticated** users to submit an RSVP, and reserving the
   administrative/reporting permissions for trusted roles.
3. Save.

Block visibility (Step 2) and these permissions together control where the form shows
and who can use it.

## Reviewing responses

Collected RSVPs — from both anonymous and registered users — are available to
administrators in the site's **Reports**, where you can see who responded to each
event and their contact details. Use this as your attendee/contact list.
