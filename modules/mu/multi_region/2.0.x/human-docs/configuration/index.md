# Configuration

Getting Multi Region working is a short sequence: make sure your languages exist,
define your regions and assign languages to them, then place the block that lets
visitors pick a region and language.

## 1. Add your languages

Regions group languages, so you need the languages first. Go to
**Configuration → Regional and language → Languages**
(`/admin/config/regional/language`) and add each language your site offers, if you
have not already.

## 2. Define regions and assign languages

1. Log in as a user with permission to manage regions (the module provides its own
   permission — grant it on **People → Permissions** to the appropriate roles).
2. Go to **Configuration → Regional and language → Regions**.
3. **Add** a region, give it a name, and **select the languages** that belong to
   it. Repeat for each region you want (for example one region per continent or
   market).
4. Save your regions.

## 3. Place the block

The module provides a block that shows the regions and the languages belonging to
the selected one.

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** for the region of your theme where you want it (a header
   is common so it appears site‑wide).
3. Choose the Multi Region block, configure its visibility if needed, and **Save
   block**.

Visitors can now pick their region and then a language within it. If you prefer,
you can also use the region grouping programmatically instead of the block.

## A note on scope

The regions here group **languages** for selection and presentation. They are not
an access‑control mechanism on their own. If you intend to use regions to segment
which content people see, verify that the grouping behaves correctly alongside your
content access and publishing rules before relying on it.
